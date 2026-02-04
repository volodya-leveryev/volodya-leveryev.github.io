---
layout: python
title: Пакет `os.path`
---

# Пакет `os.path`

## Содержание

1. [Введение](#введение)
2. [Объединение и разбор путей](#объединение-и-разбор-путей)
3. [Абсолютные и относительные пути](#абсолютные-и-относительные-пути)
4. [Проверка существования файлов и папок](#проверка-существования-файлов-и-папок)
5. [Разделение пути на компоненты](#разделение-пути-на-компоненты)
6. [Получение информации о файле](#получение-информации-о-файле)
7. [Время файлов](#время-файлов)
8. [Примеры комплексного использования](#примеры-комплексного-использования)

## Введение

Модуль `os.path` — это подмодуль `os`, предназначенный для работы с путями файлов и папок. Он помогает создавать переносимые пути между Windows, Linux и macOS, а также проверять и модифицировать пути.

Основные преимущества:
* Кроссплатформенность (автоматически адаптируется к ОС)
* Безопасная работа с путями
* Удобные функции для разбора и сборки путей

<pre><code class="language-python">
import os
import os.path  # или просто from os import path

# Проверка доступности модуля
print(f"Модуль os.path доступен: {hasattr(os, 'path')}")
</code></pre>

## Объединение и разбор путей

`os.path.join(path, paths)` — объединяет части пути. Создает корректные пути, автоматически добавляя правильные разделители для текущей ОС.

<pre><code class="language-python">
import os.path

# 1. Создать путь к файлу
full_path = os.path.join("C:/Users/Ivan", "Documents", "notes.txt")
print(f"Полный путь: {full_path}")

# 2. Создать путь к вложенной папке
folder_path = os.path.join("project", "src", "utils")
print(f"Путь к папке: {folder_path}")

# 3. Объединение с динамическими именами
folder = "logs"
file = "log1.txt"
log_path = os.path.join(folder, file)
print(f"Путь к логу: {log_path}")

# 4. Кроссплатформенный пример
paths = ["home", "user", "projects", "app", "config.ini"]
config_path = os.path.join(*paths)
print(f"Кроссплатформенный путь: {config_path}")

# 5. Объединение с абсолютными и относительными путями
result = os.path.join("/home/user", "documents", "..", "projects")
print(f"Путь с '..': {result}")
</code></pre>

`os.path.normpath(path)` — нормализует путь. Убирает лишние слэши и обрабатывает `.` (текущая директория) и `..` (родительская директория).

<pre><code class="language-python">
import os.path

# 1. Простой пример
normalized = os.path.normpath("project//src/../utils")
print(f"Нормализованный путь: {normalized}")

# 2. Нормализация с точками
path1 = os.path.normpath("./folder1/./folder2/../file.txt")
print(f"Нормализовано: {path1}")

# 3. Нормализация в Windows-стиле (даже на Linux)
path2 = "folder1\\folder2/../folder3"
normalized2 = os.path.normpath(path2)
print(f"Смешанные слэши: {normalized2}")

# 4. Практическое применение
user_path = "C:\\Users\\\\John\\Documents\\..\\Desktop\\file.txt"

clean_path = os.path.normpath(user_path)
print(f"Очищенный путь: {clean_path}")
</code></pre>

`os.path.commonpath(paths)` — общий путь для списка путей. Находит самый длинный общий путь для нескольких путей.

<pre><code class="language-python">
import os.path

# 1. Поиск общего пути
paths = [
    "/home/user/docs/file1.txt",
    "/home/user/docs/reports/report.pdf",
    "/home/user/images/photo.jpg"
]

common = os.path.commonpath(paths)
print(f"Общий путь: {common}")

# 2. С Windows-путями
windows_paths = [
    "C:\\Users\\John\\Documents\\file1.txt",
    "C:\\Users\\John\\Desktop\\file2.txt",
    "C:\\Users\\John\\Downloads\\file3.txt"
]

common_win = os.path.commonpath(windows_paths)
print(f"Общий путь (Windows): {common_win}")
</code></pre>

## Абсолютные и относительные пути

`os.path.abspath(path)` — абсолютный путь. Возвращает полный путь от корня файловой системы.

<pre><code class="language-python">
import os.path

# 1. Абсолютный путь для текущего файла
abs_path = os.path.abspath("data.txt")
print(f"Абсолютный путь к data.txt: {abs_path}")

# 2. Абсолютный путь для вложенной папки
log_path = os.path.abspath("logs/log1.txt")
print(f"Абсолютный путь к логу: {log_path}")

# 3. Использование для открытия файла
try:
    with open(os.path.abspath("notes.txt")) as f:
        content = f.read()
        print(f"Содержимое notes.txt: {content[:50]}...")
except FileNotFoundError:
    print("Файл не найден")

# 4. Преобразование относительного пути в абсолютный
relative = "../parent_folder/file.txt"
absolute = os.path.abspath(relative)
print(f"Относительный: {relative}")
print(f"Абсолютный: {absolute}")
</code></pre>

`os.path.relpath(path, start='.')` — относительный путь. Возвращает путь от `start` до `path`.

<pre><code class="language-python">
import os.path
import os

# 1. Относительный путь до файла
rel_path = os.path.relpath("C:/Users/Ivan/Documents/notes.txt", "C:/Users/Ivan")
print(f"Относительный путь: {rel_path}")

# 2. Относительный путь между папками
project_path = os.path.relpath("project/src/utils", "project")
print(f"Относительный путь в проекте: {project_path}")

# 3. Использование для логирования
base = os.getcwd()
file = os.path.join(base, "data/output.txt")
relative_to_base = os.path.relpath(file, base)
print(f"Относительно текущей директории: {relative_to_base}")

# 4. Создание переносимых путей
def create_portable_path(base_dir, target_path):
    """Создает путь, который будет работать при перемещении проекта"""
    return os.path.relpath(target_path, base_dir)

portable = create_portable_path("/home/user/project", "/home/user/project/data/config.ini")
print(f"Переносимый путь: {portable}")
</code></pre>

`os.path.isabs(path)` — проверка абсолютного пути. Проверяет, является ли путь абсолютным.

<pre><code class="language-python">
import os.path

# 1. Проверка абсолютных путей
paths_to_check = [
    "/home/user/file.txt",      # Абсолютный (Unix)
    "C:\\Windows\\system32",    # Абсолютный (Windows)
    "./relative/file.txt",      # Относительный
    "file.txt",                 # Относительный
    "../parent/file.txt"        # Относительный
]

for path in paths_to_check:
    is_absolute = os.path.isabs(path)
    print(f"{path:30} -> Абсолютный: {is_absolute}")
</code></pre>

## Проверка существования файлов и папок

`os.path.exists(path)` — существует ли путь. Проверяет существование файла или директории.

<pre><code class="language-python">
import os.path
import os

# 1. Проверка файла
file_exists = os.path.exists("notes.txt")
print(f"Файл notes.txt существует: {file_exists}")

# 2. Проверка папки
folder_exists = os.path.exists("logs")
print(f"Папка logs существует: {folder_exists}")

# 3. Условное создание папки
if not os.path.exists("backup"):
    os.mkdir("backup")
    print("Папка backup создана")

# 4. Проверка нескольких путей
paths_to_check = ["config.json", "data.csv", "images/", "output/"]
print("\nПроверка существования путей:")
for path in paths_to_check:
    exists = os.path.exists(path)
    status = "✅ существует" if exists else "❌ не существует"
    print(f"  {path:20} {status}")
</code></pre>

`os.path.isfile(path)` — является ли файлом. Проверяет, является ли путь файлом.

<pre><code class="language-python">
import os.path

# 1. Проверка файла
is_file = os.path.isfile("data.txt")
print(f"data.txt является файлом: {is_file}")

# 2. Использование перед чтением
config_file = "config.txt"
if os.path.isfile(config_file):
    with open(config_file, 'r') as f:
        config_content = f.read()
        print(f"Конфиг прочитан, размер: {len(config_content)} символов")
else:
    print(f"Файл {config_file} не найден или не является файлом")

# 3. Проверка перед удалением
temp_file = "old.txt"
if os.path.isfile(temp_file):
    os.remove(temp_file)
    print(f"Файл {temp_file} удален")
else:
    print(f"Файл {temp_file} не существует для удаления")

# 4. Фильтрация только файлов в директории
def list_files_only(directory):
    """Возвращает список только файлов в директории"""
    return [item for item in os.listdir(directory) 
            if os.path.isfile(os.path.join(directory, item))]

files = list_files_only(".")
print(f"\nФайлы в текущей директории: {files}")
</code></pre>

`os.path.isdir(path)` — является ли папкой. Проверяет, является ли путь директорией.

<pre><code class="language-python">
import os.path
import os

# 1. Проверка папки
is_directory = os.path.isdir("logs")
print(f"logs является папкой: {is_directory}")

# 2. Создание папки при отсутствии
backup_dir = "backup"
if not os.path.isdir(backup_dir):
    os.mkdir(backup_dir)
    print(f"Папка {backup_dir} создана")

# 3. Перебор только папок в текущей директории
print("\nПапки в текущей директории:")
for item in os.listdir("."):
    if os.path.isdir(item):
        print(f"  📁 {item}")

# 4. Рекурсивный поиск всех поддиректорий
def find_all_directories(root_path):
    """Находит все директории в дереве каталогов"""
    directories = []
    for item in os.listdir(root_path):
        item_path = os.path.join(root_path, item)
        if os.path.isdir(item_path):
            directories.append(item_path)
            # Рекурсивный поиск
            directories.extend(find_all_directories(item_path))
    return directories

all_dirs = find_all_directories(".")
print(f"\nВсего найдено директорий: {len(all_dirs)}")
</code></pre>

`os.path.islink(path)` — является ли символической ссылкой. Проверяет, является ли путь символической ссылкой (актуально для Unix-like систем).

<pre><code class="language-python">
import os.path
import os

if os.name != 'nt':  # Проверяем, что не Windows
    # Создаем файл и символическую ссылку
    with open("target_file.txt", "w") as f:
        f.write("Целевой файл")
    
    os.symlink("target_file.txt", "symlink.txt")
    
    # Проверяем
    print(f"symlink.txt это ссылка: {os.path.islink('symlink.txt')}")
    print(f"target_file.txt это ссылка: {os.path.islink('target_file.txt')}")
    
    # Убираем за собой
    os.remove("symlink.txt")
    os.remove("target_file.txt")
else:
    print("Символические ссылки не поддерживаются в Windows через эту функцию")
</code></pre>

`os.path.ismount(path)` — является ли точкой монтирования. Проверяет, является ли путь точкой монтирования.

<pre><code class="language-python">
import os.path

# Проверка различных путей
paths_to_check = ["/", "/home", "/mnt", ".", "C:\\", "D:\\"]

print("Проверка точек монтирования:")
for path in paths_to_check:
    if os.path.exists(path):  # Проверяем существование перед проверкой
        is_mount = os.path.ismount(path)
        status = "📌 точка монтирования" if is_mount else "📂 обычный путь"
        print(f"  {path:20} -> {status}")
</code></pre>

## Разделение пути на компоненты

`os.path.split(path)` — разделяет путь на (директория, файл). Разделяет путь на кортеж `(head, tail)`, где `tail` - последний компонент пути.

<pre><code class="language-python">
import os.path

# 1. Разделение пути к файлу
dir_path, file_name = os.path.split("C:/Users/Ivan/Documents/notes.txt")
print(f"Директория: {dir_path}")
print(f"Имя файла: {file_name}")

# 2. Разделение динамического пути
path = os.path.join("project", "src", "utils", "helper.py")
head, tail = os.path.split(path)
print(f"Путь: {path}")
print(f"Голова: {head}")
print(f"Хвост: {tail}")

# 3. Использование для сохранения файла в другой папке
log_path = "logs/app.log"
dir_path, file_name = os.path.split(log_path)
backup_path = os.path.join("backup", file_name)
print(f"Оригинальный путь: {log_path}")
print(f"Бэкап путь: {backup_path}")

# 4. Разделение только директории
def get_parent_directory(filepath, levels=1):
    """Получает родительскую директорию на N уровней выше"""
    current = filepath
    for _ in range(levels):
        current = os.path.split(current)[0]
    return current

parent = get_parent_directory("/home/user/project/src/main.py", levels=2)
print(f"Директория на 2 уровня выше: {parent}")
</code></pre>

`os.path.splitext(path)` — разделяет имя файла и расширение. Разделяет путь на кортеж `(root, ext)`, где `ext` начинается с точки.

<pre><code class="language-python">
import os.path

# 1. Разделение файла
name, ext = os.path.splitext("notes.txt")
print(f"Имя без расширения: {name}")
print(f"Расширение: {ext}")

# 2. Для изменения расширения
original = "report.docx"
name, ext = os.path.splitext(original)
new_file = name + ".pdf"
print(f"Оригинал: {original}")
print(f"Конвертирован в: {new_file}")

# 3. Проверка типа файла
def get_file_type(filename):
    """Определяет тип файла по расширению"""
    name, ext = os.path.splitext(filename)
    ext = ext.lower()
    
    file_types = {
        '.jpg': 'изображение',
        '.jpeg': 'изображение',
        '.png': 'изображение',
        '.gif': 'изображение',
        '.pdf': 'документ',
        '.doc': 'документ Word',
        '.docx': 'документ Word',
        '.txt': 'текстовый файл',
        '.py': 'Python скрипт',
        '.zip': 'архив',
        '.mp4': 'видео'
    }
    
    return file_types.get(ext, 'неизвестный тип')

test_files = ["photo.jpg", "document.pdf", "script.py", "archive.tar.gz"]
print("\nОпределение типов файлов:")
for file in test_files:
    file_type = get_file_type(file)
    print(f"  {file:20} -> {file_type}")

# 4. Обработка файлов без расширения или с несколькими точками
test_cases = ["archive.tar.gz", "README", "config.default.json"]
print("\nСложные случаи:")
for test in test_cases:
    name, ext = os.path.splitext(test)
    print(f"  {test:25} -> Имя: '{name}', Расширение: '{ext}'")
</code></pre>

`os.path.basename(path)` — имя файла или последний компонент пути. Возвращает последний компонент пути (аналог `os.path.split()[1]`).

<pre><code class="language-python">
import os.path

# 1. Получение имени файла
filename = os.path.basename("/home/user/documents/report.pdf")
print(f"Имя файла: {filename}")

# 2. Для директорий тоже работает
dirname = os.path.basename("/home/user/projects/")
print(f"Имя директории: {dirname}")

# 3. Практическое использование
def process_file(filepath):
    """Обрабатывает файл, логируя его имя"""
    filename = os.path.basename(filepath)
    print(f"Обработка файла: {filename}")
    # ... дальнейшая обработка

process_file("/var/log/app/app.log")
</code></pre>

`os.path.dirname(path)` — директория пути. Возвращает директорию пути (аналог `os.path.split()[0]`).

<pre><code class="language-python">
import os.path

# 1. Получение директории файла
directory = os.path.dirname("/home/user/documents/report.pdf")
print(f"Директория файла: {directory}")

# 2. Вложенные вызовы для получения родительских директорий
path = "/home/user/projects/app/src/main.py"
parent1 = os.path.dirname(path)
parent2 = os.path.dirname(parent1)
parent3 = os.path.dirname(parent2)

print(f"Оригинальный путь: {path}")
print(f"Родитель 1: {parent1}")
print(f"Родитель 2: {parent2}")
print(f"Родитель 3: {parent3}")

# 3. Создание полного пути из директории и имени файла
def create_full_path(directory, filename):
    """Создает полный путь, гарантируя что directory это действительно директория"""
    # Убираем возможное имя файла из directory
    clean_dir = os.path.dirname(directory) if os.path.basename(directory) else directory
    return os.path.join(clean_dir, filename)

full_path = create_full_path("/home/user/docs", "report.txt")
print(f"Созданный путь: {full_path}")
</code></pre>

`os.path.commonprefix(list)` — общий префикс путей. Устаревшая функция (лучше использовать `os.path.commonpath()`).

<pre><code class="language-python">
import os.path

paths = [
    "/home/user/docs/file1.txt",
    "/home/user/docs/file2.txt",
    "/home/user/images/photo.jpg"
]

common_prefix = os.path.commonprefix(paths)
print(f"Общий префикс: {common_prefix}")
</code></pre>

## Получение информации о файле

`os.path.getsize(path)` — размер файла в байтах. Возвращает размер файла в байтах.

<pre><code class="language-python">
import os.path

# 1. Размер одного файла
try:
    size = os.path.getsize("data.txt")
    print(f"Размер data.txt: {size} байт")
except FileNotFoundError:
    print("Файл data.txt не найден")

# 2. Сравнение размеров двух файлов
file1 = "a.txt"
file2 = "b.txt"

if os.path.exists(file1) and os.path.exists(file2):
    size1 = os.path.getsize(file1)
    size2 = os.path.getsize(file2)
    
    if size1 > size2:
        print(f"{file1} больше {file2} на {size1 - size2} байт")
    elif size2 > size1:
        print(f"{file2} больше {file1} на {size2 - size1} байт")
    else:
        print("Файлы одинакового размера")

# 3. Размер всех .txt файлов в папке
print("\nРазмеры .txt файлов:")
for f in os.listdir("."):
    if f.endswith(".txt") and os.path.isfile(f):
        size = os.path.getsize(f)
        print(f"  {f:20} {size:10} байт")

# 4. Человеко-читаемый формат размера
def human_readable_size(size_bytes):
    """Конвертирует размер в байтах в человеко-читаемый формат"""
    for unit in ['B', 'KB', 'MB', 'GB', 'TB']:
        if size_bytes < 1024.0:
            return f"{size_bytes:.2f} {unit}"
        size_bytes /= 1024.0
    return f"{size_bytes:.2f} PB"

# Тестируем
test_sizes = [100, 1024, 1048576, 1073741824]
for size in test_sizes:
    readable = human_readable_size(size)
    print(f"{size:15} байт = {readable}")
</code></pre>

`os.path.getatime(path)` — время последнего доступ. Возвращает время последнего доступа к файлу в секундах с начала эпохи.

<pre><code class="language-python">
import os.path
import time
from datetime import datetime

# 1. Получение времени доступа
if os.path.exists("data.txt"):
    access_time = os.path.getatime("data.txt")
    print(f"Время последнего доступа: {access_time}")
    print(f"В формате даты: {datetime.fromtimestamp(access_time)}")
    
    # 2. Проверка, когда файл был открыт последний раз
    now = time.time()
    days_since_access = (now - access_time) / (24 * 3600)
    print(f"Дней с последнего доступа: {days_since_access:.1f}")
</code></pre>

`os.path.getmtime(path)` — время последней модификации. Возвращает время последнего изменения файла.

<pre><code class="language-python">
import os.path
import time
from datetime import datetime

# 1. Время последнего изменения
if os.path.exists("data.txt"):
    modify_time = os.path.getmtime("data.txt")
    print(f"Время последнего изменения: {datetime.fromtimestamp(modify_time)}")
    
    # 2. Поиск самого нового файла в директории
    def get_newest_file(directory):
        files = [f for f in os.listdir(directory) 
                if os.path.isfile(os.path.join(directory, f))]
        
        if not files:
            return None
        
        newest = max(files, key=lambda f: os.path.getmtime(os.path.join(directory, f)))
        return newest
    
    newest = get_newest_file(".")
    if newest:
        print(f"Самый новый файл: {newest}")
</code></pre>

`os.path.getctime(path)` — время создания файла. Возвращает время создания файла (на Unix-системах - время изменения метаданных).

<pre><code class="language-python">
import os.path
from datetime import datetime

# Получение времени создания
if os.path.exists("data.txt"):
    create_time = os.path.getctime("data.txt")
    print(f"Время создания: {datetime.fromtimestamp(create_time)}")
    
    # Сравнение времени создания и модификации
    modify_time = os.path.getmtime("data.txt")
    if create_time != modify_time:
        print("Файл был изменен после создания")
</code></pre>

## Время файлов

`os.path.samefile(path1, path2)` — один и тот же файл? Проверяет, ссылаются ли пути на один и тот же файл (учитывает символические ссылки).

<pre><code class="language-python">
import os.path
import os

# Создаем тестовые файлы и ссылки
with open("original.txt", "w") as f:
    f.write("Оригинальный файл")

# На Unix-like системах создаем жесткую ссылку
if os.name != 'nt':
    os.link("original.txt", "hardlink.txt")
    
    # Проверяем
    same1 = os.path.samefile("original.txt", "hardlink.txt")
    print(f"original.txt и hardlink.txt это один файл: {same1}")
    
    # Убираем за собой
    os.remove("hardlink.txt")

# Проверка разных файлов
with open("different.txt", "w") as f:
    f.write("Другой файл")

same2 = os.path.samefile("original.txt", "different.txt")
print(f"original.txt и different.txt это один файл: {same2}")

# Убираем за собой
os.remove("original.txt")
os.remove("different.txt")
</code></pre>

`os.path.samestat(stat1, stat2)` — одинаковая stat информация? Проверяет, ссылаются ли две `stat`-структуры на один и тот же файл.

<pre><code class="language-python">
import os.path
import os

if os.path.exists("test.txt"):
    stat1 = os.stat("test.txt")
    stat2 = os.stat("test.txt")
    
    same = os.path.samestat(stat1, stat2)
    print(f"Stat структуры указывают на один файл: {same}")
</code></pre>

## Примеры комплексного использования

Пример 1: Создать папку `backup` и переместить туда все `.txt` файлы
<pre><code class="language-python">
import os
import os.path
import shutil

def backup_txt_files(source_dir=".", backup_dir="backup"):
    """
    Создает backup папку и перемещает туда все .txt файлы
    """
    # Создаем папку backup если её нет
    if not os.path.exists(backup_dir):
        os.makedirs(backup_dir)
        print(f"Создана папка: {backup_dir}")
    
    # Перемещаем все .txt файлы
    moved_count = 0
    for filename in os.listdir(source_dir):
        source_path = os.path.join(source_dir, filename)
        
        # Проверяем что это файл и имеет расширение .txt
        if os.path.isfile(source_path) and filename.endswith('.txt'):
            target_path = os.path.join(backup_dir, filename)
            
            try:
                # Используем shutil.move для надежного перемещения
                shutil.move(source_path, target_path)
                moved_count += 1
                print(f"Перемещен: {filename}")
            except Exception as e:
                print(f"Ошибка при перемещении {filename}: {e}")
    
    print(f"\nИтог: перемещено {moved_count} файлов")
    return moved_count

# Использование
backup_txt_files()
</code></pre>

Пример 2: Получить размер всех файлов в папке `logs`
<pre><code class="language-python">
import os.path

def analyze_logs_directory(logs_dir="logs"):
    """
    Анализирует размер всех файлов в папке logs
    """
    if not os.path.exists(logs_dir):
        print(f"Папка {logs_dir} не существует")
        return
    
    if not os.path.isdir(logs_dir):
        print(f"{logs_dir} не является папкой")
        return
    
    print(f"Анализ папки: {os.path.abspath(logs_dir)}")
    print("=" * 50)
    
    total_size = 0
    file_count = 0
    
    for filename in os.listdir(logs_dir):
        filepath = os.path.join(logs_dir, filename)
        
        if os.path.isfile(filepath):
            size = os.path.getsize(filepath)
            total_size += size
            file_count += 1
            
            # Форматированный вывод
            size_str = f"{size:,}".replace(",", " ")
            print(f"{filename:30} {size_str:>15} байт")
    
    print("=" * 50)
    
    # Статистика
    if file_count > 0:
        avg_size = total_size / file_count
        print(f"Всего файлов: {file_count}")
        print(f"Общий размер: {total_size:,} байт")
        print(f"Средний размер: {avg_size:,.0f} байт")
        
        # Человеко-читаемый формат
        def human_size(size):
            for unit in ['B', 'KB', 'MB', 'GB']:
                if size < 1024.0:
                    return f"{size:.2f} {unit}"
                size /= 1024.0
            return f"{size:.2f} TB"
        
        print(f"Общий размер: {human_size(total_size)}")
    else:
        print("В папке нет файлов")

# Использование
analyze_logs_directory()
</code></pre>

Пример 3: Создать отчет с абсолютными путями всех файлов
<pre><code class="language-python">
import os.path
import time

def create_file_system_report(output_file="file_report.txt"):
    """
    Создает подробный отчет о файловой системе
    """
    with open(output_file, 'w', encoding='utf-8') as report:
        # Заголовок отчета
        report.write("=" * 70 + "\n")
        report.write("ОТЧЕТ О ФАЙЛОВОЙ СИСТЕМЕ\n")
        report.write(f"Создан: {time.strftime('%Y-%m-%d %H:%M:%S')}\n")
        report.write(f"Текущая директория: {os.path.abspath('.')}\n")
        report.write("=" * 70 + "\n\n")
        
        # Статистика по типам файлов
        file_extensions = {}
        total_files = 0
        total_dirs = 0
        
        # Обход текущей директории
        report.write("ФАЙЛЫ И ПАПКИ:\n")
        report.write("-" * 70 + "\n")
        
        for item in os.listdir("."):
            item_path = os.path.join(".", item)
            abs_path = os.path.abspath(item_path)
            
            if os.path.isfile(item_path):
                # Информация о файле
                size = os.path.getsize(item_path)
                mtime = time.ctime(os.path.getmtime(item_path))
                
                report.write(f"[ФАЙЛ] {abs_path}\n")
                report.write(f"       Размер: {size:,} байт | Изменен: {mtime}\n")
                
                # Статистика по расширениям
                name, ext = os.path.splitext(item)
                ext = ext.lower() if ext else "без расширения"
                file_extensions[ext] = file_extensions.get(ext, 0) + 1
                
                total_files += 1
                
            elif os.path.isdir(item_path):
                report.write(f"[ПАПКА] {abs_path}\n")
                total_dirs += 1
        
        report.write("\n" + "=" * 70 + "\n")
        
        # Статистика
        report.write("СТАТИСТИКА:\n")
        report.write(f"Всего файлов: {total_files}\n")
        report.write(f"Всего папок: {total_dirs}\n")
        
        if file_extensions:
            report.write("\nРАСПРЕДЕЛЕНИЕ ПО РАСШИРЕНИЯМ:\n")
            sorted_exts = sorted(file_extensions.items(), key=lambda x: x[1], reverse=True)
            for ext, count in sorted_exts:
                percentage = (count / total_files) * 100
                report.write(f"  {ext:20} {count:4} файлов ({percentage:.1f}%)\n")
        
        report.write("\n" + "=" * 70 + "\n")
        report.write("КОНЕЦ ОТЧЕТА\n")
        report.write("=" * 70 + "\n")
    
    print(f"Отчет сохранен в: {os.path.abspath(output_file)}")
    print(f"Найдено: {total_files} файлов, {total_dirs} папок")

# Использование
create_file_system_report()
</code></pre>

Пример 4: Утилита для анализа размера директорий
<pre><code class="language-python">
import os.path

def analyze_directory_size(directory="."):
    """
    Рекурсивно анализирует размер директории
    """
    total_size = 0
    file_count = 0
    dir_count = 0
    
    for dirpath, dirnames, filenames in os.walk(directory):
        dir_count += len(dirnames)
        
        for filename in filenames:
            filepath = os.path.join(dirpath, filename)
            
            try:
                size = os.path.getsize(filepath)
                total_size += size
                file_count += 1
            except OSError:
                continue  # Пропускаем файлы без доступа
    
    # Результаты
    print(f"Анализ директории: {os.path.abspath(directory)}")
    print(f"Всего файлов: {file_count}")
    print(f"Всего папок: {dir_count}")
    print(f"Общий размер: {total_size:,} байт")
    
    # Человеко-читаемый формат
    size_gb = total_size / (1024**3)
    size_mb = total_size / (1024**2)
    
    if size_gb >= 1:
        print(f"Общий размер: {size_gb:.2f} GB")
    elif size_mb >= 1:
        print(f"Общий размер: {size_mb:.2f} MB")
    else:
        print(f"Общий размер: {total_size / 1024:.2f} KB")
    
    return total_size, file_count, dir_count

# Использование
analyze_directory_size()
</code></pre>

Ключевые особенности `os.path`:
* **Кроссплатформенность** - автоматически использует правильные разделители для ОС
* **Безопасность** - корректно обрабатывает специальные символы и пути
* **Удобство** - предоставляет высокоуровневые функции для работы с путями
* **Интеграция** - тесно интегрирован с модулем o
