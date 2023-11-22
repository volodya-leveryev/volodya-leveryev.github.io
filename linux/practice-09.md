---
layout: default
title: Работа с Docker Compose
---

# Работа с Docker Compose

## Цель работы

Научиться основам работы с Docker Compose.

## План работы

- Запустить готовые образы WordPress и MySQL
- Создать и запустить свой образ

## Подготовительный этап

- Подключитесь к серверу по протоколу SSH.
- Создайте отчет о выполнении лабораторной работы в формате *.docx.
- Установите Docker по [инструкции](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) (не забудьте добавить своего пользователя к группе `docker`).

## Теоретическая часть

Docker позволяет запускать приложения в чётко описанной программистом среде — контейнере.

Docker Compose позволяет запустить систему из нескольких взаимодействующих контейнеров.

Файлы `Dockerfile` описывают процесс создания образа и используют императивный стиль: Docker последовательно выполняет команды.

Файлы `docker-compose.yaml` описывают желаемое состояние разворачиваемой системы и используют декларативный стиль: Docker Compose должен привести состояние системы к описанию в файле.

Формат файлов `*.yaml` (`*.yml`) являются аналогом формата `*.json` и позволяет создавать структурированные человеко-понятные конфигурационные файлы. Важным элементом синтаксиса в этом формате являются отступы (аналогично отступам в синтаксисе в языке Python).

Сервисом (`service`) в терминах Docker Compose считается набор из одного или более однотипных контейнеров.

1. Откройте [описание корневого элемента `service`](https://docs.docker.com/compose/compose-file/05-services/) и **законспектируйте в отчет** назначение следующих элементов:

   * `image`
   * `build`
   * `ports`
   * `volumes`
   * `command`
   * `depends_on`
   * `deploy`
   * `env_file`
   * `environment`
   * `networks`
   * `restart`

2. Выполните команду `docker compose up --help` и **законспектируйте в отчет**:

   * назначение команды `up`
   * назначение следующих ключей:
     - `--build`
     - `--detach`
     - `--scale`

3. Выполните команду `docker compose --help` и **законспектируйте в отчет** назначение команд:

   * `ps`
   * `logs`
   * `down`
   * `exec`
   * `kill`
   * `cp`
   * `create`
   * `build`
   * `start`
   * `stop`
   * `rm`

## Запуск готовых образов с WordPress и MySQL

4. Создайте на сервере каталог wordpress и перейдите в него

5. Изучите описание образа [WordPress](https://hub.docker.com/_/wordpress) и создайте `docker-compose.yaml` по приведенному образцу

6. Запустите систему в работу командой `docker compose up -d`

7. Проверьте работу контейнеров с помощью команды `docker compose ps` и **добавьте в отчёт скриншот с результатом её работы**

8. Проверьте работу системы в браузере и добавьте **добавьте в отчёт скриншот**

9. Остановите работу системы командой `docker compose down`

## Создание и запуск своего образа

10. Вернитесь в домашний каталог пользователя, создайте в нем новый каталог `custom` и перейдите в него

11. Создайте новый файл `app.py` со следующим содержанием:

    ```
    import time
    
    import redis
    from flask import Flask
    
    app = Flask(__name__)
    cache = redis.Redis(host='redis', port=6379)
    
    def get_hit_count():
        retries = 5
        while True:
            try:
                return cache.incr('hits')
            except redis.exceptions.ConnectionError as exc:
                if retries == 0:
                    raise exc
                retries -= 1
                time.sleep(0.5)
    
    @app.route('/')
    def hello():
        count = get_hit_count()
        return 'Hello World! I have been seen {} times.\n'.format(count)
    ```

12. Создайте новый файл `Dockerfile` со следующим содержанием:

    ```
    FROM python:3.11-alpine
    WORKDIR /code
    ENV FLASK_APP=app.py
    ENV FLASK_RUN_HOST=0.0.0.0
    RUN apk add --no-cache gcc musl-dev linux-headers
    RUN pip install flask redis
    EXPOSE 5000
    COPY . .
    CMD ["flask", "run"]
    ```

13. Создайте подкаталог `data` и новый файл `docker-compose.yaml` со следующими сервисами:

    * Сервис `web` должен собираться с помощью `Dockerfile` из п.12 и отображать порт 5000 в порт 80 на хосте
    * Сервис `redis` должен использовать готовый образ `redis:alpine` и отображать подкаталог `data` в каталог `/data` в контейнере

14. Запустите систему в работу со сборкой образа

15. **Добавьте в отчёт скриншот** с результатом работы `docker compose ps`

16. Проверьте работу системы в браузере и добавьте **добавьте в отчёт скриншот**
