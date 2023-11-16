---
layout: default
title: Установка и настройка веб-серверов
---

# Установка и настройка веб-серверов

## Цель работы

Научиться устанавливать и настраивать веб-серверы Apache HTTPd и Nginx.

## План работы

- Установить веб-сервер Apache HTTPd
- Сконфигурировать два разных виртуальных хоста
- Установить модуль PHP
- Установить веб-сервер Nginx
- Сконфигурировать работу PHP через интерфейс FastCGI
- Сконфигурировать проксирование веб-сайтов

## Подготовительный этап

- Отредактируйте на локальном компьютере файл `C:\Windows\System32\Drivers\etc\hosts` (для редактирования нужны права администратора, пароль администратора: «имикиц428»). В этот файл нужно поместить строки вида:

  ```
  <IP-адрес сервера> test1.example.com
  <IP-адрес сервера> test2.example.com
  ```

- Добавьте аналогичные строки в файл `/etc/hosts` на сервере.

- Создать отчет о выполнении лабораторной работы в формате *.docx.

## Настройка виртуальных хостов в веб-сервере Apache HTTPd

1. Установите пакет веб-сервера Apache HTTPd: `apache2` и `libapache2-mod-php`.

2. Откройте в браузере адрес [http://test1.example.com](http://test1.example.com) и убедитесь что веб-сервер работает.

3. Создайте каталог www в домашней каталоге и поместите в него файл `index.php` следующего вида:

   ```
   <?php phpinfo(); ?>
   ```

   Создайте файл `/etc/apache2/sites-available/newsite.conf` (сделайте соответствующую замену):

   ```
   <VirtualHost *:80>
       ServerName test2
       DocumentRoot /home/<ИМЯ ПОЛЬЗОВАТЕЛЯ>/www
       <Directory /home/<ИМЯ ПОЛЬЗОВАТЕЛЯ>/www>
           Require all granted
       </Directory>
   </VirtualHost>
   ```
   Добавьте права на чтение и доступ к домашнему каталогу пользователя командой `chmod`.
   
   Включите новый виртуальный хост:

   ```bash
   sudo a2ensite newsite
   sudo systemctl reload apache2
   ```


5. Откройте в браузере хост-компьютера адреса [http://test1.example.com](http://test1.example.com) и [http://test2.example.com](http://test2.example.com) и убедитесь, что веб-сервер по-разному обслуживает два виртуальных хоста. **Сделайте скриншоты обоих сайтов.**

6. Добавьте в файл `/etc/apache2/sites-available/newsite.conf` внутрь тега `<Directory>` строку:

   ```
   Options Indexes
   ```

   Переименуйте файл `/home/yc-user/www/index.php` в `index.php.bak`, перезапустите Apache HTTPd и проверьте, что изменилось в работе веб-сервера. **Сделайте скриншот изменившегося сайта.** 
   
   Переименуйте файл `/home/user/www/index.php.bak` обратно в `index.php`.

7. Проверьте номера TCP-портов который использует сервер Apache HTTPd:

   ```bash
   sudo ss -ltnp
   ```

   Измените в файле `/etc/apache/ports.conf` номера основного порта с 80 на 8080. Внесите аналогичные изменения в файлах `default.conf` и `newsite.conf` в каталоге `/etc/apache2/sites-available`.

   Перезапустите Apache HTTPd и проверьте номера TCP-портов:

   ```bash
   sudo systemctl restart apache2
   sudo ss -ltnp
   ```

   **Сделайте скриншот TCP-портов до и после.**

## Установка веб-сервера Nginx

7. Установите необходимые пакеты: `nginx` и `php-fpm`.

   Откройте в браузере хост-компьютера адреса [http://test1.example.com](http://test1.example.com), [http://test1.example.com:8080](http://test1.example.com:8080) и [http://test2.example.com:8080](http://test2.example.com:8080), убедитесь, что веб-серверы Apache HTTPd и Nginx работают. **Сделайте скриншот с Nginx.**

8. Добавьте файл newsite в каталог `/etc/nginx/sites-available/`:

   ```
   server {
       listen 80;
       server_name test2.example.com;
       root /home/yc-user/www;
       location / {
           index index.php;
       }
       location /t1 {
           proxy_pass http://test1.example.com:8080/;
       }
       location /t2 {
           proxy_pass http://test2.example.com:8080/;
       }
       location ~ \.php$ {
           include snippets/fastcgi-php.conf;
           fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;  # Перепроверить правильность
       }
   }
   ```

   Создайте символическую ссылку на файл `/etc/nginx/sites-available/test2` в каталоге `/etc/nginx/sites-enabled` и перезапустите Nginx.

9. Откройте в браузере хост-компьютера страницы по адресам [http://test1.example.com](http://test1.example.com), [http://test2.example.com](http://test2.example.com), [http://test2.example.com/t1](http://test2.example.com/t1) и [http://test2.example.com/t2](http://test2.example.com/t2), убедитесь, что веб-серверы Apache HTTPd и Nginx работают вместе.

   Откройте в браузере отладчик (Ctrl+Shift+C или F12) на вкладке Network и найдите заголовок `Server` и убедитесь что указан веб-сервер Nginx. **Сделайте скриншоты всех 4 сайтов.**
