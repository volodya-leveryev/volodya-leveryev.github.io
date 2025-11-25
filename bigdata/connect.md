# Подключение данных

## Подключение объектного хранилища (S3)

**Облачное объектное хранилище (S3)** — это сервис хранения данных, в котором информация хранится в виде отдельных объектов (файлов) и доступ к которым предоставляется через сетевые API. Он обеспечивает масштабируемое, отказоустойчивое и долговечное хранение неструктурированных данных (файлов, изображений, логов, архивов), поддерживает доступ по HTTP(S) и позволяет управлять объектами независимо друг от друга без использования традиционной файловой системы.

[Публичные наборы данных AWS](https://github.com/awslabs/open-data-docs/)

Вариант 1. Онлайновое подключение хранилища:
```bash
# установка
sudo apt-get install s3fs

# авторизация (необязательно)
echo "<ACCESS_KEY_ID>:<SECRET_ACCESS_KEY>" > ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs

# подключение
mkdir ~/s3bucket
s3fs <bucket-name> ~/s3bucket
```

Вариант 2. Синхронизация с хранилищем:

```bash
# установка
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# авторизация (необязательно)
aws configure

# просмотр списка файлов
aws s3 ls s3://<bucket-name>/

# копирование файлов
aws s3 sync s3://<bucket-name>/ ./s3images
```

Обработка изображений с помощью утилиты `convert`:

```bash
mkdir resized
for img in $(ls *.png | head -n 100); do
    convert "$img" -resize 800x600 "resized/$img"
done
```

Для обработки изображений также часто используется утилита [ImageMagick](https://imagemagick.org/).

**Задание:** измените разрешение 100 картинок из набора данных *Amazon Bin Image Dataset* и сохраните их в локальном каталоге.

## Git LFS


```bash
# установка Git LFS
sudo apt-get install git-lfs
git lfs install

# клонирование репозитория
git clone <url>

# 
git lfs ls-files

```

**Версионирование данных** — 

## DVC

