# AWS Step funcions

## Практическая часть

1. Войдите в веб-консоль управления AWS, перейдите в регион Tokyo (ap-northeast-1).

2. Откройте сервис **Amazon SNS (Simple Notification Service)**, перейдите в раздел **Topics** и создайте тему для рассылок (Create topic):

    * Type: Standard topic.
    * Name: <Группа>-<Фамилия>.
    * Значения остальных параметров оставьте без изменений.

    После создания темы для рассылок, зафиксируйте её ARN (Amazon Resource Name).

3. Перейдите в раздел **Subscriptions** и создайте подписку (Create subscription):

    * Topic ARN: выберите созданную тему для рассылки.
    * Protocol: Email.
    * Endpoint: <Ваш email>.
    * Значения остальных параметров оставьте без изменений.

    Войдите в свой почтовый ящик и подтвердите рассылку.

4. Откройте сервис **Amazon S3 (Simple Storage Service)**, перейдите в раздел **General purpose buckets** и создайте бакет:

    * Bucket name: <Группа>-<Фамилия>.
    * Значения остальных параметров оставьте без изменений.

5. Откройте сервис **AWS Lambda**, перейдите в раздел **Functions** и создайте функцию (Create function):

    * Function name: <Группа>-<Фамилия>.
    * Runtime: Python 3.13.
    * Change default execution role, Exectution role: Use an execution role
    * Change default execution role, Existing role: service-role/imi-svfu-role-...

6. Создайте триггер для созданной функции:

    * Trigger configuration: API Gateway
    * Create a new API
    * HTTP API
    * Security: Open

7. Откройте сервис **AWS Step Functions**, перейдите в раздел **State machines** и создайте конечный автомат (Create state machine):

    * State machine name: <Группа>-<Фамилия>.
    * Значения остальных параметров оставьте без изменений.

    Нажмите **Continue** чтобы перейти к редактированию кода конечного автомата.

    Переключите режим отображения конечного автомата на `Code`, измените код конечного автомата (см. код в приложении).

    Нажмите **Create** и подтвердите создание конечного автомата.

8. Переключите режим отображения конечного автомата на `Config`, зафиксируйте идентификатор роли (Role ARN).

9. Вернитесь к бакету S3, переключитесь в раздел настройки прав доступа (Permissions) и создайте правило доступа к бакету (см. код в приложении).

10. Исправьте код созданной ранее функции в сервисе **AWS Lambda** (см. код в приложении).

11. Проверьте работу созданного сервиса.

## Приложения

**Описание Step Function:**
```json
{% raw %}
{
  "QueryLanguage": "JSONata",
  "Comment": "Регистрация заявки с одобрением через SNS и сохранением в S3",
  "StartAt": "Send Approval Request",
  "States": {
    "Send Approval Request": {
      "Type": "Task",
      "Resource": "arn:aws:states:::sns:publish.waitForTaskToken",
      "Arguments": {
        "TopicArn": "<Вставьте ARN вашей темы для рассылки (SNS Topic)>",
        "Subject": "Запрос на одобрение",
        "Message": "{% '<URL созданного HTTP API>' & '?status=approved&token=' & $encodeUrlComponent($states.context.Task.Token) %}"
      },
      "Assign": {
        "form": "{% $states.input %}"
      },
      "Next": "Save to S3"
    },
    "Save to S3": {
      "Type": "Task",
      "Resource": "arn:aws:states:::aws-sdk:s3:putObject",
      "Arguments": {
        "Bucket": "<Имя созданного бакета>",
        "Key": "{% $states.context.Execution.StartTime & '.json' %}",
        "Body": "{% $form %}"
      },
      "End": true
    }
  }
}
{% endraw %}
```

**Правило доступа в бакет S3**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Principal": {
        "AWS": "<ARN роли созданной в Step Function>"
      },
      "Effect": "Allow",
      "Action": "s3:PutObject",
      "Resource": "<ARN бакета S3>/*"
    }
  ]
}
```

**lambda_function.py**
```python
import json
import boto3

sfn = boto3.client('stepfunctions')

with open("index.html") as f:
    html = f.read()

def lambda_handler(event, context):
    params = event.get("queryStringParameters", {})

    name = params.get("name", "")
    email = params.get("email", "")
    if name and email:
        sfn.start_execution(
            stateMachineArn="<ARN конечного автомата Step Function>",
            input=json.dumps({
              "name": name, "email": email,
              "text": params.get("text", ""),
            }),
        )
        return {
            "statusCode": 200,
            "body": "Ваша заявка успешно отправлена администратору",
        }

    token = params.get("token", "")
    status = params.get("status", "")
    if token and status:
        sfn.send_task_success(
            taskToken=token,
            output=json.dumps({"status": status}),
        )
        return {
            "statusCode": 200,
            "body": "Заявка пользователя успешно подтверждена",
        }

    return {
        "statusCode": 200,
        "headers": { "Content-Type": "text/html" },
        "body": html
    }
```

**index.html**
```html
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Заявка</title>
  <link rel="icon" href="https://img.icons8.com/3d-fluency/94/globe-africa.png">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body>
  <div class="container">
    <div class="row">
      <div class="col-sm-4 offset-sm-4">
        <h1>Заявка</h1>
        <form>
          <div class="mb-2">
            <label class="form-label" for="name">Ваше имя</label>
            <input type="text" class="form-control" name="name" id="name" required>
          </div>
          <div class="mb-2">
            <label class="form-label" for="email">Ваш email</label>
            <input type="email" class="form-control" name="email" id="email" required>
          </div>
          <div class="mb-2">
            <label class="form-label" for="text">Текст заявки</label>
            <textarea class="form-control" name="text" id="text"></textarea>
          </div>
          <div class="mb-2">
            <input class="btn btn-primary" type="submit" value="Отправить">
          </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>
```
