# Специальные (dunder / double underscore) методы

Создание удаление объекта:
- `__new__(cls)` — вызывается перед созданием объекта
- `__init__(self)` — конструктор объекта
- `__del__(self)` — деструктор объекта

Представление объекта:
- `__repr__(self)` — представление объекта
- `__format__(self)` — форматирование объекта в строку (`format(obj)`)

Конвертирование объекта:
- `__str__(self)` — конвертирование объекта в строку (`str(obj)`)
- `__bytes__(self)` — конвертирование объекта в ASCII-строку (`bytes(obj)`)
- `__bool__(self)` — конвертирование объекта в булево (`bool(obj)`)
- `__int__(self)` — конвертирование объекта в целое число (`int(obj)`)
- `__float__(self)` — конвертирование объекта в вещественное число (`float(obj)`)
- `__complex__(self)` — конвертирование объекта в комплексное число (`complex(obj)`)
- `__hash__(self)` — вычисление hash-функции (`hash(obj)`)

Сравнение:
- `__lt__(self, other)` — меньше чем (`obj < other`)
- `__le__(self, other)` — меньше или равно (`obj <= other`)
- `__eq__(self, other)` — равно (`obj == other`)
- `__ne__(self, other)` — не равно (`obj != other`)
- `__gt__(self, other)` — больше чем (`obj > other`)
- `__ge__(self, other)` — больше или равно (`obj >= other`)

Арифметические операторы:
- `__add__(self, other)` — сложение (`obj + other`)
- `__sub__(self, other)` — вычитание (`obj - other`)
- `__mul__(self, other)` — умножение (`obj * other`)
- `__matmul__(self, other)` — матричное умножение (`obj @ other`)
- `__truediv__(self, other)` — деление (`obj / other`)
- `__floordiv__(self, other)` — целочисленное деление (`obj // other`)
- `__mod__(self, other)` — остаток от деления (`obj % other`)
- `__divmod__(self, other)` — деление с остатком (`divmod(obj, other)`)
- `__pow__(self, other[, modulo])` — возведение в степень (`pow(obj, other), obj ** other`)

Побитовые операторы:
- `__lshift__(self, other)` — сдвиг влево (`obj >> other`)
- `__rshift__(self, other)` — сдвиг вправо (`obj << other`)
- `__and__(self, other)` — логическое И (`obj & other`)
- `__xor__(self, other)` — исключающее ИЛИ (`obj ^ other`)
- `__or__(self, other)` — логическое ИЛИ (`obj | other`)
- `__invert__(self)` — инвертирование (`~obj`)

Унарные операторы:
- `__neg__(self)` — унарный минус (`-obj`)
- `__pos__(self)` — унарный плюс (`+obj`)
- `__abs__(self)` — абсолютное значение (`abs(obj)`)

Работа с атрибутами:
- `__getattribute__(self, name)` — получить значение атрибута (`obj.<name>, getattr(obj, name)`)
- `__getattr__(self, name)` — получить значение атрибута (если `__getattribute__()` вызвал ошибку) (`obj.<name>, getattr(obj, name)`)
- `__setattr__(self, name, value)` — задать значение атрибута (`obj.<name> = value, setattr(obj, name, value)`)
- `__delattr__(self, name)` — удалить атрибут (`del obj.<name>, delattr(obj, name)`)
- `__dir__(self)` — получить перечень атрибутов и методов (`dir(obj)`)

Работа с контекстами:
- `__enter__(self)` — вызывается при создании контекста
- `__exit__(self, exc_type, exc_value, traceback)` — вызывается при выходе из контекста

Работа с циклами:
- `__iter__(self)` — создать итератор (`iter(obj)`)
- `__reversed__(self)` — создать обратный итератор (`reversed(obj)`)
- `__next__(self)` — получить следующий объект из итератора (`next(obj)`)
- `__len__(self)` — получить количество объектов в коллекции (`len(obj)`)
- `__contains__(self, item)` — проверить что объект входит в коллекцию (`item in obj`)
- `__getitem__(self, item)` — получить элемент по ключу (`obj[item]`)
- `__setitem__(self, item, value)` — задать элемент по ключу (`obj[item] = value`)
- `__delitem__(self, item)` — удалить элемент по ключу (`del obj[item]`)

Литература:
- [Документация](https://docs.python.org/3/reference/datamodel.html#special-method-names)
- [Статья на Real Python](https://realpython.com/python-magic-methods/)
