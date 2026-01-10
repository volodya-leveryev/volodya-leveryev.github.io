---
layout: python
title: Синтаксические конструкции
---
# Конспект по операторам в Python 

## Содержание 
1. Введение в операторы
2. Арифметические операторы
3. Операторы сравнения
4. Операторы присваивания
5. Логические операторы
6. Операторы идентичности
7. Операторы принадлежности
8. Битовые операторы
9. Приоритет операторов 
10. Примеры

## Введение в операторы 
**Операторы** — это специальные символы или ключевые слова, которые выполняют операции над операндами (переменными, значениями). В Python операторы делятся на несколько категорий

## Арифметические операторы
Используются для выполнения математических операций над числами

<table class="table table-bordered table-hover">
<thead>
  <tr><th>Оператор</th><th>Название</th><th>Описание</th></tr>
</thead>
<tbody>
  <tr><td><code>+</code></td><td>Сложение</td><td>Складывает два операнда</td></tr>
  <tr><td><code>-</code></td><td>Вычитание</td><td>Вычитает правый операнд из левого</td></tr>
  <tr><td><code>*</code></td><td>Умножение</td><td>Умножает два операнда</td></tr>
  <tr><td><code>/</code></td><td>Деление</td><td>Вещественное деление (в ответе не целые числа)</td></tr>
  <tr><td><code>//</code></td><td>Целочисленное деление</td><td>Целое деление (в ответе целые числа)</td></tr>
  <tr><td><code>%</code></td><td>Остаток от деления</td><td>Возвращает остаток от деления</td></tr>
  <tr><td><code>**</code></td><td>Возведение в степень</td><td>Возводит левый операнд в степень правого</td></tr>
</tbody>
</table>

**Примеры** 
<pre><code class="language-python">
a = 17
b = 4

