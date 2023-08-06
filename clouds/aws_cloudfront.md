---
layout: default
title: Оглавление
---

# AWS Route53, CloudFront

## Подготовительные шаги

Зайти в AWS Console и войти с логином и паролем предоставленным преподавателем.

Установить AWS CLI
1. https://aws.amazon.com/ru/cli/
2. выполнить команду `aws configure` и ввести ключ предоставленный преподвателем.
5. выбрать регион по умолчанию
6. Output format: table

## Теория

AWS Route53 — DNS

AWS CloudFront — CDN (Content Delivery Network). Этот сервис не привязан к конкретному региону и всегда базируется в первом по счету регионе: us-east-1

Хороший CDN имеет много точек присутствия (Point of Presence, POP)

Хороший CDN имеет хорошие магистральные каналы связи

## Практика

Создать статический веб-сайт разместим его в удаленном регионе

1. Создать index.html
```
<html>
<body>
<video width="1280" height="720" controls>
    <source src="trailer.mp4" type="video/mp4">
    Your browser does not support the video tag.
</video>
</body>
</html>
```
2. Создать бакеты <группа>-<фамилия>

* aws s3 mb s3://<bucket>/ --region sa-east-1
* Включить статический веб-сайт
* aws s3 website s3://<bucket>/ --index index.html
* Разместить файлы
* aws s3 cp index.html s3://<bucket>/
* aws s3 cp trailer.mp4 s3://<bucket>/
* Войти в бакет через веб-консоль
* На вкладке Permissions
* В разделе Block public access нажать Edit
* Снять галочку "Block all public access"
* Войти в бакет через веб-консоль
* На вкладке Permissions
* В разделе Object Ownership нажать Edit
* Разрешить использование ACL
* Включить публичный доступ
* Войти в бакет через веб-консоль
* Выделить все файлы
* Actions, Make public using ACL
* Make public
* Включим доступ через CloudFront
* Войти через веб-консоль в Cloudfront
* Создать Distribution
* Выбрать Origin domain
* В разделе Viewer сменили на "Redirect…"
* Выбрать SSL-сертификат *.kit-imi.info
* Добавить дополнительное имя в зоне kit-imi.info
* Default root object - index.html

Будем наблюдать как контент будет закеширован в ближайшем от нас POP

* Установить https://httpie.io/download
* http --verbose --download <URL файла с S3>
* http --verbose --download <URL файла с CloudFront>

Задаем доменное имя с доступом по https

Войти через веб-консоль в Certificate Manager

В регионе N.Virginia запрашиваем сертификат на свое доменное имя: <группа>-<фамилия>.kit-imi.info

Войти через веб-консоль в Cloudfront

Добавить в свой Distribution дополнительное доменное имя с созданным сертификатом и указать Default root object - index.html

В Route53 создать доменное имя типа CNAME которое указывает на доменное имя вашего Cloudfront Distribution. Оно должно совпадать с дополнительным доменным именем указанным в п.6 при создании Cloudfront Distribution.

Проверить работу через доменное имя.
