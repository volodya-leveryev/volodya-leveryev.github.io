---
layout: default
title: Оглавление
---

# AWS RDS

## Цель работы

Цель работы: познакомиться с сервисом Amazon RDS и понятием headless CMS.

## Теоретическая часть

Варианты развертывания СУБД:

* Установить СУБД на локальном сервере on-Premise
* Установить СУБД в контейнер на локальном сервере on-Premise
* Установить СУБД в сервере в облаке
* Установить СУБД в контейнере на сервере в облаке
* Использовать СУБД в контейнере в облачном сервисе
* **Использовать облачный сервис**

Преимущества облачного сервиса:

* простое масштабирование
* простое резервное копирование
* производительность при масштабировании серверов приложения
* не нужно поддерживать ОС и ПО СУБД

Недостатки облачного сервиса:

* высокая стоимость
* нет контроля над средой хранения данных
* возможное противоречие требованиям законодательства или комплаенса

Облачные СУБД:

* Реляционные

  - [Amazon Aurora](https://aws.amazon.com/rds/aurora/)
  - [Amazon Redshift](https://aws.amazon.com/redshift/)
  - **[Amazon RDS](https://aws.amazon.com/rds/)**, которая 
    - Amazon Aurora (в режиме совместимости с MySQL или PostgreSQL)
    - MySQL
    - MariaDB
    - Oracle Database
    - Microsoft SQL Server
    - PostgreSQL

* Нереляционные (NoSQL)

  - документные (AWS DocumentDB (MongoDB))
  - хранилища key-value (Amazon MemoryDB (Redis), Amazon DynamoDB)
  - хранилища wide-column (Amazon Keyspaces (Cassandra))
  - графовые (Amazon Neptune)
  - для временных рядов (Amazon Timestream)

## Практическая часть

Перед началом работы войдите в [веб-консоль](https://console.aws.amazon.com/)

1. Откройте сервис RDS (в регионе Hong Kong, Seoul или Tokyo), нажмите **Create database**

   * Engine type: MySQL
   * Template: Free tier
   * DB instance identifier: <группа>-<фамилия>
   * Master username: strapi_user
   * Master password — придумайте новый пароль

   Оставьте остальные параметры по умолчанию и нажмите **Create database**.

2. Откройте в том же регионе сервис EC2 и нажмите **Launch instance**

   * Name: <группа>-<фамилия>
   * Amazon Machine Image: Ubuntu Server 24.04 LTS
   * Instance type t3.medium
   * Key pair: Выберите свой ключ (или создайте новый)
   * Firewall (security group): Select existing security group (default)

   Оставьте остальные параметры по умолчанию и нажмите **Launch instance**.

3. Откройте на локальном компьютере терминал и подключитесь к серверу по SSH.

   ```
   ssh -i <файл с ключом> ubuntu@<адрес сервера>
   ```

4. Установите на сервере пакет `mysql-client`

   ```
   sudo apt update && sudo apt install -y mysql-client
   ```

5. Откройте созданную в сервисе RDS базу данных и сохраните endpoint для дальнейшего использования.

6. Подключитесь к СУБД MySQL

   ```bash
   mysql -u strapi_user -p -h <RDS-endpoint>
   ```

   с помощью команды `SHOW DATABASES;` перечислите имеющиеся базы данных.

7. Создайте базу данных для приложения:

   ```
   CREATE DATABASE strapi_db;
   ```

   с помощью команды `SHOW DATABASES;` проверьте что база данных была успешно создана.

   с помощью команды `exit` закройте клиент MySQL.

8. Установите Node.js LTS ([инструкция](https://github.com/nodesource/distributions?tab=readme-ov-file#using-ubuntu-nodejs-22))

   ```
   sudo apt-get install -y curl
   curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
   sudo -E bash nodesource_setup.sh
   sudo apt-get install -y nodejs
   ```

   проверьте что Node.js установился: `node -v`
   
   проверьте что NPM установился: `npm -v`

9. Создайте проект `books` на базе CMS Strapi (вместо sqlite выберите mysql, ведите параметры созданной БД, остальные параметры оставьте по умолчанию):

   ```
   npx create-strapi-app@latest --skip-cloud --no-example --no-git-init books
   ```

   войдите в каталог приложения

   ```
   cd books
   ```

   измените в конфигурационном файле порт на 8080
   ```
   nano .env
   ```

   скомпилируйте и запустите приложение
   ```
   npm run build
   npm run develop
   ```

10. Откройте админку в браузере CMS Strapi, создайте нового администратора.

11. Перейдите в **Content-Types Builder** и создайте новую коллекцию `Books` с полями:

    * author (Short text)
    * title (Short text)

12. Перейдите в **Content Manager**, откройте созданную коллекцию `Books` и создайте несколько записей.

13. Перейдите в **Settings**, **API Tokens**, откройте токен с полными правами, заново сгенерируйте и скопируйте его.

14. Откройте клиент для REST API [httpie](https://httpie.io/), перейдите в приложение (Go to App), на вкладке **Auth** выберите вариант аутентификации **Token Bearer** и выполните запрос:

    * GET http://<IP-адрес сервера>:8080/api/books

15. Создайте новый запрос? измените метод с GET на POST, введите прежний адрес, введите параметры аутентификации, на вкладке **Body** выберите **Text**, **JSON** и введите данные по следующему образцу:
    ```json
    {
      "data": {
        "author": "Введите имя автора книги",
        "title": "Введите название книги"
      }
    }
    ```
    выполните запрос по предыдущему адресу, в ответе сервера должны присутствовать новые поля (id, documentId, createdAt, updatedAt, publishedAt) которые свидетельствуют о записи в БД.

16. Вернитесь в терминал с запущенным приложением и остановите его нажав `Ctrl+C`. Подключитесь к СУБД MySQL
    ```bash
    mysql -u strapi_user -p -h <RDS-endpoint>
    ```

    выполните запросы:
    ```
    USE strapi_db;
    SHOW TABLES;
    SELECT * FROM books;
    ```

    Проверьте что введенные в приложение данные сохранены в БД.
