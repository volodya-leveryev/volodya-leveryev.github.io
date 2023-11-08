---
layout: default
title: Spark SQL
---

Spark SQL

1. Скачайте токен из аккаунт Kaggle (зарегистрируйте новый, если у вас его нет)
2. Создайте новый блокнот в Google Colab
3. Загрузите ключ `kaggle.json` в Colab и затем скачайте [набор данных](https://www.kaggle.com/datasets/Cornell-University/arxiv)
   ```
   from google.colab import files
   files.upload()
   !mkdir ~/.kaggle
   !mv kaggle.json ~/.kaggle
   !chmod 600 ~/.kaggle/kaggle.json
   !pip install -q kaggle
   !kaggle <???>
   !unzip archive.zip
   ```
4. Создайте сессию Spark и загрузите данные
   ```
   !pip install -q pyspark
   from pyspark.sql import SparkSession
   spark = SparkSession.builder.master("local[*]").getOrCreate()
   data = spark.read.json('<???>')
   ```
5. Напишите SQL запросы для вычисления количества статей в наборе данных
   ```
   spark.sql("<Запрос>")
   ```

