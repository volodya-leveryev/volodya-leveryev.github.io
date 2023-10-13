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

## Подготовительные шаги

1. Войти в AWS Console

2. Найти образ инстанса (AMI) в разделе `EC2 \ Images \ AMIs`

## Ход работы

1. Создать конфигурацию для автозапуска новых инстансов (Launch Template)

  * Имя: <группа>-<фамилия>
  * Имя версии Initial version
  * Выбрать AMI: Counter
  * Выбрать тип инстанса: t2.micro
  * Выбрать существующий security group: Default

2. Создать группу масштабирования (Auto scaling group)

  * Имя <группа>-<фамилия>
  * Выбрать VPC
  * Выбрать Subnets
  * Создать новый Load Balancer (Application LB, internet-facing)
  * Выбрать имя группы (target)
  * Health check grace period: 60
  * Maximum capacity: 5
  * Scaling policies: Target tracking, Average CPU

3. Проверить масштабирование под нагрузкой вручную

4. Проверить масштабирование под нагрузкой с помощью `stress_test.py`

5. Проверить что количество инстансов уменьшается после снятия нагрузки

Скрипт для проверки нагрузки `stress_test.py`:

```python
from urllib import request
from time import sleep, strftime
from threading import Thread
 
def test():
   print('before', strftime('%H:%M:%S'))
   r = request.urlopen('http://<адрес сервера>/?n=100000000')
   print('after', strftime('%H:%M:%S'))
 
while True:
   t = Thread(target=test)
   t.start()
   sleep(5)
```

## Литература

1. https://aws.amazon.com/ru/ec2/autoscaling/
2. https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html
3. https://docs.aws.amazon.com/autoscaling/ec2/userguide/autoscaling-load-balancer.html
4. https://docs.aws.amazon.com/autoscaling/application/userguide/what-is-application-auto-scaling.html
