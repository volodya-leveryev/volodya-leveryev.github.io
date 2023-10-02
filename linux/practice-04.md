---
layout: default
title: Работа с пользователями
---
# Работа с пользователями

## Цель работы

Научиться работать с пользователями.

## Подготовка

Для начала работы вам нужно получить у преподавателя:
* адрес сервера
* приватный ключ

Подключитесь к серверу по SSH под именем `yc-user`.


## Ход работы

1. Создать пользователя
sudo useradd -m <логин>
sudo mkdir /home/kai
sudo chown -R kai:kai /home/kai

2. Сменить пароль пользователя
sudo passwd <логин>
Сменить оболочку пользователя
sudo usermod -s /usr/bin/fish <login>
sudo chsh -s /usr/bin/fish <login>
Показать группы пользователя
id <login>
groups <login>
Добавить пользователя в группу sudo
sudo usermod -a -G <группы> <login> 
Войти своим пользователем
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
