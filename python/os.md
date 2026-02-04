---
layout: python
title: Работа с кортежами
---

# Конспект по модулю os в Python

## Содержание

1. [Введение](#введение)
2. [Рабочая директория](#рабочая-директория)
3. [Просмотр файлов и папок](#просмотр-файлов-и-папок)
4. [Создание и удаление папок](#создание-и-удаление-папок)
5. [Работа с файлами](#работа-с-файлами)
6. [Переменные окружения](#переменные-окружения)
7. [Запуск системных команд](#запуск-системных-команд)
8. [Информация о системе](#информация-о-системе)
9. [Практические задачи](#практические-задачи)

## Введение

Модуль os предоставляет функции для взаимодействия с операционной системой. Это один из наиболее важных модулей стандартной библиотеки Python для системного программирования.

<pre><code class="language-python">
    import os

    # Проверяем тип операционной системы
    print(f"Имя ОС: {os.name}") # 'posix', 'nt', 'java'
    print(f"Разделитель путей: {os.sep}")
    print(f"Разделитель строк: {os.linesep}")
</code></pre>

## Рабочая директория

`os.getcwd()` — получить текущую рабочую директорию
<pre><code class="language-python">
    import os

    # Получаем текущую рабочую директорию
    current_dir = os.getcwd()
    print(f"Текущая директория: {current_dir}")
</code></pre>

`os.chdir(path)` — изменить рабочую директорию
<pre><code class="language-python">
    import os

    # Сохраняем текущую директорию
    original_dir = os.getcwd()

    # Переходим в другую директорию
    try: os.chdir("/tmp") # Linux/macOS
        # os.chdir("C:\\Temp") # Windows
        print(f"Новая директория: {os.getcwd()}")

        # Возвращаемся обратно
        os.chdir(original_dir)
        print(f"Вернулись в: {os.getcwd()}")
    except FileNotFoundError as e:
        print(f"Директория не найдена: {e}")
    except PermissionError as e:
        print(f"Нет прав доступа: {e}")
</code></pre>

## Просмотр файлов и папок

`os.listdir(path='.')` — список файлов и директорий
<pre><code class="language-python">
    import os

    # Список содержимого текущей директории
    items = os.listdir()
    print(f"Содержимое текущей директории: {items}")

    # Список содержимого конкретной директории
    if os.path.exists("/tmp"):
        tmp_items = os.listdir("/tmp")
        print(f"Содержимое /tmp: {tmp_items}")

    # Фильтрация файлов по расширению
    py_files = [f for f in os.listdir() if f.endswith('.py')]
    print(f"Python файлы: {py_files}")
</code></pre>

`os.scandir(path='.')` — более эффективный способ (Python 3.5+)
<pre><code class="language-python">
    import os

    # Использование scandir (контекстный менеджер)
    with os.scandir('.') as entries:
       for entry in entries:
          print(f"Имя: {entry.name}")
          print(f" Путь: {entry.path}")
          print(f" Это файл: {entry.is_file()}")
          print(f" Это директория: {entry.is_dir()}")
          print(f" Это символическая ссылка: {entry.is_symlink()}")
          рrint(f" inode номер: {entry.inode()}")
          print() </code></pre>

## Создание и удаление папок

`os.mkdir(path, mode=0o777)` — создать директорию
<pre><code class="language-python">
    import os

    # Создание одной директории
    os.mkdir("новая_папка")
    print("Папка создана")

    # Создание с указанием прав (Unix-like системы)
    os.mkdir("защищенная_папка", mode=0o755)

    # Обработка ошибок
    try:
        os.mkdir("существующая_папка")
    except FileExistsError:
        print("Папка уже существует")
</code></pre>

`os.makedirs(name, mode=0o777, exist_ok=False)` — создать вложенные директории
<pre><code class="language-python">
    import os

    # Создание вложенной структуры директорий
    os.makedirs("проект/исходники/модули")
    print("Вложенные директории созданы")

    # Создание с флагом exist_ok (не вызывает ошибку если существует)
    os.makedirs("проект/документы", exist_ok=True)

    # Создание сложной структуры
    paths = [ "данные/сырые/2024",
              "данные/обработанные/2024",
              "модели/обученные",
              "модели/тестовые" ]

    for path in paths:
        os.makedirs(path, exist_ok=True)
</code></pre>

`os.rmdir(path)` — удалить пустую директорию
<pre><code class="language-python">
    import os

    # Удаление пустой директории
    if os.path.exists("пустая_папка") and os.path.isdir("пустая_папка"):
        if not os.listdir("пустая_папка"): # Проверяем что папка пуста
            os.rmdir("пустая_папка")
            print("Пустая папка удалена")

    # Обработка ошибок
    try:
       os.rmdir("непустая_папка")
    except OSError as e:
       print(f"Не удалось удалить: {e}")
</code></pre>

`os.removedirs(name)` — рекурсивное удаление пустых директорий
<pre><code class="language-python">
    import os

    # Создаем структуру директорий
    os.makedirs("a/b/c/d", exist_ok=True)

    # Удаляем все пустые директории в цепочке
    os.removedirs("a/b/c/d") # Удалит d, затем c, затем b, затем a если все они пусты
</code></pre>

## Работа с файлами

`os.remove(path)` — удалить файл
<pre><code class="language-python">
    import os

    # Создаем тестовый файл
    with open("тестовый_файл.txt", "w") as f:
    f.write("Тестовое содержимое")

    # Удаляем файл
    if os.path.exists("тестовый_файл.txt"):
        os.remove("тестовый_файл.txt")
        print("Файл удален")

    # Удаление с обработкой ошибок
    def безопасное_удаление(путь):
        try:
            os.remove(путь)
            print(f"Файл {путь} удален")
            return True
        except FileNotFoundError:
            print(f"Файл {путь} не найден")
            return False
        except PermissionError:
            print(f"Нет прав для удаления {путь}")
            return False
        except IsADirectoryError:
            print(f"{путь} является директорией, используйте os.rmdir()")
            return False безопасное_удаление("несуществующий.txt")
</code></pre>

`os.rename(src, dst)` — переименовать или переместить
<pre><code class="language-python">
    import os

    # Создаем тестовый файл
    with open("старое_имя.txt", "w") as f:
        f.write("Содержимое файла")

    # Переименовываем файл
    os.rename("старое_имя.txt", "новое_имя.txt")
    print("Файл переименован")

    # Перемещаем файл в другую директорию
    os.makedirs("архив", exist_ok=True)
    os.rename("новое_имя.txt", "архив/новое_имя.txt")
    print("Файл перемещен")

    # Безопасное переименование
    def безопасное_переименование(старый_путь, новый_путь):
       if not os.path.exists(старый_путь):
           print(f"Исходный файл {старый_путь} не существует")
           return False
       try:
           os.rename(старый_путь, новый_путь)
           print(f"Успешно: {старый_путь} -> {новый_путь}")
           return True
       except FileExistsError:
           print(f"Файл {новый_путь} уже существует")
           return False
       except PermissionError: print(f"Нет прав для переименования")
           return False
</code></pre>

`os.replace(src, dst)` — атомарная замена
<pre><code class="language-python">
import os

# os.replace заменяет файл атомарно (в одну операцию)
with open("данные.txt", "w") as f:
    f.write("Старые данные")

# Атомарная замена
os.replace("данные.txt", "резервные_данные.txt")
print("Файл заменен атомарно")
</code></pre>

`os.unlink(path)` — удалить файл (аналог `remove`)
Удаляет файл или символическую ссылку.

<pre><code class="language-python">
import os

# Создаем файл
with open("целевой_файл.txt", "w") as f:
    f.write("Целевой файл")

# Создаем символическую ссылку (Unix-like системы)
if os.name != 'nt':  # Не в Windows
    os.symlink("целевой_файл.txt", "ссылка.txt")
    print("Символическая ссылка создана")

    # os.unlink удаляет ссылку, но не целевой файл
    os.unlink("ссылка.txt")
    print("Ссылка удалена, целевой файл остался")

    # Удаляем целевой файл
    os.unlink("целевой_файл.txt")
else:
    print("Символические ссылки поддерживаются только в Unix-like системах")
</code></pre>

## Переменные окружения

`os.environ` — словарь переменных окружения
<pre><code class="language-python">
import os

# Просмотр всех переменных окружения
print("Все переменные окружения:")
for key, value in os.environ.items():
    print(f"{key} = {value}")

# Получение конкретной переменной
path = os.environ.get('PATH', 'Не установлен')
home = os.environ.get('HOME', os.environ.get('USERPROFILE', 'Неизвестно'))
print(f"PATH: {path[:50]}...")
print(f"Домашняя директория: {home}")

# Установка переменной окружения (только для текущего процесса)
os.environ['MY_APP_MODE'] = 'development'
print(f"MY_APP_MODE: {os.environ.get('MY_APP_MODE')}")

# Удаление переменной
del os.environ['MY_APP_MODE']
</code></pre>

`os.getenv(key, default=None)` — безопасное получение переменной
<pre><code class="language-python">
import os

# Безопасное получение с значением по умолчанию
python_path = os.getenv('PYTHONPATH', '/usr/lib/python3.10')
debug_mode = os.getenv('DEBUG', 'false').lower() == 'true'
port = int(os.getenv('PORT', '8080'))

print(f"Python path: {python_path}")
print(f"Debug mode: {debug_mode}")
print(f"Port: {port}")

# Пример конфигурации из переменных окружения
config = {
    'database_url': os.getenv('DATABASE_URL', 'sqlite:///db.sqlite3'),
    'secret_key': os.getenv('SECRET_KEY', 'dev-secret-key'),
    'log_level': os.getenv('LOG_LEVEL', 'INFO')
}

print("Конфигурация:", config)
</code></pre>

`os.putenv(name, value)` и `os.unsetenv(name)` — устаревшие методы
<pre><code class="language-python">
import os

    # Установка переменной (лучше использовать os.environ)
    os.putenv('TEMP_VAR', 'temp_value')
    # Удаление переменной
    os.unsetenv('TEMP_VAR') # Важно: putenv/unsetenv не обновляют os.environ автоматически
    # Рекомендуется использовать os.environ напрямую
    os.environ['MY_VAR'] = 'value' # Предпочтительный способ
</code></pre>

## Запуск системных команд

`os.system(command)` — выполнить команду в оболочке
<pre><code class="language-python">
import os

# Простые команды
return_code = os.system("echo Hello World")
print(f"Код возврата: {return_code}")

# Платформозависимые команды
if os.name == 'nt':  # Windows
    os.system("dir")
    os.system("ping -n 2 google.com")
else:  # Unix-like
    os.system("ls -la")
    os.system("ping -c 2 google.com")

# Проверка кода возврата
result = os.system("несуществующая_команда")
if result != 0:
    print("Команда завершилась с ошибкой")
</code></pre>

`os.popen(command, mode='r', buffering=-1)` — выполнить команду и получить вывод
<pre><code class="language-python">
import os

# Получение вывода команды
output = os.popen("ls -la").read()
print("Вывод команды ls -la:")
print(output)

# Чтение вывода построчно
with os.popen("ps aux") as proc:
    for i, line in enumerate(proc, 1):
        if i <= 5:  # Только первые 5 строк
            print(f"{i}: {line.strip()}")

# Проверка доступности программы
def программа_установлена(имя_программы):
    if os.name == 'nt':
        command = f"where {имя_программы}"
    else:
        command = f"which {имя_программы}"

    result = os.popen(command).read().strip()
    return bool(result)

print(f"Python установлен: {программа_установлена('python')}")
</code></pre>

`os.startfile(path)` — открыть файл в ассоциированной программе (только Windows)
<pre><code class="language-python">
import os

if os.name == 'nt':  # Проверяем что это Windows
    # Открытие файлов в ассоциированных программах
    os.startfile("document.pdf")  # Откроет в PDF-ридере
    os.startfile("image.jpg")     # Откроет в просмотрщике изображений

    # Открытие директории в проводнике
    os.startfile("C:\\Users")
else:
    print("os.startfile() доступен только в Windows")
</code></pre>

## Информация о системе

`os.name` — имя операционной системы
<pre><code class="language-python">
import os

print(f"Имя ОС: {os.name}")  # 'posix', 'nt', 'java'

# Определение платформы
if os.name == 'nt':
    print("Это Windows")
elif os.name == 'posix':
    print("Это Unix-like система (Linux, macOS, BSD)")
else:
    print("Неизвестная ОС")
</code></pre>

`os.sep` и `os.altsep` — разделители путей
<pre><code class="language-python">
import os

print(f"Основной разделитель путей: '{os.sep}'")
print(f"Альтернативный разделитель: '{os.altsep}'")
</code></pre>

`os.cpu_count()` — количество процессоров
<pre><code class="language-python">
import os

cpu_count = os.cpu_count()
print(f"Количество CPU: {cpu_count}")

# Использование для параллельных задач
if cpu_count:
    workers = min(cpu_count, 4)  # Не более 4 воркеров
    print(f"Рекомендуемое количество потоков: {workers}")
</code></pre>

`os.urandom(n)` — криптографически безопасные случайные байты
<pre><code class="language-python">
import os
import base64

# Генерация случайных байтов
random_bytes = os.urandom(16)
print(f"Случайные байты: {random_bytes.hex()}")

# Генерация токена
token = base64.urlsafe_b64encode(os.urandom(32)).decode()
print(f"Случайный токен: {token}")
</code></pre>

`os.getpid()`, `os.getppid()` — идентификаторы процессов
<pre><code class="language-python">
import os

# ID текущего процесса
pid = os.getpid()
print(f"ID текущего процесса: {pid}")

# ID родительского процесса
ppid = os.getppid()
print(f"ID родительского процесса: {ppid}")
</code></pre>

## Практические задачи

Задача 1: Мониторинг директории
<pre><code class="language-python">
import os
import time

def мониторинг_директории(директория, интервал=5):
    """
    Мониторит изменения в директории
    """
    print(f"Начинаем мониторинг директории: {директория}")

    предыдущие_файлы = set(os.listdir(директория))

    try:
        while True:
            time.sleep(интервал)
            текущие_файлы = set(os.listdir(директория))

            новые = текущие_файлы - предыдущие_файлы
            удаленные = предыдущие_файлы - текущие_файлы

            if новые:
                print(f"[{time.strftime('%H:%M:%S')}] Новые файлы: {новые}")
            if удаленные:
                print(f"[{time.strftime('%H:%M:%S')}] Удаленные файлы: {удаленные}")

            предыдущие_файлы = текущие_файлы

    except KeyboardInterrupt:
        print("\nМониторинг завершен")

# Запуск мониторинга текущей директории
# мониторинг_директории('.', интервал=2)
</code></pre>

Задача 2: Пакетное переименование файлов
<pre><code class="language-python">
import os
import re

def пакетное_переименование(директория, шаблон, замена):
    """
    Переименовывает файлы по шаблону
    """
    if not os.path.exists(директория):
        print(f"Директория {директория} не существует")
        return

    переименовано = 0
    ошибки = 0

    for имя_файла in os.listdir(директория):
        полный_путь = os.path.join(директория, имя_файла)

        if os.path.isfile(полный_путь):
            новое_имя = re.sub(шаблон, замена, имя_файла)

            if новое_имя != имя_файла:
                новый_путь = os.path.join(директория, новое_имя)
                try:
                    os.rename(полный_путь, новый_путь)
                    print(f"  {имя_файла} -> {новое_имя}")
                    переименовано += 1
                except Exception as e:
                    print(f"  Ошибка при переименовании {имя_файла}: {e}")
                    ошибки += 1

    print(f"\nИтог: переименовано {переименовано} файлов, ошибок: {ошибки}")

# Пример использования
пакетное_переименование(
    директория=".",
    шаблон=r"фото_(\d+)\.jpg",
    замена=r"image_\1.jpg"
)
</code></pre>

Задача 3: Поиск дубликатов файлов
<pre><code class="language-python">
import os
import hashlib

def поиск_дубликатов_файлов(директория):
    """
    Находит дубликаты файлов по содержимому
    """
    if not os.path.exists(директория):
        print(f"Директория {директория} не существует")
        return {}

    хеши_файлов = {}
    дубликаты = {}

    for корень, папки, файлы in os.walk(директория):
        for имя_файла in файлы:
            полный_путь = os.path.join(корень, имя_файла)

            try:
                # Вычисляем хеш файла
                with open(полный_путь, 'rb') as f:
                    хеш = hashlib.md5(f.read()).hexdigest()

                # Проверяем на дубликаты
                if хеш in хеши_файлов:
                    if хеш not in дубликаты:
                        дубликаты[хеш] = [хеши_файлов[хеш]]
                    дубликаты[хеш].append(полный_путь)
                else:
                    хеши_файлов[хеш] = полный_путь

            except (IOError, OSError):
                continue

    # Выводим результаты
    if дубликаты:
        print("Найдены дубликаты файлов:")
        for хеш, пути in дубликаты.items():
            print(f"\nФайлы с одинаковым содержимым:")
            for путь in пути:
                print(f"  {путь}")
    else:
        print("Дубликаты не найдены")

    return дубликаты

# Пример использования
дубликаты = поиск_дубликатов_файлов(".")
</code></pre>
