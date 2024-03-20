# Terraform

## Практика

1. Скачать свежий Terraform с [российского
зеркала](https://hashicorp-releases.yandexcloud.net/terraform/).

2. Распаковать исполняемый файл в один из каталогов перечисленных в PATH.

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

4. Создать каталог проекта и открыть его в VS Code.

5. Создать файл `variables.tf`:
   ```
   variable "bucket_name"{
       type = string
       default = "<Группа>-<Фамилия>"
   }

   variable "access_key" {
       type = string
       default = "<Идентификатор ключа>"
   }

   variable "secret_key" {
       type = string
       default = "<Секретная часть ключа>"
   }

   variable "domain_name" {
       type = string
       default = "<Группа>-<Фамилия>"
   }
   ```

6. Создать файл `index.html`:
   ```
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

7. Создать файл [`main.tf`](main.tf) и изучить его

8. Подготовить Terraform к работе:
    ```
    terraform init
    terraform plan
    ```

9. Запустить Terraform:
    ```
    terraform apply
    ```

10. Проверить работу в браузере

11. Отменить выделение ресурсов:
    ```
    terraform destroy
    ```
