# Основные варианты использования СУБД Redis:

Варианты использования СУБД Redis:

* Хранилище сессий
* Кеш HTML-страниц
* Кеш данных из БД
* Очередь сообщений (ZeroMQ, RabbitMQ, ...)
* Подписка на события

# Создание веб-сайта на Flask

Перед началом убедитесь, что у вас установлен Redis и его служба запущена.

1. Создание каталога для примера:
```
mkdir lesson2
cd lesson2
```
2. Создание виртуального окружения:
```
python -m venv venv
venv\scripts\activate
```
3. Установка Flask и Redis
```
pip install flask redis
```
4. Создание минимального сайта на Flask
```python
# app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'

app.run()
```
