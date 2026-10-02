---
layout: default
title: Практическая работа — PySpark и Spark SQL, углубленные примеры
---

# Практическая работа: углубленные примеры PySpark и Spark SQL

## Цель

На прошлом занятии мы развернули PySpark в Docker + Jupyter, поработали с небольшим CSV-файлом, освоили базовые операции Spark SQL (группировка, агрегация). В этой практической работе усложняем задачи: **join нескольких таблиц**, **оконные функции (window functions)** и **пользовательские функции (UDF)**, включая обсуждение их влияния на производительность.

## Требования к окружению

Используем то же самое окружение, что и на прошлом занятии (Docker-контейнер с PySpark + Jupyter, например образ `jupyter/pyspark-notebook`). Дополнительно понадобится второй/третий небольшой CSV-файл — то есть вместо одной таблицы работаем с несколькими связанными наборами данных.

**Рекомендуемая структура данных** (можно взять готовый датасет или сгенерировать синтетический, но по смыслу — как интернет-магазин):

* `orders.csv` — заказы: `order_id, customer_id, order_date, amount, status`
* `customers.csv` — клиенты: `customer_id, customer_name, city, signup_date`
* `products.csv` *(опционально, если хочется третью таблицу)* — товары или позиции заказа

Такая структура специально выбрана, чтобы было естественно продемонстрировать join, оконные функции по клиенту/дате и UDF (например, категоризацию суммы заказа или нормализацию текстового поля).

```python
from pyspark.sql import SparkSession
from pyspark.sql import functions as F

spark = SparkSession.builder \
    .appName("advanced-pyspark-practice") \
    .master("local[*]") \
    .getOrCreate()

orders = spark.read.csv("orders.csv", header=True, inferSchema=True)
customers = spark.read.csv("customers.csv", header=True, inferSchema=True)

orders.createOrReplaceTempView("orders")
customers.createOrReplaceTempView("customers")
```

---

## Часть 1. Join нескольких таблиц

### 1.1 Обычный inner/left join

```python
# DataFrame API
joined = orders.join(customers, on="customer_id", how="left")
joined.show(5)
```

```sql
-- Spark SQL
SELECT o.order_id, o.amount, o.order_date, c.customer_name, c.city
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id;
```

**Задание 1.** Посчитать суммарную и среднюю сумму заказов по каждому городу (`city`), отсортировав по убыванию суммы. Обратить внимание, что колонка `city` доступна только после join — до этого она была только в `customers`.

### 1.2 Broadcast join

Если одна из таблиц маленькая (например, `customers`), Spark может избежать дорогого shuffle-join, разослав (broadcast) копию маленькой таблицы на все executor'ы целиком:

```python
from pyspark.sql.functions import broadcast

joined_broadcast = orders.join(broadcast(customers), on="customer_id", how="left")
joined_broadcast.explain()
```

**Задание 2.** Вызвать `.explain()` на обычном join и на broadcast-join, сравнить физические планы выполнения (найти в плане `BroadcastHashJoin` vs `SortMergeJoin`). Объяснить своими словами, почему для маленькой таблицы `customers` broadcast эффективнее.

---

## Часть 2. Window Functions (оконные функции)

Оконные функции позволяют вычислять агрегаты "в контексте" каждой строки без сворачивания (`GROUP BY`) — например, ранжирование, накопительная сумма, сравнение с предыдущей/следующей строкой.

### 2.1 Ранжирование заказов по клиенту

```python
from pyspark.sql.window import Window

window_spec = Window.partitionBy("customer_id").orderBy(F.desc("amount"))

ranked = orders.withColumn("rank_by_amount", F.rank().over(window_spec))
ranked.show(10)
```

```sql
SELECT
    order_id,
    customer_id,
    amount,
    RANK() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS rank_by_amount
FROM orders;
```

### 2.2 Накопительная сумма (running total) по дате

```python
window_running = Window.partitionBy("customer_id") \
    .orderBy("order_date") \
    .rangeBetween(Window.unboundedPreceding, Window.currentRow)

with_running_total = orders.withColumn(
    "running_total", F.sum("amount").over(window_running)
)
with_running_total.show(10)
```

### 2.3 lag/lead — сравнение с предыдущим заказом клиента

```python
window_order = Window.partitionBy("customer_id").orderBy("order_date")

with_lag = orders.withColumn(
    "prev_order_amount", F.lag("amount", 1).over(window_order)
).withColumn(
    "amount_diff", F.col("amount") - F.col("prev_order_amount")
)
with_lag.show(10)
```

**Задание 3.** Для каждого клиента найти его самый первый и самый крупный заказ, используя оконные функции (`ROW_NUMBER` по дате и по сумме соответственно), без использования `GROUP BY`.

**Задание 4.** Посчитать, сколько дней прошло между текущим и предыдущим заказом каждого клиента (`datediff` между текущей `order_date` и результатом `lag("order_date", 1)`).

---

## Часть 3. User Defined Functions (UDF)

Иногда логику невозможно выразить встроенными функциями Spark SQL — тогда пишут собственную функцию на Python и регистрируют её как UDF.

### 3.1 Обычный Python UDF

