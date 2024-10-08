---
layout: default
title: Работа с пользователями
---
# Работа с пользователями

## Цель работы

Получить опыт администрирования пользователей в Linux.

## Подготовка

Создайте отчет в формате *.doc.

Перед началом работы вам нужно получить у преподавателя:

* адрес сервера
* имя пользователя
* закрытый ключ

Подключитесь к серверу по SSH.

## Ход работы

1. Создайте нового пользователя с помощью утилиты `adduser`.

    ```
    sudo adduser <логин>
    ```

2. Создайте нового пользователя с помощью утилиты `useradd`.

    ```
    sudo useradd <логин>
    sudo cp -r /etc/skel /home/<логин>
    sudo chown -R <логин>:<логин> /home/<логин>
    sudo chsh -s /bin/bash <логин>
    sudo usermod -p <пароль> <логин>
    ```

    Запишите в отчет назначение команд из пунктов 1 и 2.

    Изучите вывод команды `useradd --help` и ответьте в отчете на вопросы:

    * Какой ключ команды useradd позволяет создать домашний каталог пользователя?
    * Какой ключ команды useradd позволяет задать оболочку пользователя?
    * Какой ключ команды useradd позволяет задать пароль пользователя?

3. Создайте новый ключ асимметричного шифрования, разрешите новому пользователю вход на сервер с помощью этого ключа и проверьте это.

    На локальной машине (в `bash`/`zsh`/`fish` вместо `type` используйте `cat`, в `PowerShell` вместо `type` используйте `Get-Content`):
    ```
    ssh-keygen -t <тип ключа> -f <имя файла ключа> -С "<комментарий>"
    type <имя файла ключа>.pub
    ```

    На сервере:

    ```
    sudo -i -u <логин>
    mkdir ~/.ssh
    nano ~/.ssh/authorized_keys
    ```

    На локальном компьютере:
    ```
    ssh -i <имя файла ключа> <логин>@<сервер>
    ```

    Сделайте скриншот удачного входа в результате последней команды.

4. От имени пользователя `yc-user` добавьте вновь созданного пользователя в группу `sudo`.

    ```
    id <логин>
    sudo usermod -a -G sudo <логин> 
    id <логин>
    ```

    Снова войдите под новым пользователем и проверьте что команда `sudo` работает.

    Сделайте скриншот удачной результата работы команды `sudo`.

7. Проверте список подключенных пользователей

    ```
    users
    who
    w
    last
    ```

    Сделайте скриншот результатов работы этих команд. Какую информацию выдает команда `last`.

8. Убедитесь, что у вас открыто два окна терминала под разными пользователями и отправьте текстовое сообщение от одного пользователю другому:

    ```
    write
    wall
    ```

    Сделайте скриншоты сообщений и добавьте их в отчет.

9. Создайте новый файл и измените права доступа так чтобы получались следующие права:

    * `rwx------`
    * `rw-r--r--`
    * `rwxr-xr-x`
    * `--S--S--T`

    Выпишите использованные вами команды в отчет.

10. Измените владельца файла и каталога

    ```
    ls -l
    sudo chown <логин> <файл>
    ls -l
    sudo chgrp <группа> <файл>
    ls -l
    ```

    Сделайте скриншот, добавьте его в отчет и выделите изменившегося владельца и группу файла.

11. Создайте скрипт для автоматического создания пользователей и создайте их.

    ```
    cd ~
    nano script
    sudo bash script
    tail -n 15 /etc/passwd
    ```

    Код скрипта:

    ```
    for ((i = 1; i < 11; i++))
    do
    useradd -m -s /bin/bash -p 123 <логин>$i
    done
    ```

    Добавьте в отчет скриншот последних 15 строк файла `/etc/passwd`.
