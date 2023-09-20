---
layout: default
title: Оглавление
---

# Amazon Virtual Private Cloud (VPC)

## Теория

**VPC CIDR blocks** - Блоки подсетей, работающих в данной сети. Подсети используются для сетевого управления ECS. Все IP-адреса ECS в CIDR-блоке подсети принадлежат данной подсети.

**Public Subnets** - Подсети, имеющие прямой доступ в интернет с PublicIP.

**Private Subnets** - Подсети, которым требуются NAT-сервера для выхода в интернет, не имеют PublicIP.

**Database Subnet** - Подсети, не имеющие PublicIP и выхода в интернет.

**Route Table** - Таблица машрутизации сетей.

**Internet Gateway** - Шлюз для выхода в интернет.

**NAT Gateway** - Шлюз, позволяющий Private Subnets выходить в интернет в одностороннем порядке.

**NAT Instance** - Сервер, позволяющий Private Subnets выходить в интернет в одностороннем порядке. (Не рекомендуется).

**Security Group** - Настройка безопасности портов инстанса. (Можно только разрешать).

**Network Access Control List** - Настройка безопасности портов подсети. (Можно разрешать и запрещать).

**Bastion Host** - Хост для доступа к Private Subnets.

**VPC Flow Logs** - Журналирование всего трафика.

**VPN Gateway** - Хост через VPN для доступа к Private Subnets.

**VPC Peering** - Настройка соединений и доступов между VPC.

Пример VPC сети:

![Image alt](https://docs.google.com/drawings/d/e/2PACX-1vSwj9UMO2qntCrLJhFNtehG5Q8uUNrmJL_iY6T9kPHvuQwh7skTLNj5o5EyaVB2qokWm7sG0dJhjyW5/pub?w=563&h=346)

**IP-адреса VPC CIDR block:**

10.0.0.0/16 - 65536 адресов минус 5 зарезервированных AWS

10.0.0.0/24 - 254 адресов минус 5 зарезервированных AWS

10.0.0.0/28 - 16 адресов минус 5 зарезервированных AWS

**Зарезервированные адреса:**

10.0.10.0 - 10.0.10.3, 10.0.10.255

**Доступные локальные адреса:**

10.0.0.0 - 10.255.255.255

172.16.0.0 - 172.31.255.255

192.168.0.0 - 192.168.255.255

Пример адресования:

![Image alt](https://docs.google.com/drawings/d/e/2PACX-1vSzzPsGVaSFq7LFm5iygHvM9mWKumBD9EMlp-KSY2QQ2Q4uQu1WKhsxy7zoKkCRtW1MrgZ4bZ-s3NVh/pub?w=413&h=131)

## Практика

1. Создать VPC:

    Задать IP CIDR block
    
    No IPv6
    
2. Создать Internet Gateway
3. Attach to VPC
4. Создать Subnet’ы:

    Выбрать VPC
    
    Выбрать Available Zone
    
    Задать CIDR блок IP в пределах сети
    
5. Настроить Public подсети в Subnet Actions:

    Auto-assign Public IP: yes
    
6. Настроить Route Table для Public, Private подсетей и DataBase:

    Add another route
    
    Destination 0.0.0.0/0 (Интернет)
    
    Target [наш Internet Gateway]
    
    Настроить Subnet Assosiations
    
7. Настроить безопасность в Network ACL (можно разрешить/запретить определенный трафик)
8. Можно добавить журналирование в Flow logs
9. Создать NAT Gateway

    Выбрать подсеть
    
    Создать Elastic IP Allocation
    
10. Настроить Route Table для Private подсетей к NAT Gateway:

    Add another route
    
    Destination 0.0.0.0/0 (Интернет)
    
    Target [наш NAT Gateway]
    
    Настроить Subnet Assosiations
    
11. Создать Security Groups для Bastion:

    Выбрать VPC
    
    Add Rule:
    
        SSH, Anywhere
        
12. Создать Auto Scaling Group:

    Create a new launch config
    
    Server Amazon Linux
    
    t2.micro
    
    Select an existing security group (Bastion)
    
    В Subnet выбрать Public подсети
    
    Проверить в Instances сервер Bastion
    
13. Запустить Instance’ы для подсетей:

    t2.micro
    
    Выбрать сеть и подсеть
    
    Select an existing security group (Bastion)
    
14. Подключиться к Bastion через SSH (IP Bastion’а)
15. В Bastion доключиться к Private Subnet:

    ssh -i key.pm ec2-user@[ip-адрес]
    
16. Проверить доступ в Интернет:

    ping google.com
    
Можно выйти через команду exit

## Литература

https://aws.amazon.com/ru/vpc/

https://www.youtube.com/watch?v=zPjVWiPpT-8 - Виртуальные Сети VPC

https://www.youtube.com/watch?v=sA9We2Gl4eI - Создание Сети

https://www.youtube.com/watch?v=vTER05sRObI - Bastion Host и проверка Сети
