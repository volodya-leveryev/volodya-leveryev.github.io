---
layout: default
title: Оглавление
---

# AWS EC2 Auto Scaling

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