print("Сложение:", a + b) # 23
print("Вычитание:", a - b) # 13
print("Умножение:", a * b) # 68 
print("Деление:", a / b) # 4.25
print("Целочисленное деление:", a // b) # 4 
print("Остаток от деления:", a % b) # 1 
print("Возведение в степень:", a ** b) # 83521
</code></pre>

## Операторы сравнения 
Сравнивают два значения и возвращают <code>True</code> или <code>False</code> 

<table class="table table-bordered table-hover">
<thead>
  <tr><th>Оператор</th><th>Название</th><th>Описание</th></tr>
</thead>
<tbody>
  <tr><td><code>==</code></td><td>Равно</td><td>Проверяет равенство значений</td></tr>
  <tr><td><code>!=</code></td><td>Не равно</td><td>Проверяет неравенство значений</td></tr>
  <tr><td><code>&gt;</code></td><td>Больше</td><td>Проверяет, больше ли левый операнд</td></tr>
  <tr><td><code>&lt;</code></td><td>Меньше</td><td>Проверяет, меньше ли левый операнд</td></tr>
  <tr><td><code>&gt;=</code></td><td>Больше или равно</td><td>Проверяет, больше или равен левый операнд</td></tr>
  <tr><td><code>&lt;=</code></td><td>Меньше или равно</td><td>Проверяет, меньше или равен левый операнд</td></tr>
</table>

**Примеры** 
<pre><code class="language-python">
# Сравнение чисел
x = 10 
y = 5 
z = 10 
print(x == y) # False 
print(x != y) # True 
print(x &gt; y) # True 
print(x &lt; y) # False 
print(x &gt;= z) # True 
print(x &lt;= z) # True 

# Сравнение строк (лексиграфическое)
str1 = "apple" 
str2 = "banana" 
print("Сравнение строк:", str1 &lt; str2) 
# True
# a в unicode - 97
# b в unicode - 98
# 97 &lt; 98, поэтому сразу определяется, что "apple" &lt; "banana" — True.
# Дальнейшие символы не проверяются, так как отличие уже найдено.
</code></pre>

## Операторы присваивания 
Присваивают значения переменным

<table class="table table-bordered table-hover">
<thead>
  <tr><th>Оператор</th><th>Пример</th><th>Эквивалент</th><th>Описание</th></tr>
</thead>
<tbody>
  <tr><td><code>=</code></td><td><code>x = 5</code></td><td><code>x = 5</code></td><td>Простое присваивание</td></tr>
  <tr><td><code>+=</code></td><td><code>x += 3</code></td><td><code>x = x + 3</code></td><td>Добавление с присваиванием</td></tr>
  <tr><td><code>-=</code></td><td><code>x -= 2</code></td><td><code>x = x - 2</code></td><td>Вычитание с присваиванием</td></tr>
  <tr><td><code>*=</code></td><td><code>x *= 4</code></td><td><code>x = x * 4</code></td><td>Умножение с присваиванием</td></tr>
  <tr><td><code>/=</code></td><td><code>x /= 2</code></td><td><code>x = x / 2</code></td><td>Деление с присваиванием</td></tr>
  <tr><td><code>//=</code></td><td><code>x //= 3</code></td><td><code>x = x // 3</code></td><td>Целочисленное деление с присв.</td></tr>
  <tr><td><code>%=</code></td><td><code>x %= 3</code></td><td><code>x = x % 3</code></td><td>Остаток от деления с присв.</td></tr>
  <tr><td><code>**=</code></td><td><code>x **= 2</code></td><td><code>x = x ** 2</code></td><td>Возведение в степень с присв.</td></tr>
</tbody>
</table>


## Логические операторы 
Работают с булевыми значениями (<code>True</code>/<code>False</code>)

<table class="table table-bordered table-hover">
<thead>
  <tr><th>Оператор</th><th>Название</th><th>Описание</th></tr>
</thead>
<tbody>
  <tr><td><code>and</code></td><td>И</td><td>True, если оба операнда True</td></td>
  <tr><td><code>or</code></td><td>ИЛИ</td><td>True, если хотя бы один операнд True</td></td>
  <tr><td><code>not</code></td><td>НЕ</td><td>Инвертирует значение</td></td>
</tbody>
</table>

**Примеры** 
<pre><code class="language-python">
print(True and True) # True 
print(True and False) # False 
print(False and False) # False 
print(True or True) # True 
print(True or False) # True 
print(False or False) # False 
print(not True) # False 
print(not False) # True 

# пример с переменными 
age = 25 
has_license = True 

can_drive = age &gt;= 18 and has_license 
print(f"Может ли водить машину: {can_drive}") # True
</code></pre>

## Операторы идентичности 
Проверяют, являются ли объекты одним и тем же объектом в памяти. Не путать со сравнением значений

<table class="table table-bordered table-hover">
<thead>
  <tr><th>Оператор</th><th>Название</th><th>Описание</th></tr>
</thead>
<tbody>
  <tr><td><code>is</code></td><td>Это</td><td>True, если оба объекта одинаковые</td></tr>
  <tr><td><code>is not</code></td><td>Не это</td><td>True, если объекты разные</td></tr>
</tbody>
</table>

**Примеры** 
<pre><code class="language-python">
# Для простых типов (интернирование) 
a = 256 
b = 256 
print(a is b) # True (Python кэширует маленькие целые числа) 

# Для списков (разные объекты) 
list1 = [1, 2, 3] 
list2 = [1, 2, 3] 
list3 = list1 
print(list1 is list2) # False (разные объекты) 
print(list1 is list3) # True (один и тот же объект) 
print(list1 == list2) # True (содержимое одинаковое) 
</code></pre>

## Операторы принадлежности Проверяют наличие элемента в последовательности. 

<table class="table table-bordered table-hover">
<thead>
  <tr><th>Оператор</th><th>Название</th><th>Описание</th></tr>
</thead>
<tbody>
  <tr><td><code>in</code></td><td>Входит в</td><td><code>True</code>, если элемент в последовательности</td></tr>
  <tr><td><code>not in</code></td><td>Не входит в</td><td><code>True</code>, если элемента нет в последовательности</td></tr>
</tbody>
</table>

**Примеры** 
<pre><code class="language-python">
# Проверка в строках 
text = "Hello, World!" 
print('Hello' in text) # True 
print('Python' in text) # False 
print('World' not in text) # False 

# Проверка в списках 
fruits = ['apple', 'banana', 'orange', 'grape'] 
print('banana' in fruits) # True 
print('mango' in fruits) # False 
print('pear' not in fruits) # True 

# Проверка в словарях (проверяет ключи) 
person = {'name': 'Alice', 'age': 30, 'city': 'Moscow'} 
print('name' in person) # True 
print('Alice' in person) # False (проверяет ключи, не значения) 
print('age' not in person) # False 
</code></pre>

## Битовые операторы 
Работают с числами на уровне битов (двоичного представления). 

<table class="table table-bordered table-hover">
<thead>
  <tr><th>Оператор</th><th>Название</th><th>Описание</th></tr>
</thead>
<tbody>
  <tr><td><code>&</code></td><td>И (AND)</td><td>Побитовое И</td></tr>
  <tr><td><code>\|</code></td><td>ИЛИ (OR)</td><td>Побитовое ИЛИ</td></tr>
  <tr><td><code>^</code></td><td>XOR</td><td>Исключающее ИЛИ</td></tr>
  <tr><td><code>~</code></td><td>НЕ (NOT)</td><td>Побитовое отрицание</td></tr>
  <tr><td><code>&lt;&lt;</code></td><td>Сдвиг влево</td><td>Сдвиг битов влево</td></tr>
  <tr><td><code>&gt;&gt;</code></td><td>Сдвиг вправо</td><td>Сдвиг битов вправо</td></tr>
</tbody>
</table>

**Примеры** 
<pre><code class="language-python">
a = 10 # 1010 в двоичной 
b = 4 # 0100 в двоичной

# Побитовое И (AND) 
print(a & b) # 1010 & 0100 = 0000 (0) 

# Побитовое ИЛИ (OR) 
print(a | b) # 1010 | 0100 = 1110 (14) 

# Побитовое исключающее ИЛИ (XOR) 
print(a ^ b) # 1010 ^ 0100 = 1110 (14) 

# Побитовое НЕ (NOT) 
print(~a)
# для примера 8 бит
# 0000 1010
# после инверта 1111 0101
# старший бит 1 из-за этого число отриц-ое
# Чтобы узнать его значение в десятичной системе:
# Инвертируем все биты обратно: 0000 1010
# Добавляем 1: 0000 1011
# Ставим знак минус: -11

# Сдвиг влево 
print(a &lt;&lt; 1) # 1010 &lt;&lt; 1 = 10100 (20) 
print(a &lt;&lt; 2) # 1010 &lt;&lt; 2 = 101000 (40) 

# Сдвиг вправо 
print(a &gt;&gt; 1) # 1010 &gt;&gt; 1 = 0101 (5) 
print(a &gt;&gt; 2) # 1010 &gt;&gt; 2 = 0010 (2) 
</code></pre>

## Приоритет операторов при выполнении операций: 
1. `()` - скобки (группировка) - ВЫСШИЙ
2. `**` - возведение в степень 
3. `+x`, `-x`, `~x` - унарные плюс, минус, побитовое НЕ 
4. `*`, `/`, `//`, `%` - умножение, деление, целочисленное деление, остаток 
5. `+`, `-` - сложение, вычитание 
6. `&lt;&lt;`, `&gt;&gt;` - битовые сдвиги 
7. `&` - побитовое И 
8. `^` - побитовое исключающее ИЛИ 
9. `|` - побитовое ИЛИ 
10. `==`, `!=`, `&gt;`, `&lt;`, `&gt;=`, `&lt;=`, `is`, `is not`, `in`, `not in` - сравнение, идентичность, принадлежность 
11. `not` - логическое НЕ 
12. `and` - логическое И 
13. `or` - логическое ИЛИ 
14. `=` и другие операторы присваивания - НИЗШИЙ

**Примеры** 
<pre><code class="language-python">
# Пример с разным приоритетом 
result1 = 2 + 3 * 4 ** 2 / 8 - 1
# Порядок вычислений: 
# 1. 4 ** 2 = 16 
# 2. 3 * 16 = 48 
# 3. 48 / 8 = 6.0 
# 4. 2 + 6.0 = 8.0 
# 5. 8.0 - 1 = 7.0 

print(result1) # 7.0 

# Использование скобок для изменения порядка 
result2 = (2 + 3) * (4 ** 2) / (8 - 1) 
# 1. (2 + 3) = 5 
# 2. (4 ** 2) = 16 
# 3. (8 - 1) = 7 
# 4. 5 * 16 = 80 
# 5. 80 / 7 ≈ 11.4286 
print(result2:.4f) # 11.4286

# Смешанные операторы 
a, b, c = 5, 3, 2 
result3 = not a &gt; b and c != 0 or b == 3 

# Порядок вычислений: 
# 1. a &gt; b = 5 &gt; 3 = True 
# 2. not True = False 
# 3. c != 0 = 2 != 0 = True 
# 4. False and True = False 
# 5. b == 3 = 3 == 3 = True 
# 6. False or True = True 

print(result3) # True
</code></pre>
