---
layout: python
title: Работа со словарями
---
# Работа со словарями

Словари (`dict`) – неупорядоченные наборы произвольных объектов с доступом по ключу. Их иногда ещё называют ассоциативными массивами или хеш-таблицами.

## Cпособы создания словарей

Самый простой:

<pre><code class="language-python">
my_dict = {}
</code></pre>

С помощью конструктора класса:

<pre><code class="language-python">
my_dict = dict()
</code></pre>

Если заранее известны ключи:

<pre><code class="language-python">
my_dict = dict.fromkeys(['key1', 'key2', 'key3'])

default_value = 0
my_list = dict.fromkeys(['key1', 'key2', 'key3'], default_value)
</code></pre>

На базе существующих ключей и значений:

<pre><code class="language-python">
my_dict = {'key1':'value1', 'key2':'value2', 'key3':'value3'}

# Если ключи являются корректными идентификаторами:
my_dict = dict(key1='value1', key2='value2', key3='value3')

my_dict = dict([('key1', 'value1'), ('key2', 'value2'), ('key3', 'value3')])

# Если ключи и значения хранятся в списках:
keys = ['key1', 'key2', 'key3']
values = ['value1', 'value2', 'value3']
my_dict = dict(zip(keys, values))
</code></pre>

На базе существующего словаря:

<pre><code class="language-python">
my_dict = existing_dict.copy()  # поверхностная копия

from copy import deepcopy
my_dict = deepcopy(existing_dict)  # глубокое копирование
</code></pre>

С помощью объединения нескольких словарей:

<pre><code class="language-python">
my_dict = {**dict1, **dict2}

my_dict = dict1 | dict2  #  начиная с Python 3.9
</code></pre>

Генераторные выражения:

<pre><code class="language-python">
my_dict = {key: key**2 for key in range(10)}

my_dict = {k1 + k2: ' ' for k1 in 'ABCDEFGH' for k2 in '123456789'}

my_dict = {key: key**2 for key in range(10) if key % 2 == 0}
</code></pre>

## Обход словарей в цикле

По умолчанию обход словаря происходит по ключам:

<pre><code class="language-python">
for key in my_dict:
    print(key, my_dict[key])
</code></pre>

Также можно использовать функции:

`.keys()` — список ключей. Например:

<pre><code class="language-python">
for key in my_dict.keys():
    print(key, my_dict[key])
</code></pre>

`.values()` — список значений. Например:

<pre><code class="language-python">
for value in my_dict.values():
    print(value)
</code></pre>

`.items()` — список пар ключ/значение. Например:

<pre><code class="language-python">
for key, value in my_dict.items():
    print(key, value)
</code></pre>

## Операции

Количество элементов в словаре:

<pre><code class="language-python">
print('This dict has:', len(my_dict), 'elements')
</code></pre>

Удаление значения из словаря по ключу:

<pre><code class="language-python">
del my_dict[key]
</code></pre>

Получение ключей из словаря:

<pre><code class="language-python">
list(my_dict)

my_dict.keys()
</code></pre>

Проверка что ключ входит или не входит в словарь (см. [PEP8](https://www.python.org/dev/peps/pep-0008/#programming-recommendations)):

<pre><code class="language-python">
if 'key' in my_dict:
    print('belongs')

# Рекомендуемый вариант
if 'key' not in my_dict:
    print('not belongs')

# Нерекомендуемый вариант
if not 'key' in my_dict:
    print('not belongs')
</code></pre>

Проверка содержимого двух словарей на равенство или неравенство:

<pre><code class="language-python">
if my_dict == other_dict:
    print('these two dicts have equal content')

if my_dict != other_dict:
    print('these two dicts have different content')
</code></pre>

Проверка двух словарей на идентичность (см. [PEP8](https://www.python.org/dev/peps/pep-0008/#programming-recommendations)):

<pre><code class="language-python">
if dict1 is dict2:
    print('these two variables are the same object!')

# Рекомендуемый вариант
if dict1 is not dict2:
    print('different objects')

# Нерекомендуемый вариант
if not dict1 is dict2:
    print('different objects')
</code></pre>

## Что может быть ключом словаря?

Если функция `hash()` работает со значением, то это значение может быть ключом словаря.

Ключом словаря могут быть значения типа:

- булево (`bool`)
- целое число (`int`)
- вещественное число (`float`)
- комплексное число (`complex`)
- строка (`str`)
- байтовая строка (`bytes`)
- кортеж (`tuple`)
- фиксированное множество (`frozenset`)
- объект пользовательского класса

<pre><code class="language-python">
my_dict = {}
for i in range(3):
    for j in range(5):
        my_dict[i, j] = 0  # Кортеж в качестве ключа
</code></pre>

Ключом словаря НЕ могут быть значения типа:

- список (`list`)
- словарь (`dict`)
- множество (`set`)
- байтовый массив (`bytearray`)

## Методы

Удаление всех ключей и значений словаря:

<pre><code class="language-python">
my_dict.clear()
</code></pre>

Прочитать значения по ключу:

<pre><code class="language-python">
print(my_dict[key])  # если key не входит в my_dict, тогда ошибка KeyError

print(my_dict.get(key))  # если key не входит в my_dict, тогда None

print(my_dict.get(key, 0))  # если key не входит в my_dict, тогда 0
</code></pre>

Установить значение по ключу, если этого ключа нет:

<pre><code class="language-python">
my_dict[key] = value  # если было старое значение - оно будет перезаписано

# если значение уже есть - возвращаем его
# иначе - записываем значение и возвращаем его
my_dict.setdefault(key, value)
</code></pre>

Установить пустое значение, если этого ключа нет:

<pre><code class="language-python">
my_dict.setdefault(key)  # если значение уже есть - возвращаем его
</code></pre>

Извлечение значения по ключу:

<pre><code class="language-python">
value = my_dict.pop(key)  # ключ и значение удаляются из my_dict
</code></pre>

Извлечение ключа и значения, которые были добавлены последними:

<pre><code class="language-python">
key, value = my_dict.popitem()  # ключ и значение удаляются из my_dict
</code></pre>

Обновление словаря элементами из другого словаря:

<pre><code class="language-python">
dict1 = {'a': 1, 'b': 2}
dict2 = {'c': 3, 'b': 4}

dict1.update(dict2)

dict1 |= dict2  # начиная с Python 3.9

print(dict1)  # {'a': 1, 'b': 4, 'c': 3}
</code></pre>

