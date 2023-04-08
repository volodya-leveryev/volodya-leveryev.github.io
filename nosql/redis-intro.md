---
layout: default
title: Установка Redis
---

# Redis

## Установка

Для установки на Linux используйте стандартный пакетный менеджер вашего дистрибутива.

Для Windows используйте неофициальные сборки.

Альтернативный вариант — использование Redis в контейнере Docker.

## Простые команды

### Настройка службы.

### Настройка брандмауэра.

### Использование интерфейса командной строки.

`PING` — проверить наличие связи с сервером.

`SET key value` — установить значение для ключа.

`GET key` — получить значение по ключу.

### Использование программного интерфейса

### Конфигурационный файл

### Команды конфигурирования

## Строки

`GETRANGE key start end` — получить подстроку из строки, которая хранится по ключу.

`GETSET key value` — установить новое значение по ключу и получить старое значение.

`GETBIT key offset` — получить битовое значение по смещению из строки по ключу.

Returns the bit value at the offset in the string value stored at the key.

`MGET key1 [key2..]` — получить значения всех заданных ключей.

`SETBIT key offset value`

Sets or clears the bit at the offset in the string value stored at the key

`SETEX key seconds value`

Sets the value with the expiry of a key

`SETNX key value`

Sets the value of a key, only if the key does not exist

`SETRANGE key offset value`

Overwrites the part of a string at the key starting at the specified offset

`STRLEN key`

Gets the length of the value stored in a key

`MSET key value [key value ...]`

Sets multiple keys to multiple values

`MSETNX key value [key value ...]`

Sets multiple keys to multiple values, only if none of the keys exist

`PSETEX key milliseconds value`

Sets the value and expiration in milliseconds of a key

`INCR key`

Increments the integer value of a key by one

`INCRBY key increment`

Increments the integer value of a key by the given amount

`INCRBYFLOAT key increment`

Increments the float value of a key by the given amount

`DECR key`

Decrements the integer value of a key by one

`DECRBY key decrement`

Decrements the integer value of a key by the given number

`APPEND key value`

Appends a value to a key

Работа со строковыми данными в Redis (команды SET и GET)

Работа со ассоциативными словарями в Redis:

* HDEL
* HEXISTS
* HGET
* HGETALL
* HINCRBY
* HINCRBYFLOAT
* HKEYS
* HLEN
* HMGET
* HMSET
* HSCAN
* HSET
* HSETNX
* HSTRLEN
* HVALS

Работа с множествами в Redis:

* SADD
* SCARD
* SDIFF
* SDIFFSTORE
* SINTER
* SINTERSTORE
* SISMEMBER
* SMEMBERS
* SMOVE
* SPOP
* SRANDMEMBER
* SREM
* SSCAN
* SUNION
* SUNIONSTORE

(команды HSET и HGET)

## Хеши

## Списки

## Множества

## Сортированные множества

## Очереди

Чат с несколькими каналами

Получение сообщений:

* проверка методом get_message()
* ожидание сообщений методом listen()
* подключение обработчика с помощью метода subscribe()

## Резервное копирование

## Масштабирование

