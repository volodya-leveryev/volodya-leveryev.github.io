# Циклы в Python

## Терминология

**Итератор** — это объект, поддерживающий протокол из функций `__iter__()` и `__next__()`, возвращающий элементы по одному и исчерпывающийся по завершении. Для завершения итераций он вызывает исключение `StopIteration`.

**Корутина** — это функция, способная приостанавливать выполнение и возобновляться позже, обычно используется с `async def` и оператором `await` для асинхронного программирования.

**Генератор** — это итератор, созданный функцией (корутина) с `yield`; автоматически реализует протокол итератора.

**Генераторные выражения** — это конструкция в круглых скобках, создающая ленивый генератор на основе выражения и цикла, например `(x*x for x in nums)`.

**Ленивое исполнение кода** — это выполнение вычислений только по требованию: значения не создаются заранее, а генерируются в момент обращения.

## Итераторы

```python
# Объявление
class MyIterator:
    def __init__(self, limit):
        """
        Конструктор объекта
        """
        self.current = 0
        self.limit = limit

    def __iter__(self):
        """
        Возвращает объект содержащий метод `__next__()`.
        В общем случае это может быть другой объект.
        """
        return self

    def __next__(self):
        """
        Возвращает очередной объект последовательности.
        Вызывает исключение StopIteration когда нужно завершить итерации.
        """
        if self.current < self.limit:
            item = self.current
            self.current += 1
            return item
        else:
            raise StopIteration

# Создаем итератор
my_iter = MyIterator(3)

# Перед началом итераций вызывается `__iter__()`
for item in my_iter:
    # Перед каждой итерацией вызывается `__next__()`
    print(item)

# Результат:
# 0
# 1
# 2

# Ручной запуск без `for`:
it = iter(my_iter)
print(next(it))
print(next(it))
print(next(it))

# Результат:
# 0
# 1
# 2
```

## Генераторы

```python
def simple_generator(n):
    i = 0
    while i < n:
        yield i  # Возвращает значение и приостанавливает выполнение
        i += 1

# Создаем генератор
gen = simple_generator(5)

# Генератор будет постоянно создавать новые элементы последовательности
for number in gen:
    print(number)

    # Ручное прерывание цикла
    if number > 10:
        break
```

## Генераторные выражения

```python
# Список потребляет память и сразу вычисляет значения
squares_list = [i * i for i in range(5)]

# Генераторное выражение не потребляет память
squares_generator = (i * i for i in range(5))

# Генераторное выражение вычисляет значения по мере необходимости
for square in squares_generator:
    print(square)
```

## Функция `enumerate()`

```python
fruits = ['apple', 'banana', 'cherry']

for index, fruit in enumerate(fruits):
    print(f"Index {index}: {fruit}")

# Результат:
# Index 0: apple
# Index 1: banana
# Index 2: cherry
```

```python
names = ["Alice", "Bob", "Charlie"]

# можно начать отсчёт не с нуля
for count, name in enumerate(names, start=1):
    print(f"Student ID {count}: {name}")

# Результат:
# Student ID 1: Alice
# Student ID 2: Bob
# Student ID 3: Charlie
```

## Функция `zip()`

```python
names = ["Alice", "Bob", "Charlie"]
scores = [85, 90, 88]

zipped_data = zip(names, scores)
print(list(zipped_data))

# Результат:
# [('Alice', 85), ('Bob', 90), ('Charlie', 88)]
```

```python
names = ["Alice", "Bob", "Charlie"]
ages = [25, 30, 28]
cities = ("New York", "London", "Paris")

# можно сцепить несколько коллекций
zipped_data = zip(names, ages, cities)
print(list(zipped_data))

# Результат:
# [('Alice', 25, 'New York'), ('Bob', 30, 'London'), ('Charlie', 28, 'Paris')]
```

```python
zipped_list = [('Alice', 85), ('Bob', 90), ('Charlie', 88)]

# Можно распаковать аргументы из коллекции
names, scores = zip(*zipped_list)
print("Names:", names)
print("Scores:", scores)

# Результат:
# Names: ('Alice', 'Bob', 'Charlie')
# Scores: (85, 90, 88)
```

## Пакет `itertools`

### Итераторы, порождающие последовательность

- `count(start=0, step=1)` Бесконечная арифметическая прогрессия. Использование: генерация последовательных чисел.
- `cycle(iterable)` Бесконечно повторяет элементы переданного итерируемого объекта.
- `repeat(object, times=None)` Повторяет один и тот же объект указанное число раз или бесконечно.

