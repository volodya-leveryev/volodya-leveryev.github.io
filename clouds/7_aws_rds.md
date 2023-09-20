---
layout: default
title: Оглавление
---

# Облачные СУБД

Варианты развертывания СУБД:

* Установить СУБД на оборудование on-Premise
* Установить СУБД в контейнер на оборудование on-Premise
* Установить СУБД в инстансе
* Установить СУБД в контейнере на инстансе
* Использовать СУБД в контейнере в облачном сервисе
* **Использовать облачный сервис**

Преимущества облачного сервиса:

* автоматическое масштабирование
* легкость резервного копирования
* производительность при масштабировании серверов приложения
* не нужно поддерживать ОС и ПО СУБД

Облачные СУБД:

* Реляционные

  - Amazon Aurora Serverless
  - Amazon Aurora (умеет работать в режиме MySQL и PostgreSQL)
  - MySQL
  - MariaDB
  - Oracle
  - Microsoft SQL Server
  - PostgreSQL

* Нереляционные (NoSQL)

  - document (AWS DocumentDB (MongoDB))
  - key-value (Amazon MemoryDB (Redis), Amazon DynamoDB)
  - wide-column store (Amazon Keyspaces (Cassandra), Amazon Redshift)
  - graph (Amazon Neptune)
  - time (Amazon Timestream)

Практическая часть

1. Аутентифицироваться в https://console.aws.amazon.com/
2. Открыть сервис RDS

  * Создать базу данных типа PostgreSQL
  * Имя инстанса: <группа>-<фамилия>
  * Имя пользователя: strapi
  * DB instance class: db.t3.micro
  * Storage type: General Purpose
  * Multi-AZ: no
  * Security Group: existing, default
  * Отключить Monitoring

3. Создать

  * виртуальную машину в EC2 типа t3.medium, Ubuntu 22.04
  * Установить Node.js LTS 18 ([инструкция](https://github.com/nodesource/distributions#using-ubuntu-2))
```
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
```
  * Создать проект, изменить порт (на 8080), подключение к СУБД RDS и запустить
```
npx create-strapi-app@latest --no-run books
cd books
nano .env
npm run build
npm run develop
```
  * создать БД:
```bash
sudo apt-get install -y postgresql-client-14
psql -h <СУБД> -U strapi postgres
```
```
CREATE DATABASE strapi;
\q
```

  * проверить работу в браузере

4. Подключиться к `strapi` и настроить 2 таблицы с произвольными полями
