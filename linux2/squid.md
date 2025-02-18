# Прокси-серверы

## Теоретическая часть
Прямые прокси-серверы - для выхода в Интернет из локальной сети.
- HTTP/HTTPS
  - Squid
- SOCKS4/SOCKS5
  - Dante
  - SSH

Зачем нужны прямые прокси-серверы?
- контроль доступа к Интернету
- ускорить доступ к Интернету
- журналировать доступ к Интернету
- организовать доступ к Интернету по логину/паролю
- выход в Интернет по расписанию

SOCKS - протокол для перенаправления TCP-соединений и UDP-датаграм.
SOCKS-серверы также используются как прямые прокси-серверы.

Прозрачные прокси-серверы - прокси-сервер совмещенный с шлюзом NAT.

Обратные прокси-серверы - для подключения к локальным веб-серверам из Интернета.
- Nginx
- HAProxy
- Traefik

## Практическая часть
1. Установить Firefox на локальный компьютер
2. Установить Squid на сервер
   ```
   sudo apt install squid
   ```
3. Создать свой конфигурационный файл
   ```
   cd /etc/squid/conf.d
   sudo nano custom.conf
   ```
   с белым список адресов:
   ```
   acl whitelist dstdomain .wikipedia.org .wikimedia.org
   http_access allow whitelist
   ```
4. Исправить номер TCP-порта который прослушивает Squid с 3128 на 8080:
   ```
   sudo nano /etc/squid/squid.conf
   ```
5. Перезапустить Squid:
   ```
   sudo systemctl restart squid.service
   ```
6. Прописать прокси-сервер в Firefox и проверить его работу

LDAP - протокол для аутентификации и авторизации на сервере каталога (например Active Directory)
RADIUS - сервер для аутентификации и авторизации пользователей в сети
PAM - pluggable authentication modules

7. Создать файл с паролями пользователей

sudo apt install apache2-utils
sudo htpasswd -c /etc/squid/squid-passwd <username1>
sudo htpasswd /etc/squid/squid-passwd <username2>

8. Настроить доступ с аутентификацией

sudo nano /etc/squid/conf.d/custom.conf

auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/squid-passwd
acl authorized_users proxy_auth REQUIRED
http_access allow authorized_users

sudo systemctl reload squid

