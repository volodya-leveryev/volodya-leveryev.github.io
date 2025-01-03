# Работа с сетью

## Введение

Для работы сети нужны драйверы (модули ядра) сетевого оборудования. \
`lspci` / `lsusb` / `lshw` — просмотр сведений об оборудовании. \
`lsmod` / `modinfo` / `modprobe` — работа с модулями ядра. \
[DKMS](https://habr.com/ru/articles/266399/) — механизм сборки из исходников дополнительных модулей ядра с автоматической пересборкой при установке новой версии ядра.

Сетевые интерфейсы обозначаются именами:
- `lo` — виртуальный петлевой сетевой интерфейс.
- `eth0`, `eth1`, `enp0s3` — Ethernet.
- `wifi0`, `wlan0`, `wlp5s0` — Wi-Fi.

Существует возможность создания виртуальных подинтерфейсов: `eth0:0`, `eth0:1`

Настройка сети меняется от дистрибутива к дистрибутиву. Также настройка сети может варьироваться в зависимости от применяемого ПО.

Для корректной работы в современных сетях как минимум нужно:
- IP-адрес хоста
- Маска сети
- Адрес шлюза
- Адрес DNS-сервера

Настройку сети можно выполнить:
- Автоматически с помощью DHCP-сервера
- С помощью статически заданных параметров

При работе с сетью важно помнить что:
- Настройка сети — должна выполняться администратором системы
- Работа с сетью может любой пользователь системы

При работе с сетью важно помнить что имеются:
- Набор классических утилит
- Набор новых утилит

## Диагностические утилиты
- `ethtool` ­— низкоуровневая работа с сетевыми картами
- `ifconfig` / `ip link` / `ip address` — просмотр и редактирование IP и  MAC адресов.
- `arp` / `ip neigh` — диагностика ARP (address resolution protocol).
- `route` / `ip route` — просмотр и редактирование таблицы маршрутизации.
- `resolveip`, `nslookup`, `dig` — диагностика DNS.
- `traceroute`, `tracepath` — диагностика маршрутизации.
- `cat /etc/resolv.conf` / `resolvectl` — диагностика настроек сети
- `ping` — диагностика доступности с помощью ICMP (Internet Control Management Protocol)
- `netstat` / `ss` - диагностика TCP/UDP
- `iw` / `iwctl` ­— диагностика и настройка беспроводного сетевого интерфейса.

## Настройка статических параметров вручную (старые утилиты)
- `ifup` / `ifdown` - включить / отключить сетевой интерфейс
- `ifconfig enp3s0 192.168.43.5/24` — назначение IPv4-адреса вручную
- `ifconfig enp3s0 add 10.14.156.5/24` — добавление IPv4-адреса вручную
- `route add default gw 192.168.43.1` — добавление шлюза по-умолчанию

## Настройка статических параметров вручную (новые утилиты)
- `ip link` - вкл / выкл сетевого интерфейса
- `ip address add 10.14.156.254/24 dev enp3s0`
- `ip route add default via 192.168.1.1`

# Явный запуск клиента DHCP
dhclient -v enp0s8
[dhcpcd](https://roy.marples.name/projects/dhcpcd)

## Настройка DNS
/etc/resolv.conf — настройка DNS \
`nameserver` - адрес DNS-сервера \
`domain - домен в котором нужно производить поиск (опционально)

`/etc/hosts` — настройка статических хостов

В некоторых дистрибутивах используется `systemd-resolved`: `resolvectl`

## [Настройка сети в Debian](https://wiki.debian.org/NetworkConfiguration)

`/etc/network/interfaces` — основной конфигурационный файл службы Networking.

`man interfaces` — встроенная подсказка по конфигурационному файлу

`sudo systemctl restart networking`

## [Настройка сети в Ubuntu Server](https://ubuntu.com/server/docs/network-configuration)
В Ubuntu Server одновременно применяется:
- Конфигурационный файл в стиле Debian
- Менеджер сетевых настроек Netplan

`/etc/netplan/*.yaml` — конфигурационные файлы в формате YaML

`man netplan` — встроенная подсказка по конфигурационному файлу

`sudo netplan apply` - применить настройку \
`sudo netplan try` - попробовать настройку, если не получилось - откат \
`sudo netplan ip leases enp0s8` - просмотр аренды

## [Настройка сети в RedHat](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/s1-networkscripts-interfaces)

Дистрибутивы RedHat (RHEL, CentOS, Fedora) используют:
- классические конфигурационные файлы
- менеджер NetworkManager

Для настройки используются текстовые конфигурационные файлы в каталоге: `/etc/sysconfig/network-scripts/*`

Настройки начинают работать в момент включения сетевого интерфейса.

Для настройки с помощью менеджера NetworkManager:
- nmtui
- nmcli

## Менеджеры настроек сети

Менеджеры настроек сети как правило проверяют настройки в конфигурационных файлах и не управляют сетевыми интерфейсами которые настроены с их помощью.

- [`Netplan`](https://netplan.io/) — разработан в Canonical и применяется в Ubuntu. \
- [`Network Manager`](https://wiki.gnome.org/Projects/NetworkManager) — часто применяется в десктопных дистрибутивах Linux и дистрибутивах на базе RedHat.
- [`systemd-resolved`](https://www.freedesktop.org/software/systemd/man/resolvectl.html) — часть проекта Systemd для управления разрешением DNS-имен.
- [`systemd-networkd`](https://www.freedesktop.org/software/systemd/man/systemd.network.html) — часть проекта Systemd для управления настройками сети.

Менее популярные:
- [ConnMan](https://01.org/connman)
- [netctl](http://www.cbs.dtu.dk/services/NetCTL/)
- [wicd](http://wicd.sourceforge.net/)

## Примечания
`SCTP` — Stream Control Transmission Protocol, современный протокол транспортного уровня (4 уровень модели OSI), который в будущем возможно заменит TCP и UDP.

`YAML` — структурированный язык разметки. Аналог JSON и XML.
+ обратно-совместим с JSON
+ человеко-читабельный
+ использование отступов как части синтаксиса для отражения вложенности

Как прописать использование прокси-серверов? \
```
export HTTP_PROXY=http://192.168.1.42:3128
export HTTPS_PROXY=https://192.168.1.42:3128
export FTP_PROXY=ftp://192.168.1.42:3128
export SOCKS_PROXY=???://192.168.1.42:9050
```

В качестве сетевого экрана в Linux применяется модуль ядра [`NetFilter`](https://en.wikipedia.org/wiki/Netfilter) и различные фронтенды ([`iptables`](https://ru.wikibooks.org/wiki/Iptables), [`firewall-cmd`](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-firewalld-on-centos-8-ru), [`ufw`](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04-ru) и т.п.), которые позволяют его конфигурировать.