```python
from pyspark.sql.types import StringType

def categorize_amount(amount):
    if amount is None:
        return "unknown"
    elif amount < 50:
        return "small"
    elif amount < 200:
        return "medium"
    else:
        return "large"

categorize_udf = F.udf(categorize_amount, StringType())

categorized = orders.withColumn("amount_category", categorize_udf(F.col("amount")))
categorized.show(10)
```

Тот же UDF можно зарегистрировать и использовать прямо в Spark SQL:

```python
spark.udf.register("categorize_amount_sql", categorize_amount, StringType())
```

```sql
SELECT order_id, amount, categorize_amount_sql(amount) AS amount_category
FROM orders;
```

### 3.2 Почему обычные Python UDF медленные

Обычный Python UDF заставляет Spark для каждой строки:

1. сериализовать данные из формата JVM в формат, понятный Python-процессу
2. передать их через межпроцессное взаимодействие в отдельный Python-процесс
3. выполнить Python-функцию **построчно** (без использования оптимизаций Catalyst и Tungsten, которые работают только с встроенными функциями)
4. сериализовать результат обратно в JVM

Это создает существенный overhead, особенно заметный на больших датасетах. **Правило:** если задачу можно решить встроенными функциями Spark SQL (`F.when`, `F.expr`, комбинация встроенных функций) — почти всегда стоит предпочесть их обычному Python UDF.

**Задание 5.** Переписать `categorize_amount` без UDF, используя только `F.when(...).otherwise(...)`, и сравнить время выполнения (`%%time` в Jupyter) на достаточно большом сгенерированном датасете (например, размноженном исходном CSV до нескольких миллионов строк — см. раздел "Подготовка большого датасета" ниже).

### 3.3 Pandas UDF (vectorized UDF) — более быстрая альтернатива

**Pandas UDF** обрабатывает данные не построчно, а **партиями (батчами)** в виде объектов `pandas.Series`, используя формат Apache Arrow для эффективной передачи данных между JVM и Python — это значительно быстрее обычного построчного UDF.

```python
import pandas as pd
from pyspark.sql.functions import pandas_udf

@pandas_udf(StringType())
def categorize_amount_vectorized(amount: pd.Series) -> pd.Series:
    return pd.cut(
        amount,
        bins=[-float("inf"), 50, 200, float("inf")],
        labels=["small", "medium", "large"]
    ).astype(str)

categorized_fast = orders.withColumn(
    "amount_category", categorize_amount_vectorized(F.col("amount"))
)
categorized_fast.show(10)
```

**Задание 6.** Реализовать через Pandas UDF расчет "скидочного балла" клиента как произвольную нелинейную функцию от суммы и количества заказов (например, с использованием `numpy`), и сравнить время выполнения с эквивалентным обычным Python UDF на большом датасете.

---

## Часть 4. Комбинированное практическое задание

Собрать все части вместе в единый пайплайн:

1. Прочитать `orders.csv` и `customers.csv`.
2. Выполнить join (с обоснованным выбором — обычный или broadcast join).
3. Добавить колонку с категорией суммы заказа через Pandas UDF.
4. Посчитать оконную функцию — ранг заказа клиента по сумме внутри своего города (`PARTITION BY city ORDER BY amount DESC`).
5. Отфильтровать только заказы с рангом 1 (топ-заказ в своем городе) и сохранить результат в Parquet.

```python
result = (
    orders
    .join(broadcast(customers), on="customer_id", how="left")
    .withColumn("amount_category", categorize_amount_vectorized(F.col("amount")))
    .withColumn("rank_in_city", F.rank().over(Window.partitionBy("city").orderBy(F.desc("amount"))))
    .filter(F.col("rank_in_city") == 1)
)

result.write.mode("overwrite").parquet("output/top_orders_by_city.parquet")
result.show(20)
```

---

## Подготовка большого датасета (для замеров производительности)

Чтобы разница в производительности между подходами (обычный UDF, встроенные функции, Pandas UDF, broadcast/обычный join) была заметна, исходный небольшой CSV стоит искусственно размножить:

```python
# Размножаем небольшой orders.csv до нескольких миллионов строк для тестов производительности
big_orders = orders
for _ in range(20):
    big_orders = big_orders.union(orders)

big_orders = big_orders.withColumn("order_id", F.monotonically_increasing_id())
print(big_orders.count())

big_orders.write.mode("overwrite").parquet("orders_big.parquet")
```

Далее используем `orders_big.parquet` вместо исходного CSV во всех замерах времени (`%%time` перед ячейкой в Jupyter), чтобы сравнения были показательными.

---

## Задания для самостоятельной практики (после занятия)

1. Сравнить план выполнения (`.explain(True)`) для join двух таблиц без `broadcast()` и с ним — найти в плане, где происходит `Exchange` (shuffle), и объяснить, почему в broadcast-варианте его меньше.
2. Написать оконную функцию, вычисляющую скользящее среднее (moving average) суммы заказа за последние 3 заказа каждого клиента (`rowsBetween(-2, Window.currentRow)`).
3. Замерить и сравнить время выполнения одной и той же логики категоризации тремя способами на `orders_big.parquet`: обычный Python UDF, `F.when()`, Pandas UDF. Построить простой bar-график сравнения времени (например, через `matplotlib`).
4. Объяснить в 2-3 предложениях, в каком случае, несмотря на overhead, использование обычного Python UDF все равно оправдано (подсказка: сложная логика, которую невозможно выразить ни встроенными функциями, ни векторизованно через pandas/numpy).
