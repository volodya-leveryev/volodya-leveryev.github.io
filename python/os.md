Конспект по модулю os в Python

Содержание:

1.Введение

2.Рабочая директория

3.Просмотр файлов и папок

4.Создание и удаление каталогов

5.Работа с файлами

6.Переменные окружения

7.Запуск системных команд

8.Информация о файлах

9.Практические задачи

1. Введение

Модуль os предоставляет функции для работы с операционной системой. С его помощью Python-программы могут:

узнавать текущую рабочую директорию

просматривать и управлять файлами и папками

запускать системные команды

работать с переменными окружения

Пример базового импорта:

import os
print(os.name)  # nt (Windows) или posix (Linux/macOS)


Это важно, чтобы понимать особенности ОС, на которой работает скрипт.


2. Рабочая директория

Рабочая директория — это папка, из которой Python выполняет код.

os.getcwd() — получить текущую директорию

Возвращает абсолютный путь текущей рабочей папки.

Примеры:

import os

# 1. Узнать текущую папку
print(os.getcwd())

# 2. Сохранить путь в переменную
current_dir = os.getcwd()
print(f"Текущая папка: {current_dir}")

# 3. Использовать путь для открытия файла
file_path = os.path.join(current_dir, "data.txt")
print(file_path)

os.chdir(path) — сменить рабочую директорию

Меняет текущую рабочую директорию на указанную. Полезно при работе с разными проектами.

Примеры:

# 1. Переход на Desktop
os.chdir("C:/Users/Ivan/Desktop")
print(os.getcwd())

# 2. Переход в родительскую папку
os.chdir("..")
print(os.getcwd())

# 3. Использование относительного пути
os.chdir("projects")
print(os.getcwd())


3. Просмотр файлов и папок
os.listdir(path) — список файлов и папок

Возвращает все файлы и каталоги в указанной папке.

Примеры:

# 1. Список текущей папки
print(os.listdir("."))

# 2. Список другой папки
print(os.listdir("C:/Users/Ivan/Documents"))

# 3. Фильтрация только .txt файлов
txt_files = [f for f in os.listdir(".") if f.endswith(".txt")]
print(txt_files)

os.path.exists(path) — проверка существования

Проверяет, существует ли файл или папка.

Примеры:

# 1. Проверка файла
print(os.path.exists("notes.txt"))

# 2. Проверка папки
print(os.path.exists("reports"))

# 3. Условное создание папки
if not os.path.exists("backup"):
    os.mkdir("backup")


4. Создание и удаление каталогов
os.mkdir(name) — создать папку

Создает одну папку. Если папка существует, выдаст ошибку.

Примеры:

# 1. Создать папку reports
os.mkdir("reports")

# 2. Создать папку при отсутствии
if not os.path.exists("backup"):
    os.mkdir("backup")

# 3. Использовать папку для сохранения файла
os.mkdir("logs")
with open("logs/log1.txt", "w") as f:
    f.write("Log 1")

os.makedirs(path) — создать вложенные папки

Создает сразу несколько уровней вложенности.

Примеры:

# 1. Создать 2026/january/data
os.makedirs("2026/january/data")

# 2. Создать с проверкой
if not os.path.exists("2026/february"):
    os.makedirs("2026/february")

# 3. Создать для проекта
os.makedirs("project/src/utils", exist_ok=True)

os.rmdir(path) — удалить пустую папку

Удаляет только пустые папки.

Примеры:

# 1. Удалить пустую папку reports
os.rmdir("reports")

# 2. Удалить папку backup, если пуста
if os.path.exists("backup") and not os.listdir("backup"):
    os.rmdir("backup")

# 3. Удалить временную папку logs
folder = "logs"
if os.path.exists(folder) and not os.listdir(folder):
    os.rmdir(folder)


5. Работа с файлами
os.remove(path) — удалить файл
# 1. Удалить конкретный файл
os.remove("test.txt")

# 2. Удалить все временные .tmp файлы
for f in os.listdir("."):
    if f.endswith(".tmp"):
        os.remove(f)

# 3. Удалить файл, только если он существует
if os.path.exists("old_data.csv"):
    os.remove("old_data.csv")

os.rename(src, dst) — переименовать или переместить
# 1. Переименовать файл
os.rename("file1.txt", "file2.txt")

# 2. Переместить файл в другую папку
os.rename("file2.txt", "backup/file2.txt")

# 3. Переименовать с проверкой существования
if os.path.exists("notes_old.txt"):
    os.rename("notes_old.txt", "notes_new.txt")


6. Переменные окружения
os.environ и os.getenv(key)

Переменные окружения хранят настройки системы.

Примеры:

# 1. Вывести PATH
print(os.environ["PATH"])

# 2. Получить домашнюю папку пользователя
home = os.getenv("HOME", "Unknown")
print(home)

# 3. Создать пользовательскую переменную
os.environ["MODE"] = "DEV"
print(os.environ.get("MODE"))


7. Запуск системных команд
os.system(command) — выполнить команду ОС
# 1. Список файлов
os.system("dir")  # Windows
os.system("ls")   # Linux/macOS

# 2. Проверка интернета
os.system("ping google.com")

# 3. Открыть текстовый редактор
os.system("notepad")


8. Информация о файлах
os.path.getsize(path) — размер файла
# 1. Размер одного файла
print(os.path.getsize("data.txt"))

# 2. Сравнение размеров
if os.path.getsize("a.txt") > os.path.getsize("b.txt"):
    print("a.txt больше b.txt")

# 3. Размер всех txt файлов в папке
for f in os.listdir("."):
    if f.endswith(".txt"):
        print(f, os.path.getsize(f))

os.path.abspath(path) — абсолютный путь
# 1. Путь к data.txt
print(os.path.abspath("data.txt"))

# 2. Абсолютный путь для отчета
path = os.path.abspath("logs/log1.txt")
print(path)

# 3. Использование для открытия файла
with open(os.path.abspath("data.txt")) as f:
    print(f.read())

os.path.isfile(path) и os.path.isdir(path)
# 1. Проверка файла и папки
print(os.path.isfile("data.txt"))
print(os.path.isdir("logs"))

# 2. Проверка перед записью
if os.path.isfile("config.txt"):
    print("Файл готов к чтению")

# 3. Создание папки при отсутствии
if not os.path.isdir("backup"):
    os.mkdir("backup")


9. Практические задачи
import os

# Пример 1: Найти все .txt файлы и переместить их в backup
if not os.path.exists("backup"):
    os.mkdir("backup")
for f in os.listdir("."):
    if f.endswith(".txt"):
        os.rename(f, f"backup/{f}")

# Пример 2: Вывести размеры всех файлов в папке logs
for f in os.listdir("logs"):
    path = os.path.join("logs", f)
    if os.path.isfile(path):
        print(f"{f}: {os.path.getsize(path)} bytes")

# Пример 3: Создать файл отчета с абсолютными путями всех файлов
with open("file_report.txt", "w") as report:
    for f in os.listdir("."):
        report.write(os.path.abspath(f) + "\n")
