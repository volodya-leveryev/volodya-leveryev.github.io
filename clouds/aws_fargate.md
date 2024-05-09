# AWS Fargate

Elastic Container Service (ECS) — сервис для запуска контейнеров.
Elastic Container Registry (ECR) — сервис для хранения образов контейнеров.
Elastic Kubernetes Service (EKS) — сервис для запуска контейнеров в кластере Kubernetes.

1. Войти в веб-консоль AWS, выберите регион ap-northeast-1.
2. Войти в сервис Cloud9 и создать среду (environment):

   Наименование: <группа>-<фамилия>\
   Размер инстанса: t3.small

3. Открыть созданную интегрированную среду разработки Cloud9.
4. Создать новый файл **app.py**.
5. Установить пакет Flask:

   ```cmd
   pip install flask
   ```

6. Запустить приложение кнопкой Run и проверить превью в Cloud9.
7. Создать **Dockerfile**.
8. Создать образ контейнера:

   ```cmd
   docker build -t <группа>-<фамилия> .
   docker images
   ```

9. Запустить контейнер в Cloud9 и проверить превью:

   ```cmd
   docker run -p 8080:80 <группа>-<фамилия>
   ```

10. Создать приватный реестр в сервисе ECR и скопировать его URI.
11. Добавить тег в созданный ранее образ:

    ```cmd
    docker tag <группа>-<фамилия>:latest <URI созданного репозитория>:latest
    ```

12. Авторизоваться в реестре:

    ```cmd
    aws ecr get-login-password | docker login --username AWS --password-stdin 496008581975.dkr.ecr.ap-northeast-1.amazonaws.com
    ```

13. Отправить образ в реестр:

    ```cmd
    docker push <URI созданного репозитория>:latest
    ```

14. Создать task definition в сервисе ECS.

    Название: <группа>-<фамилия>\
    Указать Image URI

15. Создать кластер ECS.
16. Запустить задачу (Task Run) в созданном кластере. В разделе Networking выбрать VPC и публичную подсеть, выбрать группу безопасности по-умолчанию (default).
17. Проверить работу в браузере по внешнему адресу работающей задачи.
    
    **app.py:**
    ```python
    from flask import Flask

    app = Flask(__name__)

    @app.route("/")
    def hello_world():
        return "<p>Hello, World!</p>"

    if __name__ == '__main__':
        app.run(host='0.0.0.0', port=8080)
    ```

    **Dockerfile:**
    ```Dockerfile
    FROM python:slim
    COPY . .
    RUN pip install flask gunicorn
    CMD gunicorn --bind 0.0.0.0:80 app:app
    ```
