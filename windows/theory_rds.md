---
layout: default
title: Remote Desktop Services
---

# Remote Desktop Services

RDP (Remote Desktop Protocol) --- сетевой протокол (3389/tcp) для удалённого рабочего стола.

Применение протокола RDP:

- Удаленный рабочий стол для управления --- разрешается ограниченное количество подключений (2 пользователя, каждый может подключиться только из одного места, пользователи не имеют доступ к чужому рабочему столу).
- Службы удаленного рабочего стола Remote Desktop Services (RDS).

[RDS на основе сеансов в Windows Server 2012 R2](https://beardedsysadmin.wordpress.com/2014/01/20/deployment-rds-within-domain/)

Чтобы использовать RDS на Windows Server нужно:
- лицензия на него
- Client Access License (CAL) --- лицензия на подключение клиента к серверу
- Terminal Client Access License (TCAL)

RDP для администрирования

RDP для одновременной работы нескольких пользователей

RemoteApp --- технология, позволяющая отображать на клиентском компьютере окно приложения, работающего на сервере.

