# AWS DynamoDB

Цель работы: загрузить данные в DynamoDB и делать запросы.

## Теория

AWS DynamoDB — это NoSQL (Not only SQL) СУБД с моделью данных типа "ключ-значение".

AWS DynamoDB — это бессерверная СУБД.

В Yandex Cloud есть СУБД YDB, которая умеет работать в режиме совместимости с AWS DynamoDB.

AWS позволяет бесплатно хранить в DynamoDB 25 Гб данных.

Аналоги AWS DynamoDB:
* Azure CosmosDB
* FireBase
* GCP FireStore
* MongoDB Atlas

Partition Key — это основной ключ в таблицах DynamoDB. Может быть бинарный, числовой или строковый.

SDK AWS поддерживает популярные языки программирования (Python, Java, JavaScript, C# и т.д.)
* [https://aws.amazon.com/ru/developer/language/python/](https://aws.amazon.com/ru/developer/language/python/)
* [https://aws.amazon.com/ru/sdk-for-python/](https://aws.amazon.com/ru/sdk-for-python/)
* [https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/index.html](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/index.html)

Для подключения с помощью SDK используется тот же ключ что и для интерфейса командной строки (CLI).

## Ход работы

1. Войдите в веб-консоль AWS\
   [https://console.aws.amazon.com](https://console.aws.amazon.com)\
   volodya-leveryev
2. Создайте ключ доступа (или используйте уже существующий)\
   Открыть меню пользователя, Security credentials, Access Keys.
3. Создайте таблицу DynamoDB (регион ap-northeast-1, имя таблицы: <группа>-<фамилия>, partition key: id, number)
4. Создайте каталог для проекта
5. Создайте и активируйте виртуальное окружение Python
6. Установите пакеты `boto3`, `kaggle`, `PyTelegramBotAPI`
7. Войдите в аккаунт Kaggle.com, создайте ключ доступа и сохраните его в каталоге `~/.kaggle`
8. Скачайте данные из набора данных [https://www.kaggle.com/datasets/ashpalsingh1525/imdb-movies-dataset](https://www.kaggle.com/datasets/ashpalsingh1525/imdb-movies-dataset):
   ```cmd
   kaggle datasets download --unzip "ashpalsingh1525/imdb-movies-dataset"
   ```
9. Загрузить данные с помощью скрипта `load_data.py` в таблицу AWS DynamoDB
10. Запросить в Telegram у BotFather токен для нового бота
11. Запустить бота и проверить его работу

Необходимая документация:
* [Kaggle API](https://github.com/Kaggle/kaggle-api)
* [PythonTelegramAPI](https://pytba.readthedocs.io/en/latest/index.html)
* [Boto3 DynamoDB](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/dynamodb.html)

**load_data.py**:
```python
"""Скрипт для загрузки данных в таблицу DynamoDB"""
from csv import DictReader
from pprint import pprint


import boto3


filename1 = 'imdb_movies.csv'
with open(filename1, encoding='utf-8') as f:
   data_reader = DictReader(f, delimiter=',', quotechar='"')
   data = [row for row in data_reader]


# отладочный вывод
pprint(data[:5])


def clean(name):
   name = name.replace("'", '')
   name = name.replace(',', '')
   name = name.replace('|', '')
   return name.strip()


dynamo = boto3.client(
   'dynamodb',
   aws_access_key_id='Впишите сюда идентификатор ключа доступа',
   aws_secret_access_key='Впишите сюда ключ доступа',
   region_name='Впишите сюда идентификатор региона',
)
key = 0
for row in data[:500]:
   key += 1
   dynamo.put_item(TableName='Название таблицы', Item={
       'id': {'N': str(key)},
       'names': {'S': row['names']},
       'date_x': {'S': row['date_x']},
       'score': {'N': row['score']},
       'genre': {'L': [{'S': x.strip()} for x in row['genre'].split(',')]},
       'overview': {'S': row['overview']},
       'crew': {'L': [{'S': x.strip()} for x in row['crew'].split(",")]},
       'orig_title': {'S': row['orig_title']},
       'status': {'S': row['status']},
       'orig_lang': {'S': row['orig_lang']},
       'budget_x': {'N': row['budget_x']},
       'revenue': {'N': row['revenue']},
       'country': {'S': row['country']},
   })
```

**bot.py**:
```python
from pprint import pformat
import telebot
import boto3


bot = telebot.TeleBot('Впишите сюда токен')


dynamo = boto3.client(
   'dynamodb',
   aws_access_key_id='Впишите сюда идентификатор ключа доступа',
   aws_secret_access_key='Впишите сюда ключ доступа',
   region_name='Впишите сюда идентификатор региона',
)


@bot.message_handler(commands=['help', 'start'])
def send_welcome(message):
   bot.reply_to(message, "Напишите кусочек оригинального названия фильма")


@bot.message_handler(func=lambda message: True)
def echo_message(message):
   text = message.text
   movies = dynamo.scan(TableName='Впишите сюда название таблицы', ScanFilter={
       'names': {
           'AttributeValueList': [{'S': text}],
           'ComparisonOperator': 'CONTAINS'
       }
   })
   if movies['Items']:
       for m in movies['Items']:
           bot.reply_to(message, pformat(m))
   else:
       bot.reply_to(message, 'Ничего не найдено!')


bot.infinity_polling()
```
