---
layout: default
title: Оглавление
---

# AWS EC2 Auto Scaling

## Теория

**Launch Template** — шаблон создания инстансов EC2. Заменяет **Launch Configurations**. Задает параметры:

* AMI (Amazon Machine Image) — образ для создания дисков инстансов EC2
* тип инстансов EC2 и ключ для подключения по SSH
* параметры сети (подсеть, группа безопасности)
* параметры дисков
* остальные параметры инстансов EC2

**Load Balancer** — балансировщик нагрузки. Определяет настройки распределения нагрузки по инстансам в группе автомасштабирования.

Типы балансировщика нагрузки:

* Application Load Balancer — выполняет балансировку нагрузки на уровне прикладного приложения (HTTP/HTTPS).

* Network Load Balancer — выполняет балансировку нагрузки на транспортном уровне (TCP/UDP).

* Gateway Load Balancer — распределяет трафик на виртуальные аппаратно-программные комплексы сторонних разработчиков (например сетевые экраны, детекторы вторжения и т.п.) которые поддерживают протокол GENEVE.

* Classic Load Balancer — выполяет балансировку нагрузки либо на транспортном (TCP/SSL), либо на прикладном уровне (HTTP/HTTPS). Устаревшее решение.

**Auto Scaling Group** — группа автомасштабирования которая определяет:

* сколько инстансов создавать и при каких условиях
* с помощью какого шаблона
* нужен ли балансировщик нагрузки

![Схема](https://docs.aws.amazon.com/autoscaling/ec2/userguide/images/as-basic-diagram.png)

## Литература

1. https://aws.amazon.com/ru/ec2/autoscaling/
2. https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html
3. https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html
4. https://docs.aws.amazon.com/autoscaling/application/userguide/what-is-application-auto-scaling.html
