---
layout: default
date: 0001-01-01
title: Оглавление курса
---
# Администрирование ОС Linux

1. **Введение**
   Краткая характеристика и история развития ОС Linux. Ядро Linux и библиотека GNU C Library (glibc). Понятие дистрибутива. Стандарт POSIX. Взаимосвязь с ОС семейств UNIX и BSD. Обзор основных семейств дистрибутивов Linux (Debian, Red Hat, Slackware). Обзор серверных дистрибутивов (Red Hat Enterprise Linux, CentOS, Oracle Linux, SUSE Linux Enterprise Server, Ubuntu Server). Идентификация дистрибутива (uname, /etc/issue). Средства просмотра документации (whatis, man, info, /usr/share/doc/).
2. **Файловая система**
   Текущий рабочий каталог (.), родительский каталог (..), корневой каталог (/), домашний каталог пользователя (˜). Типы файлов (обычные файлы, каталоги, символические ссылки, файлы символьных и блочных устройств, именованные каналы, сокеты). Команды навигации по файловой системе (pwd, cd, pushd, popd). Операции с файлами (touch, rm, cp, mv, dd, file). Операции с каталогами (mkdir и rmdir). Просмотр файлов (head, tail, more, less). Поиск файлов (find, locate, which, whereis). Жесткие и символические ссылки (ln, unlink). Структура дерева каталогов Linux. Монтирование файловых систем (mount, chroot).
3. **Пользователи**
   Понятие учетной записи (/etc/passwd, /etc/group, /etc/shadow и /etc/gshadow). Учетная запись суперпользователя (root). Команды whoami, login, su, sudo, newgrp, passwd, gpasswd, chage, useradd, userdel, usermod, adduser. Стандартная система прав доступа (chmod, chown, chgrp). Особенности прав доступа у каталогов, биты SUID и SGID.
4. **Процессы**
   Идентификатор процесса. Родительские и дочерние процессы. Состояния процессов. Права доступа процессов, реальный и эффективный идентификаторы (биты SUID, SGID). Сигналы. Планировщик процессов. Механизмы межпроцессного обмена данными (именованные каналы, сокеты). Работа процессов в фоновом режиме (&, Ctrl+Z). Команды ps, top, kill, killall, nice, fg, bg, jobs, nohup, screen.
5. **Командный интерпретатор (оболочка)**
   Обзор командных интерпретаторов (sh, csh, ksh, zsh, tsh, bash). Встроенные команды bash (source, alias, bind, ...) Переменные среды (export, $HOME, $PATH, ...). Стандартные потоки ввода/вывода и ошибок stdin, stdout, stderr. Перенаправление стандартных потоков (<, &>, 2>, >, >>, и команды cat, dog, tee). Конвейеры (|).
6. **Скрипты (сценарии) командных интерпретаторов**
   Скрипты Linux (Shebang). Программирование для Bash. Коды возврата. Блоки команд. Операторы ;, && и ||. Подстановка команд (command substitution). Арифметические и логические выражения. Ветвления (if, case), циклы (for, while, until) и функции (function). Поиск строк с помощью grep. Регулярные выражения. Потоковые редакторы sed и awk.
7. **Установка программного обеспечения**
   Прекомпилированные пакеты, репозитории, зависимости, менеджеры пакетов (rpm, yum, dpkg, apt-get, apt-cache, aptitude). Сборка программного обеспечения из исходных кодов (gcc, m4, autoconf, automake, make). Статические и динамические библиотеки (ld, ar, ldd, ldconfig). Архивирование и сжатие (tar, gzip/gunzip, bzip). Редактор vi.
8. **Загрузка Linux и службы (демоны)**
   Параметры ядра (kernel, sysctl). Модули ядра (lsmod, instmod, mobprobe, rmmod, modinfo). Образ временной файловой системы (initrd, cpio, mkinitrd, mkinitramfs, yaird). Уровни инициализации системы (runlevel, telinit, /etc/inittab). Скрипты управления службами (/etc/init.d, /etc/rc.d). Управление службами (service, chkconfig, update-rc). Альтернативные системы загрузки (upstart, systemd).
9. **Работа с дисками и разделами**
   Таблицы разделов BIOS и GPT. Файлы устройств, команды lspci и lsusb, служба udev. Работа с дисками и разделами (fdisk, mkfs, fsck). Работа с виртуальной памятью (mkswap, swapon, swapoff). Загрузчик GRUB (grub-install, grub-mkconfig). Квотирование дискового пространства (du, df, edquota, quota). Управление менеджером логических томов (Logical Volume Manager, lvm). Управление программными RAID-массивами (mdadm).
10. **Работа в компьютерных сетях**
   Ручная и автоматическая настройка сетевых интерфейсов (hostname, ifconfig, route, /etc/resolv.conf, /etc/hosts, ip, wireless-tools, wpa_supplicant). Сетевые утилиты tracepath, dig, nmap, netcat, tcpdump. Сетевой экран netfilter (iptables, правила, цепочки правил, таблицы цепочек правил).
11. **Cлужбы (демоны)**
   Службы журналирования (dmesg, syslogd, Syslog-ng). Служба cron и планирование заданий (at, crontab). Серверы inetd и xinetd. Серверы удаленного доступа telnetd и sshd. Сервер службы доменных имен BIND. FTP-серверы vsftpd и ProFTPD. Веб-серверы Apache HTTP Server и Nginx. Почтовые серверы Sendmail и Postfix

