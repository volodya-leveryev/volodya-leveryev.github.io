# Модуль `os` в Python — подробный конспект

## Содержание

1. [Введение](#введение)  
2. [Рабочая директория](#рабочая-директория)  
3. [Просмотр файлов и папок](#просмотр-файлов-и-папок)  
4. [Создание и удаление каталогов](#создание-и-удаление-каталогов)  
5. [Работа с файлами](#работа-с-файлами)  
6. [Переменные окружения](#переменные-окружения)  
7. [Запуск системных команд](#запуск-системных-команд)  
8. [Информация о файлах](#информация-о-файлах)  
9. [Практические задачи](#практические-задачи)

---

### 1. Введение

Модуль `os` предоставляет функции для взаимодействия с операционной системой.  
С его помощью Python-программы могут:

- узнавать текущую рабочую директорию
- просматривать и управлять файлами и папками
- запускать системные команды
- работать с переменными окружения

```python
import os

print(os.name)  # 'nt' (Windows) или 'posix' (Linux/macOS)
Понимание os.name важно для написания кроссплатформенного кода.

2. Рабочая директория
Рабочая директория — это папка, из которой запущен Python-скрипт.
Pythonimport os

# Текущая рабочая директория
print(os.getcwd())                    # абсолютный путь

current_dir = os.getcwd()
print(f"Текущая папка: {current_dir}")

# Полезно при формировании путей
file_path = os.path.join(current_dir, "data", "results.txt")
print(file_path)
Смена рабочей директории
Pythonos.chdir(path)   # меняет текущую рабочую директорию

# Примеры:
os.chdir("C:/Users/Ivan/Desktop")      # абсолютный путь (Windows)
os.chdir("/home/ivan/projects")        # Linux/macOS
os.chdir("..")                         # на уровень выше
os.chdir("data/processed")             # относительный путь
print(os.getcwd())

3. Просмотр файлов и папок
Pythonos.listdir(path=".")          # → список всех файлов и папок в директории
os.path.exists(path)          # → True/False — существует ли путь
Python# 1. Содержимое текущей папки
print(os.listdir())

# 2. Содержимое конкретной папки
print(os.listdir("C:/Users/Ivan/Documents"))

# 3. Только .txt файлы (list comprehension)
txt_files = [f for f in os.listdir(".") if f.endswith(".txt")]
print(txt_files)

# 4. Проверка существования
print(os.path.exists("notes.txt"))      # файл
print(os.path.exists("backup"))         # папка

# 5. Условное создание (классический паттерн)
if not os.path.exists("backup"):
    os.mkdir("backup")

4. Создание и удаление каталогов

























ФункцияЧто делаетВажные особенностиos.mkdir(path)Создаёт одну папкуОшибка, если уже существуетos.makedirs(path)Создаёт вложенные папкиexist_ok=True — не падает при наличииos.rmdir(path)Удаляет пустую папкуОшибка, если внутри есть файлы/папки
Python# Создание одной папки
os.mkdir("reports")

# Безопасное создание
if not os.path.exists("backup"):
    os.mkdir("backup")

# Вложенные папки
os.makedirs("2025/logs/error", exist_ok=True)

# Удаление пустой папки
os.rmdir("temp_empty")

# Безопасное удаление пустой папки
folder = "temp"
if os.path.exists(folder) and not os.listdir(folder):
    os.rmdir(folder)

5. Работа с файлами
Pythonos.remove(path)      # удалить файл
os.rename(src, dst)  # переименовать / переместить
Python# Удаление
os.remove("temp.txt")

# Удаление всех .tmp файлов
for f in os.listdir("."):
    if f.endswith(".tmp"):
        os.remove(f)

# Переименование / перемещение
os.rename("old_report.txt", "archive/report_2025.txt")

# Классический безопасный вариант
if os.path.exists("bad_name.txt"):
    os.rename("bad_name.txt", "good_name.txt")

6. Переменные окружения
Pythonimport os

# Все переменные (словарь)
print(os.environ)

# Конкретная переменная
print(os.environ["PATH"])
print(os.environ.get("USER"))           # безопаснее (не падает при отсутствии)

# Альтернативный способ
home = os.getenv("HOME", "Не найдено")
print(home)

# Создание/изменение (только на время выполнения скрипта)
os.environ["MY_APP_MODE"] = "production"

7. Запуск системных команд
Pythonos.system("команда")   # возвращает код возврата (0 — обычно успех)
Python# Windows
os.system("dir")
os.system("cls")

# Linux/macOS
os.system("ls -la")
os.system("clear")

# Кроссплатформенные примеры
os.system("ping -c 4 google.com")     # Linux/macOS
os.system("ping google.com -n 4")     # Windows
Примечание: сейчас чаще используют subprocess вместо os.system

8. Информация о файлах
Pythonos.path.getsize(path)     # размер в байтах
os.path.abspath(path)     # абсолютный путь
os.path.isfile(path)      # это файл?
os.path.isdir(path)       # это папка?
Pythonprint(os.path.getsize("data.csv"))          # → 4231

print(os.path.abspath("notes.txt"))         # полный путь от корня диска

print(os.path.isfile("config.json"))        # True/False
print(os.path.isdir("src/utils"))           # True/False

# Пример: размер всех .txt в текущей папке
for f in os.listdir("."):
    if f.endswith(".txt"):
        print(f"{f:30} {os.path.getsize(f):8d} байт")

9. Практические задачи
Pythonimport os

# 1. Переместить все .txt в backup
if not os.path.exists("backup"):
    os.mkdir("backup")

for f in os.listdir("."):
    if f.endswith(".txt"):
        os.rename(f, os.path.join("backup", f))

# 2. Отчёт о размерах файлов в папке logs
for f in os.listdir("logs"):
    path = os.path.join("logs", f)
    if os.path.isfile(path):
        print(f"{f:25} → {os.path.getsize(path):6d} байт")

# 3. Создать текстовый файл со всеми абсолютными путями
with open("all_files.txt", "w", encoding="utf-8") as report:
    for f in os.listdir("."):
        report.write(os.path.abspath(f) + "\n")
