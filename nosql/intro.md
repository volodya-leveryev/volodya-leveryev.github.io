---
layout: default
title: Введение
---

# Что такое базы данных NoSQL?

СУБД — Система управления базой данных
DBMS — Database management system

Реляционные СУБД — хранят данные в виде связанных таблиц:

* IBM DB2
* Oracle Database
* MS SQL Server
* PostgreSQL
* Oracle MySQL (MariaDB)
* SQLite (только БД без СУБД)
* MS Acces
* и т.д.

NoSQL - not only SQL - ряд подходов к созданию СУБД выходящих за рамки традиционной модели реляционных СУБД.

# Принцип ACID

Традиционные RDBMS - принцип ACID:

* **A**tomicity — атомарность транзакций. Некоторые операции должны быть объединены в неделимую транзакцию.
* **C**onsistency — согласованность. Иначе могут возникнуть битые ссылки.
* **I**solation — изолированность параллельной обработки транзакций.
* **D**urability — надежность записи данных на носитель внешней памяти.

# Принцип BASE

Что делать если реляционная модель плохо подходит?

* структура данных нерегулярна
* нужна высокая масштабируемость
* нужна высокая доступность
* допустима немгновенная согласованность данных (Eventually Consistency)
* не требуется атомарность операций

СУБД NoSQL реализуют принцип BASE:

* **B**asically **A**vailable, базовая доступность (сбой в некоторых узлах приводит к отказу в обслуживании только для незначительной части сессий при сохранении доступности в большинстве случаев)
* **S**oft-state, неустойчивое состояние (возможность жертвовать долговременным хранением состояния сессий (таких как промежуточные результаты выборок, информация о навигации, контексте), при этом концентрируясь на фиксации обновлений только критичных операций)
* **E**ventually consistent, согласованность в конечном счёте (возможность противоречивости данных в некоторых случаях, но при обеспечении согласования в практически обозримое время)

# Преимущества и недостатки NoSQL по сравнению с RDBMS

Зачем нужны базы данных NoSQL?
Что делать если реляционная модель плохо подходит?
 - структура данных нерегулярна
 - нужна высокая масштабируемость
 - нужна высокая доступность
 - не требуется согласованность данных
 - не требуется атомарность операций

# Теорема CAP
 - **C**onsistency - согласованность данных
 - **A**vailability - доступность данных (масштабируемость)
 - **P**artitioning tolerance - надежность хранения

# Классификация СУБД NoSQL по модели хранения данных

Какие бывают базы данных NoSQL?
 - Key-value store (Redis, Memcached, Amazon DynamoDB, Azure CosmosDB)
 - Document store (MongoDB, Amazon DynamoDB, Azure CosmosDB, Couchbase, Firebase, MarkLogic)
 - Wide-column store (Cassanda, HBase, Azure CosmosDB)
 - Graph DBMS (Neo4j, Azure CosmosDB)
 - Time Series DBMS
 - Search engines
 - RDF store
 - Event store

[Сравнение популярности различных СУБД](https://db-engines.com/en/ranking)

# Key-value store Redis

Границы применимости key-value store

Как установить Redis?
 - Linux / Mac OS
 - Docker
 - [Unofficial Windows binaries](https://github.com/MicrosoftArchive/redis/releases)

Как подключиться к Redis?
Как записать данные в Redis?
Как запрашивать данные из Redis?

[Официальный сайт Redis](https://github.com/MicrosoftArchive/redis/releases)

Подключение к Redis из Python. Предварительно необходимо установить пакет redis (`pip install redis`).

```
import redis
r = redis.Redis()
r.set("Croatia", "Zagreb")
r.get("Croatia")
r.keys("*")
dir(r)
r.config_get("*")
```
