---
layout: default
title: Работа с Docker
---

# Работа с Docker

## Цель работы

Научиться основам работы с Docker.

## План работы

- Установить Docker
- Запустить готовый образ с Nginx
- Создать и запустить свой образ

## Подготовительный этап

- Подключитесь к серверу по протоколу SSH.
- Создайте отчет о выполнении лабораторной работы в формате *.docx.

## Установка Docker

1. Ознакомьтесь с инструкцией: https://docs.docker.com/engine/install/ubuntu/.

2. Выполните основные шаги по установке Docker Engine:

   ```
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

   echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

   sudo apt-get update
   
   sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
   ```

3. Ознакомьтесь с содержанием файла `/etc/apt/sources.list.d/docker.list`.

   **Добавьте содержание файла к отчету.**

4. Добавьте вашего пользователя к группе `docker`:

   ```
   sudo usermod -a -G docker $(whoami)
   ```

5. Переподключитесь к серверу и проверьте работу Docker Engine:

   ```
   docker run hello-world
   ```

   **Добавьте скриншот к отчету.**

## Запуск готового образа с Nginx

6. Выполните команду `docker run --help` и **законспектируйте в отчет**:

   * назначение команды `run`
   * значение следующих ключей:
     - `--detach`
     - `--env` и `--env-file`
     - `--name`
     - `--publish`
     - `--rm`
     - `--volume`

7. Выполните команду `docker images --help` и **законспектируйте в отчет** назначение команды `images`

8. Выполните команду `docker ps --help` и **законспектируйте в отчет**:

   * назначение команды `ps`
   * значение ключа: `--all`

9. Выполните команду `docker stop --help` и **законспектируйте в отчет** назначение команды `stop`

10. Запустите образ с веб-сервером `Nginx`:

    ```
    docker images

    docker run -d -p 80:80 --name test-nginx nginx

    docker images
    ```

    **Добавьте к отчету скриншот работы команд в консоли.**

11. Откройте в браузере адрес сервера по протоколу `http`.

    **Добавьте к отчету скриншот браузера**

12. Остановите контейнер:

    ```
    docker ps -a

    docker stop test-nginx

    docker ps -a
    ```

    **Добавьте к отчету скриншот работы команд в консоли.**

## Создание и запуск своего образа

13. Выполните команду `docker build --help` и **законспектируйте в отчет**:

    * назначение команды `build`
    * значение ключа `--tag`

14. Откройте [документацию по Dockerfile](https://docs.docker.com/engine/reference/builder/) и **законспектируйте в отчет** назначение следующих команд:

    * `ADD`
    * `CMD`
    * `COPY`
    * `ENV`
    * `EXPOSE`
    * `FROM`
    * `RUN`
    * `WORKDIR`

15. Создайте в домашнем каталоге пользователя подкаталог `app` и войдите в него. Создайте в нем следующие файлы:

    * `app.py`:

      ```
      from flask import Flask
      app = Flask(__name__)
      @app.route("/")
      def hello_world():
          return "<p>Hello, World!</p>"
      ```

    * `Dockerfile`:
      ```
      FROM python:slim-3.11
      COPY . .
      RUN pip install flask
      CMD flask run
      ```

16. Создайте образ и запустите его:

    ```
    docker build -t custom-image .

    docker run -d -p 80:80 custom-image
    ```

    **Добавьте к отчету скриншот работы команд в консоли.**

17. Откройте в браузере адрес сервера по протоколу `http`.

    **Добавьте к отчету скриншот браузера**

## Изучение литературы

18. Ознакомьтесь с циклом статей «Изучаем Docker» на сайте Habr:

* [Часть 1: Основы](https://habr.com/ru/companies/ruvds/articles/438796/)
* [Часть 2: Термины и концепции](https://habr.com/ru/companies/ruvds/articles/439978/)
* [Часть 3: Файлы Dockerfile](https://habr.com/ru/companies/ruvds/articles/439980/)
* [Часть 4: Оптимизация Dockerfile](https://habr.com/ru/companies/ruvds/articles/440658/)
* [Часть 5: Команды](https://habr.com/ru/companies/ruvds/articles/440660/)
* [Часть 6: Работа с данными](https://habr.com/ru/companies/ruvds/articles/441574/)
