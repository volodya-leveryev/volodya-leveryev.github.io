# Конспект по модулю os в Python

# Содержание

1. Введение  
2. Рабочая директория  
3. Просмотр файлов и папок  
4. Создание и удаление каталогов  
5. Работа с файлами  
6. Переменные окружения  
7. Запуск системных команд  
8. Информация о файлах  
9. Практические задачи  

---

1. Введение

Модуль `os` предоставляет функции для взаимодействия с операционной системой.  
С его помощью Python-программы могут:

- узнавать и менять текущую рабочую директорию  
- просматривать, создавать, удалять и переименовывать файлы и папки  
- запускать команды операционной системы  
- работать с переменными окружения  

python
import os

print(os.name)          # nt     → Windows
                        # posix  → Linux / macOS

2. Рабочая директория
Текущая рабочая директория — это папка, из которой запускается и выполняется скрипт.
Pythonimport os

# Получить текущую директорию
print(os.getcwd())
# Пример вывода:
# /home/student/projects/python-course
Python# Сохранить в переменную
current_dir = os.getcwd()
print(f"Текущая папка: {current_dir}")
# Текущая папка: /home/student/projects/python-course
Python# Сменить рабочую директорию
os.chdir("/home/student/Desktop")
print(os.getcwd())
# /home/student/Desktop

# Вернуться на уровень выше
os.chdir("..")
print(os.getcwd())
# /home/student

3. Просмотр файлов и папок
Python# Список всего содержимого текущей папки
print(os.listdir("."))
# Пример вывода:
# ['data.txt', 'logs', 'script.py', 'images']
Python# Только файлы с расширением .txt
txt_files = [f for f in os.listdir(".") if f.endswith(".txt")]
print(txt_files)
# ['notes.txt', 'report.txt', 'data.txt']
Python# Проверка существования
print(os.path.exists("config.yaml"))      # True / False
print(os.path.exists("backup_folder"))    # True / False

4. Создание и удаление каталогов
Python# Создать одну папку
os.mkdir("reports")
# Если уже существует → FileExistsError

# Безопасное создание
if not os.path.exists("backup"):
    os.mkdir("backup")
Python# Создать вложенные папки (самый удобный способ)
os.makedirs("logs/2025/january/error", exist_ok=True)
# exist_ok=True → не будет ошибки, если папка уже есть
Python# Удалить пустую папку
os.rmdir("empty_folder")
# Ошибка, если папка не пуста!

5. Работа с файлами
Python# Удалить файл
if os.path.exists("temp.txt"):
    os.remove("temp.txt")
Python# Переименовать / переместить
os.rename("old_report.txt", "archive/report_2025.txt")
# Если папки archive нет — будет ошибка
Python# Массовое переименование (пример)
for filename in os.listdir("."):
    if filename.endswith(".log"):
        new_name = filename.replace(".log", ".txt")
        os.rename(filename, new_name)

6. Переменные окружения
Python# Посмотреть все переменные (много!)
# print(os.environ)

# Самые полезные
print(os.environ.get("PATH"))           # длинный путь...
print(os.getenv("HOME"))                # /home/student
print(os.getenv("USER"))                # student

# Создать/изменить свою
os.environ["MY_APP_MODE"] = "production"
print(os.environ.get("MY_APP_MODE"))    # production

7. Запуск системных команд
Python# !!! Используется не очень часто — лучше subprocess

# Простой пример
os.system("dir")               # Windows
os.system("ls -la")            # Linux/macOS
os.system("ping -c 4 google.com")
Python# Возвращает код завершения (0 = успех)
result = os.system("mkdir temp_folder")
print("Код выполнения:", result)   # 0

8. Информация о файлах
Python# Размер файла в байтах
print(os.path.getsize("photo.jpg"))     # 1245184

# Абсолютный путь
print(os.path.abspath("data.csv"))
# Пример: /home/student/projects/data.csv
Python# Проверка типа
print(os.path.isfile("document.pdf"))   # True/False
print(os.path.isdir("photos"))          # True/False

# Комбинированный пример
path = "logs/error.log"
if os.path.exists(path):
    if os.path.isfile(path):
        print(f"Файл {path} существует, размер: {os.path.getsize(path)} байт")

9. Практические задачи (примеры)
Задача 1: Переместить все .txt файлы в папку backup
Pythonimport os

backup_dir = "backup"
if not os.path.exists(backup_dir):
    os.makedirs(backup_dir)

for file in os.listdir("."):
    if file.endswith(".txt"):
        os.rename(file, os.path.join(backup_dir, file))
        print(f"Перемещён: {file}")
Задача 2: Вывести размер всех файлов в папке logs
Pythonimport os

folder = "logs"
for file in os.listdir(folder):
    path = os.path.join(folder, file)
    if os.path.isfile(path):
        size = os.path.getsize(path)
        print(f"{file:20} → {size:8} байт")
Задача 3: Создать отчёт со всеми абсолютными путями
Pythonimport os

with open("file_list.txt", "w", encoding="utf-8") as f:
    for item in os.listdir("."):
        full_path = os.path.abspath(item)
        f.write(full_path + "\n")

print("Отчёт сохранён в file_list.txt")
