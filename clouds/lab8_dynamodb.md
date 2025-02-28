# AWS DynamoDB

Цель работы: познакомиться с сервисом Amazon DynamoDB.

## Теория

Amazon DynamoDB — это полностью управляемая NoSQL (Not only SQL) система управления базами данных с моделью данных типа "ключ-значение". Она оптимизирована для быстрого и масштабируемого хранения данных с низкой задержкой.

Особенности:
* *Бессерверная* (без явно закрепленных серверов) – AWS автоматически управляет масштабированием и производительностью.
* *Масштабируемость* – автоматически адаптируется к нагрузке (от нескольких записей до миллионов).
* *Быстродействие* – отклик менее 10 мс даже при высоких нагрузках.
* *Встроенная репликация* – данные хранятся в нескольких Availability Zones для отказоустойчивости.
* *Гибкая модель данных* – поддерживает ключ-значение и документ-ориентированное хранение.
* *On-Demand* или *Provisioned Capacity* – выбор между автоматическим и ручным масштабированием.

DynamoDB не использует SQL, а базируется на принципе "ключ-значение".

Важные понятия:
* *Таблица (Table)* – основной объект в DynamoDB, аналог таблицы в реляционной базе.
* *Атрибут (Attribute)* – свойство (поле) объекта, аналог колонки в SQL.
* *Элемент (Item)* – строка данных с уникальным ключом.
* *Ключ (Key)* — служебный атрибут, который используется для идентификации строк и для определения в каком порядке физически хранятся данные.
* *Partition Key (PK)* – уникальный идентификатор элемента, хеш которого используется для разнесения их по разделам. Может быть бинарным, числовым или строковым.
* *Раздел (Partition)* — часть строк таблицы которые хранятся совместно. DynamoDB автоматически разбивает таблицу на разделы для повышения масштабируемости и производительности. Каждая запись (Item) хранится в одном из Partition.
* *Sort Key (SK)* – опциональный служебный атрибут в таблице, который позволяет упорядочивать данные в рамках раздела.
* *Индексы (Index)* — позволяют быстро находить данные по неосновным атрибутам.

AWS позволяет бесплатно хранить в DynamoDB до 25 Гб данных.

Аналоги AWS DynamoDB:
* Azure CosmosDB
* FireBase
* GCP FireStore
* MongoDB Atlas
* Yandex YDB

