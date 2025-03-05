# Бессерверные функции

## Теория

Бессерверные функции — это сервис по запуску функций. При этом разработчик не имеет доступа к серверам на которых они запускаются. Бессерверные функции 

AWS Lambda поддерживает следующие среды программирования (Runtime):
* Node.js
* Python
* Ruby
* Java
* .Net
* Docker-контейнер

Триггер — это какое-либо событие в AWS, которое запускает функцию.

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
1. Войти в веб-консоль AWS.

2. Перейти в сервис AWS в регион Tokyo (ap-northeast-1).

3. Создать функцию:
    * Author from scratch
    * Function name: <группа>-<фамилия>
    * Runtime: Python 3.13
    * Change default execution role, Use an existing role, Existing role: imi-svfu-…

4. Откройте раздел Test:
    * Create new event
    * Event name: Test
    * Template: API Gateway Http API
    * Вставьте значение Event JSON из кода в приложении
    * Сохраните изменения (кнопка **Save**)
    * Выполните тестирование (кнопка **Test**)
    * Разверните детали (Details) выполнения функции (Executing function) и убедитесь что:
      * статус-код 200
      * тело ответа непустое

5. Добавьте триггер:
    * Trigger configuration: API Gateway
    * Create a new API
    * HTTP API
    * Security: Open

6. Откройте раздел Configuration, подраздел Triggers, с помощью ссылки **API endpoint** проверьте работу функции в браузере.

7. Вернитесь в раздел Code, добавьте шаблон HTML-страницы `index.html` (код в приложении).

8. Обновите код в файле `lambda_function.py` (код в приложении).

9. Разверните и протестируйте обновленную версию кода (кнопки **Deploy** и **Test**)

10. Добавьте код, для вычисления суммы аргументов GET-запроса "x" и "y" (не забудьте выполнить преобразование из строки в число).

## Приложения

**Test**
```json
{
  "queryStringParameters": {
    "x": "1",
    "y": "2",
    "ans": "3"
  }
}
```

**index.html**
```html
{% raw %}
<!DOCTYPE html>
<html lang="ru">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Главная</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>

<body>
  <div class="container">
    <div class="row">
      <div class="col">
        <h1>{message}</h1>
      </div>
    </div>
    <form>
      <div class="row mb-3">
        <div class="col">
          <label for="x">Число X:</label>
          <input type="text" name="x" id="x" value="{x}" class="form-control">
        </div>
        <div class="col">
          <label for="y">Число Y:</label>
          <input type="text" name="y" id="y" value="{y}" class="form-control">
        </div>
        <div class="col">
          <label for="xy">Результат:</label>
          <div class="input-group">
            <span class="input-group-text">=</span>
            <input type="text" id="xy" value="{ans}" class="form-control" disabled readonly>
          </div>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col">
          <input type="submit" value="Вычислить">
        </div>
      </div>
    </form>
  </div>
</body>

</html>
{% endraw %}
```

**lambda_function.py**
```python
def render_template(template_filename, **kwargs):
    defaults = {'x': '0', 'y': '0', 'ans': '0'}
    with open(template_filename, encoding='utf-8') as file:
        template = file.read()
    return template.format(**(defaults | kwargs))

def lambda_handler(event, context):
    params = event.get('queryStringParameters', {})
    params['message'] = "Добро пожаловать!"

    # напишите ваш код здесь

    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'text/html; charset=utf-8',
        },
        'body': render_template('index.html', **params)
    }
```
