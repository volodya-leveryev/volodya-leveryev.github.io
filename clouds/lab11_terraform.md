---
layout: default
title: Terraform
---

# {{page.title}}

## Практика

1. Создайте на локальном компьютере каталог для размещения файлов данной работы.

2. Скачайте текущую версию Terraform с [российского зеркала](https://hashicorp-releases.yandexcloud.net/terraform/) (не используйте альфа-версию), переместите в созданный каталог и распакуйте его.

3. Создайте конфигурационный файл Terraform: `%APPDATA%\terraform.rc` (например
`C:\Users\<Имя пользователя>\AppData\Roaming\terraform.rc`) со следующим
содержанием:
    ```
    provider_installation {
        network_mirror {
            url = "https://terraform-mirror.yandexcloud.net/"
            include = ["registry.terraform.io/*/*"]
        }
        direct {
            exclude = ["registry.terraform.io/*/*"]
        }
    }
    ```

4. Войдите в веб-консоль AWS, cоздайте ключ доступа. Создайте текстовый файл `variables.tf` и впишите значения:
    ```
    variable "bucket_name" {
        type = string
        default = "<Группа>-<Фамилия>"
    }

    variable "access_key" {
        type = string
        default = "<ACCESS_KEY_ID>"
    }

    variable "secret_key" {
        type = string
        default = "<ACCESS_KEY_SECRET>"
    }

    variable "domain_name" {
        type = string
        default = "<Группа>-<Фамилия>"
    }
    ```

6. Создайте файл `index.html`:
    ```html
    <!doctype html>
    <html>
        <head>
            <title>Test</title>
        </head>
        <body>
            <h1>Test</h1>
        </body>
    </html>
    ```

7. Создайте файл [`main.tf`](./terraform/main.tf) и изучите его.

8. Подготовьте Terraform к работе:
    ```cmd
    terraform init
    terraform plan
    ```

9. Запустите Terraform:
    ```cmd
    terraform apply
    ```

10. Проверьте созданные ресурсы в веб-консоли управления, проверьте работу сайта в браузере.

11. Отмените выделение ресурсов:
    ```cmd
    terraform destroy
    ```
