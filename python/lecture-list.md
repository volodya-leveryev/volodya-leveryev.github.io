---
layout: python
title: Работа со списками
---
# Работа со списками

## Что такое список

Список (list) — это одномерный динамический массив. То есть это массив, в который можно добавлять и убирать элементы по ходу работы программы:

<pre><code class="language-python">
my_list = []  # создали пустой список
my_list.append(5)  # добавили в список новый элемент
my_list.remove(5)  # убрали из списка элемент
</code></pre>

Список помнит порядок следования элементов.

Список предоставляет доступ к значениям по индексам (номерам, которые отсчет начинаются с нуля):

<pre><code class="language-python">
my_list = [3, 1, 4, 1]  # создали список с 4 элементами
my_list[0] = 2  # заменяем первый элемент списка
print(my_list)  # печатает [2, 1, 4, 1]
</code></pre>

Элементы списка могут иметь значения разных типов.

Список может работать как [стек](https://ru.wikipedia.org/wiki/%D0%A1%D1%82%D0%B5%D0%BA) или [очередь](https://ru.wikipedia.org/wiki/%D0%9E%D1%87%D0%B5%D1%80%D0%B5%D0%B4%D1%8C_(%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5)).

## Способы создания списков

Самый простой:

<pre><code class="language-python">
my_list_1 = []
</code></pre>

На базе нескольких существующих элементов:

<pre><code class="language-python">
my_list_2 = [False, 1, 2.0, 'с']  # элементы списка могут быть разного типа
</code></pre>

С помощью конструктора класса:

<pre><code class="language-python">
my_list_3 = list()
</code></pre>

На базе коллекции (строка, кортеж, множество, диапазон и т.п.):

<pre><code class="language-python">
my_list_4 = list('Hello')  # ['H', 'e', 'l', 'l', 'o']

my_list_5 = list(range(10))  # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
</code></pre>

Генераторные выражения:

<pre><code class="language-python">
my_list_6 = [elem ** 2 for elem in range(10)]
my_list_7 = [elem ** 2 for elem in range(10) if elem % 2 == 0]
my_list_8 = [(x, y) for x in range(10) for y in range(10)]
</code></pre>

## Операторы

Доступ к элементам списка осуществляется с помощью оператора `[]` по индексу (номеру элемента).

**Нумерация элементов в списке начинается с нуля!**

Отрицательные индексы отсчитываются от конца списка (последний -1, предпоследний -2 и т.д.).

Перезапись и чтение значений списка по индексу:

<pre><code class="language-python">
my_list_2[0] = 'new value'
print(my_list_2[-1])  # печать последнего элемента из списка
</code></pre>

Проверка на присутствие или отсутствие элемента в списке (см. [PEP8](https://www.python.org/dev/peps/pep-0008/#programming-recommendations)):

<pre><code class="language-python">
elem = 5
if elem in my_list:
    print('The element belongs to the list')

# Рекомендуемый вариант (используется оператор not in):
if elem not in my_list:
    print('The element does not belong to the list')

# Нерекомендуемый вариант (используются два оператора: not и in):
if not elem in my_list:
    print('The element does not belong to the list')
</code></pre>

Поэлементное (лексикографическое) сравнение двух списков:

<pre><code class="language-python">
if list1 == list2:
    print('The lists are equal')
if list1 != list2:
    print('The lists are not equal')
if list1 > list2:
    print('The first list is greater than the second')
if list1 >= list2:
    print('The first list is greater than or equal to the second')
if list1 < list2:
    print('The first list is lesser than the second')
if list1 <= list2:
    print('The first list is lesser than or equal to the second')
</code></pre>

Проверка двух списков на идентичность (см. [PEP8](https://www.python.org/dev/peps/pep-0008/#programming-recommendations)):

<pre><code class="language-python">
if list1 is list2:
    print('these two variables are the same object!')

# Рекомендуемый вариант (используется оператор is not):
if list1 is not list2:
    print('different objects')

# Нерекомендуемый вариант (используются два оператора: not и is):
if not list1 is list2:
    print('different objects')
</code></pre>

## Обход элементов списка

**Нерекомендуемый** способ обхода списка, основанный на механическом повторении синтаксиса других языков:

<pre><code class="language-python">
for i in range(len(my_list)):
    print(my_list[i])
</code></pre>

**Рекомендуемый** способ обхода списка:

<pre><code class="language-python">
for elem in my_list:
    print(elem)
</code></pre>

Если в теле цикла вам одновременно нужны индекс и значение элемента списка, используйте функцию `enumerate()`:

<pre><code class="language-python">
for i, value in enumerate(my_list):
    print(i, value)
</code></pre>

Если вам нужно обойти список в обратном порядке:

<pre><code class="language-python">
for elem in reversed(my_list):
    print(elem)
</code></pre>

## Добавление элемента в список

Добавление элемента в конец списка:

<pre><code class="language-python">
new_elem = int(input())
my_list.append(new_elem)
</code></pre>

Вставка элемента в заданную позицию списка:

<pre><code class="language-python">
# new_elem станет третьим в списке
my_list.insert(2, new_elem)
</code></pre>

Добавление в список всех элементов из другого списка:

<pre><code class="language-python">
my_list.extend(another_list)
</code></pre>

Создание нового списка в результате слияния (конкатенации) двух списков:

<pre><code class="language-python">
new_list = my_list_1 + my_list_2
</code></pre>

## Поиск элемента в списке

Поиск индекса (номера) первого вхождения элемента в список (если элемент отсутствует — будет ошибка `ValueError`):

<pre><code class="language-python">
i = my_list.index(elem)
</code></pre>

Подсчёт количества повторов элемента в списке:

<pre><code class="language-python">
num = my_list.count(elem)
</code></pre>

## Удаление элементов из списка

Удалить элемент из списка по индексу (номеру):

<pre><code class="language-python">
# будет удален элемент с индексом 0
del my_list[0]
</code></pre>

Удалить элемент из списка по значению (если элемент отсутствует — будет ошибка `ValueError`):

<pre><code class="language-python">
my_list.remove(elem)
</code></pre>

Очистка списка:

<pre><code class="language-python">
my_list.clear()
</code></pre>

## Другие операции

Извлечение элемента из конца списка (элемент удаляется из списка):

<pre><code class="language-python">
last_element = my_list.pop()
</code></pre>

Извлечение элемента из середины списка (элемент удаляется из списка):

<pre><code class="language-python">
third_element = my_list.pop(2)
</code></pre>

Создание копии (shallow copy) списка:

<pre><code class="language-python">
new_list = my_list.copy()
</code></pre>

Создание полной копии списка (применяется когда элементами списка являются другие списки, словари или множества):

<pre><code class="language-python">
from copy import deepcopy
new_list = deepcopy(my_list)
</code></pre>

Создание нового списка путем повтора исходного списка несколько раз:

<pre><code class="language-python">
my_list = [0]
new_list = my_list * 5  # [0, 0, 0, 0, 0]
</code></pre>

## Встроенные функции

Количество элементов в списке:

<pre><code class="language-python">
len(my_list)
</code></pre>

Сумма элементов списка:

<pre><code class="language-python">
sum(my_list)
</code></pre>

Максимальный элемент списка:

<pre><code class="language-python">
max(my_list)
</code></pre>

Минимальный элемент списка:

<pre><code class="language-python">
min(my_list)
</code></pre>

Проверка, что в списке есть непустые (ненулевые) элементы:

<pre><code class="language-python">
any(my_list)
</code></pre>

Проверка, что все элементы в списке — непустые (ненулевые):

<pre><code class="language-python">
all(my_list)
</code></pre>

## Срезы

Чтобы получить из списка элементы начиная с индекса 1 до 3 (не включая его):

<pre><code class="language-python">
my_list = [10, 20, 30, 40, 50, 60]
new_list = my_list[1:3]  # [20, 30]
</code></pre>

Отрицательные индексы позволяют отсчитывать элементы от конца списка.
Чтобы получить из списка элементы начиная с индекса 1 до предпоследнего (не включая его):

<pre><code class="language-python">
my_list = [10, 20, 30, 40, 50, 60]
new_list = my_list[1:-2]  # [20, 30, 40]
</code></pre>

Чтобы получить из списка элементы начиная с индекса 1 до конца списка:

<pre><code class="language-python">
my_list = [10, 20, 30, 40, 50, 60]
new_list = my_list[1:]  # [20, 30, 40, 50, 60]
</code></pre>

Чтобы получить из списка элементы от его начала до индекса 3 (не включая его):

<pre><code class="language-python">
my_list = [10, 20, 30, 40, 50, 60]
new_list = my_list[:3]  # [10, 20, 30]
</code></pre>

Чтобы получить копию списка:

<pre><code class="language-python">
my_list = [10, 20, 30, 40, 50, 60]
new_list = my_list[:]  # [10, 20, 30, 40, 50, 60]
</code></pre>

Чтобы получить из списка элементы с индекса 1 до 10 (не включая его) с шагом 2:

<pre><code class="language-python">
my_list = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]
new_list = my_list[1:10:2]  # [20, 40, 60, 80, 100]
</code></pre>

Чтобы получить из списка элементы с индекса 1 до конца строки с шагом 2:

<pre><code class="language-python">
my_list = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]
new_list = my_list[1::2]  # [20, 40, 60, 80, 100, 120]
</code></pre>

Отрицательный шаг позволяет обходить элементы в обратном порядке.
Чтобы получить из списка элементы с индекса 4 до 1 (не включая его) в обратном порядке:

<pre><code class="language-python">
my_list = [10, 20, 30, 40, 50, 60]
new_list = my_list[4:1:-1]  # [50, 40, 30]
</code></pre>

Чтобы получить из списка элементы от начала до конца строки с шагом -2:

<pre><code class="language-python">
my_list = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]
new_list = my_list[::-2]  # [120, 100, 80, 60, 40, 20]
</code></pre>

Срез можно сохранить в переменную, передать в функцию или получить из функции: 

<pre><code class="language-python">
my_list = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]
my_slice = slice(1, 10, 2)
new_list = my_list[my_slice]  # [20, 40, 60, 80, 100]
</code></pre>

## Сортировка списков

Сортировка списка (in-place):

<pre><code class="language-python">
my_list.sort()
</code></pre>

Сортировка списка в убывающем порядке (in-place):

<pre><code class="language-python">
my_list.sort(reverse=True)
</code></pre>

Создание отсортированной копии списка:

<pre><code class="language-python">
new_list = sorted(my_list)
</code></pre>

Создание отсортированной в убывающем порядке копии списка:

<pre><code class="language-python">
new_list = sorted(my_list, reverse=True)
</code></pre>

При сортировке можно указать параметр `key`, который позволяет задать функцию преобразования элементов при их сравнении. Отметим, что элементы списка при этом остаются прежними:

<pre><code class="language-python">
# Пример сортировки строк по их длине, а не значению:
words = ['abc', 'bc', 'c']
words.sort(key=len)  # перед сравнением строк будет вычислятся их длина
print(words)  # ['c', 'bc', 'abc']
</code></pre>
