---
layout: default
title: Оглавление
---

# Microsoft Azure

## План

- Создать базу данных в сервисе Cosmos DB
- Создать Telegram-бота в Azure Functions
- Развернуть бэкенд на виртуальной машине
- Фронтенд в объектном хранилище 

## Предварительный этап

- Создать Microsoft-аккаунт
- Сообщить свой Microsoft-аккаунт преподавателю
- Войти в консоль управления https://portal.azure.com с помощью своего Microsoft-аккаунта
- Открыть созданную преподавателем для вас группу ресурсов

## Cosmos DB

Используйте скрипт `load_data.py` для загрузки данных из набора данных в Cosmos DB.

## Azure Functions

## Virtual Machines

1. Создайте 

## Blob Storage

1. Создайте `Storage account`:

  - Region: `Korea Central`
  - Redundancy: `Locally-redundant storage (LRS)`
  - остальные параметры оставьте по-умолчанию

2. Создайте контейнер

  - войдите в созданный `Storage account`
  - откройте в раздел `Containers`
  - создайте контейнер с именем `$web` с уровнем доступа `Blob (anonymous read access for blobs only)`

3. Загрузите файл `index.html` в контейнер

4. Включите статический веб-сайт

  - в свойствах `Storage account` откройте раздел `Static website`
  - включите статический веб-сайт
  - укажите страницу по-умолчанию
  - скопируйте URL веб-сайта

5. Проверьте работу веб-сайта в браузере

## Ссылки

- [Документация по Cosmos DB](https://learn.microsoft.com/en-us/azure/cosmos-db/introduction)
- [Документация по Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/functions-overview)
- [Документация по Azure Blob Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)
- [Настройка статического сайта](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website)
- [Набор данных](https://www.kaggle.com/datasets/harshitshankhdhar/imdb-dataset-of-top-1000-movies-and-tv-shows)

https://learn.microsoft.com/en-us/azure/cosmos-db/nosql/quickstart-python
