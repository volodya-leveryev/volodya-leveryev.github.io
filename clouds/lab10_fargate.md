# AWS Fargate

## Теоретическая часть

Elastic Container Service (ECS) — сервис для запуска контейнеров. ECS позволяет запускать контейнеры в друх режимах:
* На конкретных инстансах EC2.
* В бессерверном режиме (Fargate).

Elastic Container Registry (ECR) — сервис для хранения образов контейнеров.

## Практическая часть

1. Войдите в веб-консоль AWS, выберите регион ap-northeast-1 (Tokyo).

2. Войдите в сервис Cloud9 и создайте среду (environment):

    Наименование: <группа>-<фамилия>\
    Размер инстанса: t3.small\
    Оставьте значение других параметров по умолчанию.

3. Откройте созданную интегрированную среду разработки Cloud9.

4. Создайте новый файл **app.py** (код в приложении).

5. В терминале установите пакет Flask:

    ```bash
    pip install flask
    ```

6. Запустите приложение (кнопка **Run**), проверьте его работу в превью (кнопка **Preview**), затем остановите его.

7. Создайте **Dockerfile** (код в приложении).

8. В терминале создайте образ контейнера:

    ```bash
    docker build -t <группа>-<фамилия> .
    docker images
    ```

9. Запустите контейнер в терминале и проверьте его работу в превью (кнопка Preview):

    ```bash
    docker run --name testing -p 8080:80 <группа>-<фамилия>
    ```

10. Откройте второй терминал и остановите контейнер:

    ```bash
    docker stop testing
    ```

11. Откройте в новой вкладке браузера сервис ECR (Elastic Container Registry), перейдите в раздел **Private Registry**, **Repositories**, создайте приватный репозиторий образов и зафиксируйте его URI.

    В поле *namespace/repo-name* введите значение <группа>-<фамилия>\
    Оставьте значение других параметров по умолчанию.

12. Вернитесь в Cloud9 и в терминале добавьте тег в созданный ранее образ:

    ```bash
    docker tag <группа>-<фамилия>:latest <URI репозитория в ECR>:latest
    ```

13. В терминале авторизуйтесь в приватном реестре ECR:

    ```bash
    aws ecr get-login-password | docker login --username AWS --password-stdin 496008581975.dkr.ecr.ap-northeast-1.amazonaws.com
    ```

14. В терминале отправьте образ в реестр:

    ```bash
    docker push <URI репозитория в ECR>:latest
    ```

15. Откройте сервис ECS (Elastic Container Serivce), перейдите в раздел **Task definitions**, создайте новое описание задачи (task definition):

    Task definition family: <группа>-<фамилия>\
    Container, Name: <группа>-<фамилия>\
    Container, Image URI: <URI репозитория в ECR>\
    Container, Port name: 80\
    Оставьте значение других параметров по умолчанию.

15. В сервисе ECS (Elastic Container Serivce), перейдите в раздел **Clusters**, создайте кластер ECS.

    Cluster name: <группа>-<фамилия>\
    Очистите поле Default namespace\
    Оставьте значение других параметров по умолчанию.

16. Откройте созданный кластер, перейдите в раздел **Tasks** и создайте задачу (*Run new task*):

    *Deployment configuration*, Family — выберите созданное ранее описание задаче\
    Разверните раздел *Networking*, выберите VPC и все подсети\
    Выберите существующую группу безопасности по-умолчанию (default)\
    Оставьте значение других параметров по умолчанию.

17. Откройте созданную задачу (не путать с описанием задачи), найдите её публичный адрес и проверьте работу в браузере по протоколу HTTP.

## Приложения

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