Для работы с DynamoDB из программного кода используется SDK. AWS поддерживает SDK для всех основных промышленных языков программирования (Python, Java, JavaScript, C# и т.д.).

SDK AWS для Python называется [Boto3](https://pypi.org/project/boto3/).

Для подключения с помощью SDK используется тот же ключ что и для интерфейса командной строки (CLI).

## Ход работы

1. Войдите в [веб-консоль AWS](https://console.aws.amazon.com).

2. Создайте *ключ доступа* (или используйте уже существующий) (меню пользователя, Security credentials, Access Keys).

3. Откройте сервис **DynamoDB**, создайте таблицу:
    * имя таблицы: <группа>-<фамилия>
    * partition key: `key`, тип данных number

4. На локальном компьютере создайте каталог для проекта.

5. Создайте и активируйте виртуальное окружение Python.

6. Установите пакеты `boto3`, `kaggle`, `flask` и `python-dotenv`.

7. Скачайте данные из [набора данных](https://www.kaggle.com/datasets/harshitshankhdhar/imdb-dataset-of-top-1000-movies-and-tv-shows):
    ```cmd
    kaggle datasets download --unzip "harshitshankhdhar/imdb-dataset-of-top-1000-movies-and-tv-shows"
    ```

8. Создайте конфигурационный файл `.env` и скрипт `load_data.py` с помощью прилагаемых листингов.

9. Изучите исходный код в скрипте `load_data.py` и [документацию Boto3 DynamoDB](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb.html). Внесите изменения, чтобы скрипт:
    * подключился к DynamoDB с помощью *ключа доступа* к созданной вами таблице
    * загрузил первые 100 строк из набора данных используя метод `put_item()`

10. Запустите скрипт, в сервисе **DynamoDB** откройте раздел **Explore items** и убедитесь что данные успешно загрузились.

11. Выберите произвольный элемент, откройте редактор элемента и убедитесь что при загрузке сохранилась структура данных.

12. Создайте файлы `app.py` и `templates\index.html`.

13. Изучите исходный код в скрипте `app.py` и [документацию Boto3 DynamoDB](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb.html). Внесите изменения, чтобы скрипт:
    * читал строки с помощью `scan()`
    * накладывал фильтр на строки с помощью метода `query()`

14. Запустите приложение на Flask:

    ```cmd
    flask run
    ```

15. Проверьте работу приложения в браузере.

16. *Доп.задание:* реализуйте возможность просмотра карточки фильма с помощью метода `get_item()`.

## Приложения

**`.env`**
```python
ACCESS_KEY_ID = ""
ACCESS_SECRET = ""
AWS_REGION = ""
TABLE_NAME = ""
```

**`load_data.py`**:
```python
"""Поэлементная загрузка данных в таблицу DynamoDB"""

from csv import DictReader
from os import getenv
from pprint import pprint

import boto3
from dotenv import load_dotenv

N = 100


def load_data():
    filename = 'imdb_top_1000.csv'
    with open(filename, encoding='utf-8') as f:
        reader = DictReader(f, delimiter=',', quotechar='"')
        rows = [row for row in reader]

    # Выводим для проверки первые 5 строк
    pprint(rows[:5])
    return rows


def prepare_numeric(value):
    if value:
        return {'N': value.replace(',', '')}
    else:
        return {'N': '0'}


def main():
    load_dotenv()

    dynamo = boto3.client(
        'dynamodb',
        aws_access_key_id=getenv('ACCESS_KEY_ID'),
        aws_secret_access_key=getenv('ACCESS_SECRET'),
        region_name=getenv("AWS_REGION"),
    )

    rows = load_data()
    for key, row in enumerate(rows[:N]):
        poster_link, _, _ = row['Poster_Link'].rsplit('.', maxsplit=2)
        poster_link += '._V1_SX300.jpg'
        new_item = {
            'key': {'N': str(key)},
            'Title': {'S': row['Series_Title']},
            'Poster': {'S': poster_link},
            'Year': {'N': row['Released_Year']},
            'Certificate': {'S': row['Certificate']},
            'Runtime': {'S': row['Runtime']},
            'Genre': {'L': [{'S': x.strip()} for x in row['Genre'].split(',')]},
            'Rating': {'N': row['IMDB_Rating']},
            'Overview': {'S': row['Overview']},
            'Director': {'S': row['Director']},
            'Stars': {'L':[
                {'S': row['Star1']},
                {'S': row['Star2']},
                {'S': row['Star3']},
                {'S': row['Star4']},
            ]},
            'Meta_score': prepare_numeric(row.get('Meta_score')),
            'Votes': prepare_numeric(row.get('No_of_Votes')),
            'Gross': prepare_numeric(row.get('Gross')),
        }

        # напишите здесь вызов метода put_item() для загрузки нового элемента

        print(f'\r{key:3d}/{N} rows loaded', end='')


if __name__ == '__main__':
    main()
```

**`app.py`**:
```python
"""Сайт для просмотра данных из таблицы DynamoDB"""
from os import getenv

import boto3
from dotenv import load_dotenv
from flask import Flask, render_template, request

load_dotenv()

dynamo = boto3.client(
    'dynamodb',
    aws_access_key_id=getenv('ACCESS_KEY_ID'),
    aws_secret_access_key=getenv('ACCESS_SECRET'),
    region_name=getenv("AWS_REGION"),
)

app = Flask(__name__)


@app.route('/')
def index_page():
    substring = request.args.get('q', '')
    movies = []

    # Здесь опишите получение данных из DynamoDB

    return render_template('index.html',
                           movies=movies,
                           substring=substring)
```

**`templates\index.html`**
```html
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>DynamoDB</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<div class="container">
  <div class="row">
    <div class="col">
      <h1>Добро пожаловать!</h1>
    </div>
  </div>
  <div class="row">
    <div class="col">
      <form>
        <div class="mb-3">
          <label for="q" class="form-label">Фильтр</label>
          <input type="text" name="q" id="q" class="form-control" value="{{ substring }}">
        </div>
      </form>
    </div>
  </div>
  <div class="row row-cols-1 row-cols-md-4">
    {% for item in movies %}
    <div class="col">
      <div class="card">
        <img src="{{ item['Poster']['S'] }}" class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title">{{ item['Title']['S'] }}</h5>
          <p class="card-text">
            Добавьте сюда описание фильма
          </p>
        </div>
      </div>
    </div>
    {% endfor %}
  </div>
</div>
</body>
</html>
```