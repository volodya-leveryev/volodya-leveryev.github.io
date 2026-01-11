
Markdown# Модуль `os` в Python 

## Содержание

1. [Введение](#1-введение)  
2. [Рабочая директория](#2-рабочая-директория)  
3. [Просмотр файлов и папок](#3-просмотр-файлов-и-папок)  
4. [Создание и удаление каталогов](#4-создание-и-удаление-каталогов)  
5. [Работа с файлами](#5-работа-с-файлами)  
6. [Переменные окружения](#6-переменные-окружения)  
7. [Запуск системных команд](#7-запуск-системных-команд)  
8. [Информация о файлах](#8-информация-о-файлах)  
9. [Практические задачи](#9-практические-задачи)

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
Понимание значения os.name важно для написания кроссплатформенного кода.

2. Рабочая директория
Pythonimport os

# Текущая рабочая директория (абсолютный путь)
print(os.getcwd())

current_dir = os.getcwd()
print(f"Текущая папка: {current_dir}")

# Формирование пути (рекомендуемый способ)
file_path = os.path.join(current_dir, "data", "results.txt")
print(file_path)
Смена рабочей директории
Pythonos.chdir(path)  # меняет текущую рабочую директорию

# Примеры:
os.chdir(r"C:\Users\Ivan\Desktop")         # Windows
os.chdir("/home/ivan/projects")            # Linux/macOS
os.chdir("..")                             # на уровень выше
os.chdir("data/processed")                 # относительный путь

print(os.getcwd())                         # контроль

3. Просмотр файлов и папок
Pythonos.listdir(path=".")          # список файлов и папок
os.path.exists(path)          # существует ли путь → True/False
Python# 1. Содержимое текущей папки
print(os.listdir())

# 2. Конкретная папка
print(os.listdir(r"C:\Users\Ivan\Documents"))

# 3. Только .txt файлы
txt_files = [f for f in os.listdir(".") if f.endswith(".txt")]
print(txt_files)

# 4. Проверка существования
print(os.path.exists("notes.txt"))     # файл
print(os.path.exists("backup"))        # папка

# 5. Классический безопасный паттерн создания
if not os.path.exists("backup"):
    os.mkdir("backup")

4. Создание и удаление каталогов
Pythonos.mkdir(path)       # создаёт одну папку (ошибка, если уже есть)
os.makedirs(path)    # создаёт вложенные папки (есть exist_ok)
os.rmdir(path)       # удаляет **пустую** папку
Python# Одна папка
os.mkdir("reports")

# Безопасное создание
if not os.path.exists("backup"):
    os.mkdir("backup")

# Вложенные папки (современный и рекомендуемый способ)
os.makedirs("2025/logs/error", exist_ok=True)

# Удаление пустой папки
os.rmdir("temp_empty")

# Безопасное удаление
folder = "temp"
if os.path.exists(folder) and not os.listdir(folder):
    os.rmdir(folder)

5. Работа с файлами
Pythonos.remove(path)      # удалить файл
os.rename(src, dst)  # переименовать или переместить
Python# Удаление
os.remove("temp.txt")

# Удаление всех .tmp файлов
for f in os.listdir("."):
    if f.endswith(".tmp"):
        os.remove(f)

# Переименование / перемещение
os.rename("old_report.txt", "archive/report_2025.txt")

# Безопасный вариант
if os.path.exists("bad_name.txt"):
    os.rename("bad_name.txt", "good_name.txt")

6. Переменные окружения
Pythonimport os

# Все переменные (словарь)
print(os.environ)

# Конкретная переменная
print(os.environ["PATH"])

# Безопасный способ получения
print(os.environ.get("USER", "Не установлено"))

# Альтернатива
home = os.getenv("HOME", "Не найдено")
print(home)

# Установка на время работы скрипта
os.environ["MY_APP_MODE"] = "production"

7. Запуск системных команд
Pythonos.system("команда")   # возвращает код возврата (0 — успех)
Python# Примеры
os.system("dir")                      # Windows
os.system("ls -la")                   # Linux/macOS
os.system("cls")                      # очистка экрана Windows
os.system("clear")                    # Linux/macOS

os.system("ping -n 4 google.com")     # Windows
os.system("ping -c 4 google.com")     # Linux/macOS
Примечание: в современных проектах чаще используют модуль subprocess

8. Информация о файлах (os.path)
Pythonos.path.getsize(path)    # размер в байтах
os.path.abspath(path)    # абсолютный путь
os.path.isfile(path)     # это файл?
os.path.isdir(path)      # это папка?
Pythonprint(os.path.getsize("data.csv"))

print(os.path.abspath("notes.txt"))

print(os.path.isfile("config.json"))    # True/False
print(os.path.isdir("src/utils"))

# Пример: размеры всех .txt файлов
for f in os.listdir("."):
    if f.endswith(".txt"):
        size = os.path.getsize(f)
        print(f"{f:30} {size:8,} байт")

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
        print(f"{f:25} → {os.path.getsize(path):6,} байт")

# 3. Список всех абсолютных путей в файл
with open("all_files.txt", "w", encoding="utf-8") as report:
    for f in os.listdir("."):
        report.write(os.path.abspath(f) + "\n")