```python
import itertools

counter1 = itertools.count()
for i in range(5):
    print(next(counter1)) # Результат: 0, 1, 2, 3, 4

counter2 = itertools.count(start=10, step=2)
for i in range(5):
    print(next(counter2)) # Результат: 10, 12, 14, 16, 18

# Бесконечный повтор значений из списка
colors = ['red', 'green', 'blue']
color_cycler = itertools.cycle(colors)
for i in range(7):
    print(next(color_cycler))
    # Результат: red, green, blue, red, green, blue, red

# Повтор значения ровно 3 раза
repeated_string = itertools.repeat("Hello", 3)
for item in repeated_string:
    print(item) # Результат: Hello, Hello, Hello

# Бесконечно повторящийся генератор
repeated_number = itertools.repeat(42)
for i in range(5):
    print(next(repeated_number)) # Результат: 42, 42, 42, 42, 42
```

### Итераторы, объединяющие последовательности

- `chain(*iterables)` Итерирует по нескольким последовательностям подряд.
- `chain.from_iterable(iterable_of_iterables)` То же, но принимает один итерируемый объект, содержащий другие.
- `zip_longest(*iterables, fillvalue=None)` Аналог встроенного zip, но продолжает до самой длинной последовательности, подставляя fillvalue при нехватке элементов.

```python
from itertools import chain

list1 = [1, 2, 3]
tuple1 = ('a', 'b')
string1 = "XYZ"

# Запуск итераторов по цепочке
chained_iterator = chain(list1, tuple1, string1)
print(f"Result: {list(chained_iterator)}")
# Result: [1, 2, 3, 'a', 'b', 'X', 'Y', 'Z']

# Запуск итераторов из итераторов
list_of_iterables = [[10, 20], (30, 40), "50"]
chained_from_iterable = chain.from_iterable(list_of_iterables)
print(f"Result: {list(chained_from_iterable)}")
# Result: [10, 20, 30, 40, '5', '0']

from itertools import zip_longest

numbers = [1, 2, 3, 4]
letters = ['a', 'b']
symbols = ['!', '@', '#', '$', '%']

# Сцепляем значения коллекций, дополняем отсутствующие значения с помощью None
zipped_longest_default = zip_longest(numbers, letters, symbols)
print("Result:", list(zipped_longest_default))
# Result: [(1, 'a', '!'), (2, 'b', '@'), (3, None, '#'), (4, None, '$'), (None, None, '%')]

# Сцепляем значения коллекций, дополняем отсутствующие значения с помощью кастомного значения
zipped_longest_custom = zip_longest(numbers, letters, symbols, fillvalue='-')
print("Result:", list(zipped_longest_custom))
# Result: [(1, 'a', '!'), (2, 'b', '@'), (3, '-', '#'), (4, '-', '$'), ('-', '-', '%')]
```

### Фильтрация и отбор элементов

- `filterfalse(predicate, iterable)` Выбирает элементы, для которых predicate возвращает False.
- `dropwhile(predicate, iterable)` Отбрасывает элементы, пока predicate возвращает True, затем выдаёт все остальные.
- `takewhile(predicate, iterable)` Выдаёт элементы, пока predicate возвращает True, затем останавливается.
- `compress(data, selectors)` Фильтрует data по булевым значениям в selectors.

### Комбинаторика

- `product(*iterables, repeat=1)` Декартово произведение. Аналог вложенных циклов.
- `permutations(iterable, r=None)` Все перестановки длины r (или длины iterable).
- `combinations(iterable, r)` Все сочетания без повторений, порядок не учитывается.
- `combinations_with_replacement(iterable, r)` Сочетания с повторениями.

### Итераторы, выполняющие преобразования

- `accumulate(iterable, func=operator.add, *, initial=None)` Накопление частичных результатов (сумма, произведение, максимум и др.).
- `starmap(function, iterable)` Применяет функцию, распаковывая аргументы из каждого элемента (кортежа).
- `pairwise(iterable)` Пары соседних элементов: (a0, a1), (a1, a2), …
- `batched(iterable, n)` Разбивает последовательность на чанки длины n.

### Группировка

- `groupby(iterable, key=None)` Группирует последовательные элементы по ключу. Работает правильно только на отсортированных данных (по ключу группировки).

### Рецепты (часто используемые шаблоны использования itertools)

Не входят в сам модуль, но приводятся в документации как готовые конструкции:

* `take(n, iterable)` первые n элементов.
* `tabulate(func, start=0)` бесконечная последовательность func(0), func(1)…
* `consume(iterator, n=None)` «перемотка» итератора.
* `flatten(list of lists)` через chain.from_iterable.
* `powerset(iterable)` все подмножества.
* `roundrobin(iterables)` циклический обход нескольких последовательностей.
