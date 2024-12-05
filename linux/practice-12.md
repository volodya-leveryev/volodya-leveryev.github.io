---
layout: default
title: Работа со службами
---

# Работа со службами

## Цель работы

Научиться управлять службами с помощью `systemctl`, анализировать системные журналы через `journalctl` и работать с планировщиком заданий `cron`.

## План работы

1. Работа с `systemctl`.
2. Работа с `journalctl`.
3. Работа со службой `cron`.

## Подготовительный этап

* Ознакомьтесь со [статьей о SystemD](https://habr.com/ru/companies/timeweb/articles/824146/).
* Подключитесь к серверу по протоколу SSH.
* Создайте отчет о выполнении лабораторной работы в формате *.docx.

## Работа со службами

1.  Выполните команду для проверки статуса службы cron:

    ```
    sudo systemctl status cron.service
    ```
    Добавьте скриншот в отчёт. Выделите на нём имя файла с описание службы.

2.  Выполните команду для остановки службы cron:

    ```
    sudo systemctl stop cron.service
    sudo systemctl status cron.service
    ```
    Добавьте скриншот в отчёт.

3.  Выполните команду для отключения службы cron:

    ```
    sudo systemctl disable cron.service
    sudo systemctl status cron.service
    ```
    Добавьте скриншот в отчёт.

4.  Выполните команду для маскировки службы cron:

    ```
    sudo systemctl mask cron.service
    sudo systemctl status cron.service
    ```
    Добавьте скриншот в отчёт.

5.  Выполните команду для отмены изменений и запуска службы cron:

    ```
    sudo systemctl unmask cron.service
    sudo systemctl enable cron.service
    sudo systemctl start cron.service
    sudo systemctl status cron.service
    ```
    Добавьте скриншот в отчёт.

6.  Создайте в домашнем каталоге пользователя каталог `www` и поместите туда файл `index.html` с произвольным содержанием. Создайте файл `/etc/systemd/system/app.service` с описанием службы:

    ```
    [Unit]
    Description=SimpleService

    [Service]
    ExecStart=/usr/bin/python3 -m http.server -d /home/yc-user/www 80

    [Install]
    WantedBy=default.target
    ```

7.  Прочитайте сведения о новой службе, запустите и проверьте её статус:

    ```
    sudo systemctl daemon-reload
    sudo systemctl start app.service
    sudo systemctl status app.service
    ```

    Добавьте скриншот в отчёт.

    Откройте в браузере полученный сайт (http://адрес) и добавьте скриншот в отчёт.


8.  Включите автоматический перезапуск службы, перезагрузите сервер, подключитесь к нему снова и убедитесь что служба работает.

    ```
    sudo systemctl enable app.service
    sudo systemctl reboot
    sudo systemctl status app.service
    ```

    Добавьте скриншот в отчёт.

9.  Добавьте в отчет описание следующих команд `systemctl`:

    - `list-dependencies`
    - `get-default`
    - `list-units`
    - `list-unit-files`
    - `show`

## Работа с системным журналом

10. Проверьте журнал сообщений от устройств:

    ```sudo dmesg```

    Добавьте скриншот в отчёт. Как изменяется работа команды с ключом `-T`.

11. Проверьте журнал системных сообщений:

    ```sudo journalctl```

    Добавьте скриншот в отчёт.

12. Посмотрите 10 сообщений в журнале системных сообщений:

    ```sudo journalctl -n 10```

    Добавьте скриншот в отчёт.

13. Проверьте журнал системных сообщений с фильтром по службе:
    
    ```sudo journalctl -u app.service```

    Добавьте скриншот в отчёт.

14. Добавьте в отчет описание следующих ключей `journalctl`:

    - `sudo journalctl --list-boots`
    - `sudo journalctl -b -1`
    - `sudo journalctl -e`
    - `sudo journalctl -f`

## Работа с cron

15. Настройте текстовый редактор и отредактируйте пользовательский файл настроек службы `cron`:

    ```
    export EDITOR="/usr/bin/nano"
    crontab -e
    ```

    и добавьте в него строку:

    ```
    * * * * * date >> /tmp/current_date.txt
    ```

    Откройте полученный временный файл, дождитесь появления в нем нескольких строк и сделайте скриншот.

    ```
    tail -f /tmp/current_date.txt
    ```

16. Изучите формат файла crontab в статье руководства `man 5 crontab`. Добавьте в отчет назначение полей.
 