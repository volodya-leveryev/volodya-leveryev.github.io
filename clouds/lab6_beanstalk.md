# Elastic Beanstalk

## Теория

Elastic Beanstalk - это сервис, который позволяет быстро подготовить
инфраструктуру для веб-приложения. Сервис позволяет быстро вернуться к
предыдущей версии, в случае если возникли проблемы с новой версией.

Сервис поддерживает подход Green/Blue Deployment.

Поддерживаются: Java, .NET, PHP, Node.js, Python, Ruby, Go и Docker.

Elastic Beanstalk использует AWS Cloudformation для быстрого развертывания
инфраструктуры.

Развертывание новых версий веб-приложения в стиле green/blue deployment:
1. Рабочая инфраструктура с текущей версией веб-приложения обозначается как
   Green
2. Создается новая копия инфраструктуры с новой версией веб-приложения, она
   обозначается как Blue
3. С помощью DNS-резолвинга (или Load Balancer) происходит переключение
   клиентов с Green на Blue

Пользователи не должны почувствовать изменений.

При этом обе версии кода веб-приложения работают:
* с одной и той же СУБД
* с разными копиями СУБД, которые связаны скриптами миграции

Ссылки:
[https://aws.amazon.com/ru/elasticbeanstalk/](https://aws.amazon.com/ru/elasticbeanstalk/)

## Практика

Код приложения:

**index.php**:
```php
<?php phpinfo() ?>
```

1. Войти в веб-консоль управления.
2. Открыть панель Elastic Beanstalk в регионе Tokyo (519), Seoul (424).
3. Создать на локальном компьютере index.php и сжать его в ZIP-архив.
4. Создать новое приложение\
   *Шаг 1*\
   Web server environment\
   Application name: <группа>-<фамилия>\
   Environment: <группа>-<фамилия>-prod\
   Managed Platform: PHP\
   Version label: v1\
   Upload your code\
   Local file: ZIP-архив\
   Single Instance (free tier eligible)

   *Шаг 2*\
   Service role: Use an existing service role, выберите любую существующую роль\
   EC2 key pair: Не выбирать\
   EC2 instance profile: выберите любую существующую роль

   *Шаг 3*\
   Выбрать VPC\
   Public IP address: True\
   Выберите все подсети\
   Database subnets: оставить не заполненным\
   Enable database: False

   *Шаг 4*\
   EC2 security groups: default

   *Шаг 5*\
   Health reporting, System: Basic\
   Managed updates: False

5. После развертывания проверить работу в браузере.
6. Изменить код приложения и обновить ZIP-архив.
7. Клонировать новое окружение (environment) <группа>-<фамилия>-stage.
8. Переключить окружение.
9. Проверить работу новой версии приложения в браузере.
