# Бессерверные функции

## Теория

Бессерверные функции — это сервис по запуску функций. При этом разработчик не имеет доступа к серверам на которых они запускаются.

AWS Lambda поддерживает следующие среды программирования (Runtime):
* Node.js
* Python
* Ruby
* Java
* .Net
* Кастомная среда на базе Amazon Linux

Триггер — событие в AWS, которое запускает функцию.

Event — входные данные, которые триггер передает функции.

Context — данные среды запуске, которые доступны в функции.

AWS API Gateway — сервис AWS который принимает HTTP-запросы (например из браузера).

В состав функции может входить множество файлов. Если разработчику нужны сторонние библиотеки не входящие в Runtime то их нужно добавить (учитывайте возможности Runtime).

AWS версионирует код функций.

При публикации большого количества или больших файлов лучше использовать загрузку с помощью ZIP-файлов. Поддерживается загрузка с локального компьютера или бакета S3.

Достоинства:
* дешевые, при небольшой нагрузке
* быстро масштабируется
* хорошо интегрируется с другими сервисами AWS

Недостатки:
* дорого при большой нагрузке
* сложно добавить кастомные библиотеки
* есть ограничения по ОЗУ и продолжительности работы
* задержка при холодном старте функций (~ 400 мс)

Наиболее популярные фреймворки, автоматизирующие разработку функций в AWS Lambda:
* [AWS Chalice](https://github.com/aws/chalice) — на Python, напоминает Flask
* [Zappa](https://github.com/zappa/Zappa) — на Python, напоминает Django
* [Serverless.com](https://www.serverless.com/) — на разных языках программирования

Аналоги:
* [Azure Functions](https://azure.microsoft.com/en-us/products/functions)
* [Google Cloud Functions](https://cloud.google.com/functions)
* [Google Cloud Run](https://cloud.google.com/run) — бессерверный запуск контейнеров
* [Yandex Cloud Functions](https://cloud.yandex.ru/ru/services/functions)
* [Yandex Serverless Containers](https://cloud.yandex.ru/ru/services/serverless-containers) — бессерверный запуск контейнеров
* [Cloudflare Workers](https://workers.cloudflare.com/) — нет задержки при холодном старте

AWS Lambda Free Tier — 1 миллион запусков в месяц бесплатно.

AWS Lambda часто применяется для задач ETL (Extract, Transform, Load).

## Практика
1. Войти в веб-консоль AWS

2. Перейти в сервис AWS в регион ap-northeast-1

3. Создать функцию:\
   Author from scratch\
   Function name: <группа>-<фамилия>\
   Runtime: Python 3.12\
   Execution role: imi-svfu-…

4. Протестировать (в первый запуск нужно создать тестовые данные)

5. Добавить триггер\
   Source: AWS API Gateway\
   Create new API\
   HTTP API\
   Security: Open

6. Проверить работу функции в браузере с помощью ссылки на вкладке Configuration

7. Добавить шаблон страницы, исправить заголовки

8. Проверить работу функции в браузере

9. Добавить возможность вычисления суммы аргументов GET-запроса. Например запрос может быть http://URL-функции/?x=5&y=7
