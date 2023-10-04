---
layout: default
title: Работа с пользователями
---
# Работа с пользователями

## Цель работы

Научиться работать с пользователями.

## Подготовка

Придумайте логин и пароль для своего нового пользователя.

Перед началом работы вам нужно получить у преподавателя:

* адрес сервера
* имя пользователя
* закрытый ключ

Подключитесь к серверу по SSH.

## Ход работы

1. Создайте пользователя:

    ```
    sudo useradd <логин>
    ```

2. Создайте домашний каталог пользователя:

    ```
    sudo cp /etc/skel /home/<логин>
    sudo chown -R <логин>:<логин> /home/<логин>
    ```

3. Смените пароль пользователю:

    ```
    sudo passwd <логин>
    ```

4. Смените оболочку пользователя:

    ```
    sudo usermod -s /bin/bash <login>
    ```
    
    (либо можно `sudo chsh -s /bin/bash <login>`)

5. Определите текущие группы пользователя:

    ```
    id <login>
    groups <login>
    ```

6. Добавьте пользователя в группу `sudo`

    ```
    sudo usermod -a -G <группы> <login> 
    ```

7. Войти своим пользователем

ssh <логин>@<сервер>

Проверить работу sudo

sudo -i

Проверить список подключенных пользователей

w
last
who
users

Отправить сообщение другому пользователю:

write
wall

Изменить права доступа на файл и каталог

touch test_file
ls -l test_file
chmod ??? test_file
rwx------ 700
rw-r--r-- 644
rwxr-xr-x 755
--S--S--T 7000

Изменить владельца файла и каталога

cd /tmp/task
sudo chown <логин> <файл>
sudo chgrp <группа> <файл>

Написать скрипт для автоматического создания 10 пользователей
cd ~
nano script

for ((i = 1; i < 11; i++))
do
  useradd -m -p 123 <логин>$i
done

sudo bash script
less /etc/passwd