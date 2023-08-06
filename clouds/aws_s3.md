---
layout: default
title: Оглавление
---

# AWS S3 Теория

## Расчет и планирование стоимости услуг AWS

[Калькулятор стоимости услуг](https://calculator.aws/#/) — позволяет оценить стоимость услуг AWS

[AWS Saving plans](https://aws.amazon.com/ru/savingsplans/) — скидки при использовании некоторых сервисов AWS

* Compute (66% Amazon EC2, AWS Lambda и AWS Fargate)
* EC2 Instance (72%)
* Amazon SageMaker (64%)

https://aws.amazon.com/ru/savingsplans/compute-pricing/

[AWS Cost Explorer](https://console.aws.amazon.com/cost-management/home) — сервис который позволяет детализировать счета от AWS

Budgets — сервис оповещений о расходовании бюджета

Методы экономии:

* Reserved Instance
* Saving Plans
* Spot Instance

## AWS S3 (Simple Storage Service)

S3 классы хранения https://aws.amazon.com/ru/s3/features/

* intelligent
* standard
* infrequent
* glacier

Возможности:

* Надежность (одиннадцать девяток)
* Размеры хранимых данных (макс. размер файла 5Tb)
* Сферы применения:

  - хранение данных для анализа
  - хранение резервных копий
  - публикация веб-сайтов

* Интеграция с другими сервисами

  - данные AWS Athena
  - шаблоны AWS CloudFormation
  - отчеты AWS CloudWatch
  - резервные копии RDS

* Веб-сайт
* Настройка доступа с помощью ACL
* Настройка доступа с помощью политик (policy)
* Версионирование
* Управление жизненным циклом

Другие сервисы для хранения данных:

* Хранилища:

  - EBS (Elastic Block Storage) — хранение образов дисков виртуальных машин
  - EFS (Elastic File System) — сетевая файловая система, которую можно подключать к нескольких виртуальным машинам

* СУБД:

  - RDS (MySQL, PostgreSQL, MS SQL Server и т.п.)
  - Aurora (реляционная)
  - Neptune (графовая)
  - DynamoDB (NoSQL)
  - DocumentDB (MongoDB, документная)
  - Redshift (NoSQL, wide-column, для больших данных)
