---
layout: default
title: Работа в оболочке bash
---
# Работа в оболочке bash

## Цель работы

Исследовать оболочку bash и научится в ней работать.

## Подготовка

Для начала работы вам нужно получить у преподавателя:
* адрес сервера
* приватный ключ

Подключитесь к серверу по SSH под именем `yc-user`.

Также вам нужно обновить список пакетов командой:

```
sudo apt update
```

Структура каталогов в Linux представляет собой иерархическое дерево (также как и в Windows). Однако в отличие от Windows файловым системам на различных разделах дисковых устройств не присваиваются буквы. Вместо этого работает следующий механизм:
* в момент загрузки Linux одна из доступных файловых систем становится основой дерева каталогов;
* остальные файловые системы подключаются к дереву в соответствии с системными настройками.

Команда `pwd` (сокращение от `path to working directory`) позволяет определить текущий рабочий каталог.

Команда `cd` (сокращение от `change directory`) позволяет сменить текущий рабочий каталог. Если дать её без параметров, то она оболочка перейдет в домашний каталог пользователя.

Команда `ls` (сокращение от `list`) отображает перечень файлов в каталоге. Ключ `-a` или (`--all`) отображает все файлы (включая те, названия которых начинаются с точки). Ключ 

Команда `tree` позволяет увидеть дерево каталогов.

Команда `less` позволяет просмотреть текстовый файл.

Команда `nano` позволяет редактировать текстовые файлы.

## Ход работы

1. Выполните команды `cd`, `pwd` и `ls` переходя из одного каталога в другой.

    Запустите работу `ls` с ключом `--help` и изучите список доступных ключей.

    Сделайте скриншот так,чтобы было видно содержание как минимум двух различных каталогов.

2. Установите `tree` с помощью команд:
    ```
    sudo apt install tree
    ```

3. С помощью команд `mkdir` и `touch` создайте структуру из нескольких вложенных каталогов и файлов. С помощью команды `tree` покажите получившуюся структуру. 
    Сделайте скриншот.

4. С помощью команд `cp`, `mv`, `rm` внесите изменения в созданную структуру каталогов и файлов. С помощью команды `tree` покажите изменившуюся структуру.
    Сделайте скриншот

5. Приложите к ответу новый текстовый документ и напишите в нем комбинации клавиш при просмотре текстовых файлов (`less`) для:

    * выхода из программы
    * поиска фрагмента
    * перехода к первой, последней и заданной по номеру строке файла

6. Приложите к ответу новый текстовый документ и напишите в нем комбинации клавиш при работе в текстовом редакторе `nano` для:

    * выхода из программы
    * сохранение изменений в файле
    * открытия файла
    * выделения, копирования, вырезания и вставки фрагмента текста
    * отмены последнего изменения
    * поиска фрагмента

7. С помощью команды `env` покажите переменные окружения. С помощью команды `export` создайте новую переменную окружения. С помощью команды `echo` покажите значение созданной переменной. 
    Сделайте скриншот с перечнем всех переменных и вашей переменной.

8. С помощью редактора `nano` добавьте в конец файла `~/.bashrc` команду создания новой переменной окружения и сохраните изменения.
    Сделайте скриншот отредактированного файла.

9. Перезапустите сеанс работы в оболочке bash и покажите значение созданной переменной.
    Сделайте скриншот со значением переменной после перезапуска сеанса работы.

## Отчётность

## Дополнительное задание

Установите с программой `mc`, предварительно установив её с помощью команды:
    ```
    sudo apt install mc
    ```