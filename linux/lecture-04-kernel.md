# Модули ядра

Ядра различных ОС можно классифицировать по структуре:
* *Монолитные* — ядро является единым модулем. Ранние версии ядра ОС Linux
  были монолитными. Преимуществами являются простота структуры и более высокая
  производительность (нет накладных расходов на переключение контекста между
  разными модулями). Недостатком является неустойчивость ядра перед малейшими
  ошибками в коде любого драйвера.
* *микроядерные* — ядро маленькое и загружает модули по мере необходимости
  аналогично прикладным программам. Драйверы в микроядерных ОС не могут
  нарушить работу системы в целом. На практике микроядерные ОС пока не получили
  широкого распространения. Преимуществами является устойчивость к ошибкам в
  коде драйверов, простота развития. Недостатками являются высокие накладные
  расходы на переключение контекстов между различными модулями.
* *гибридные* — промежуточный вариант. Большинство современных ОС используют
  гибридную структуру ядра.

Модуль ядра — это часть ядра Linux, которую можно динамически загрузить и выгрузить.
Как правило, модули ядра являются драйверами для различных устройств и файловых систем.
Модули хранятся в каталоге `/lib/modules/` (`/usr/lib/modules/`), в файлах с расширением `*.ko`.

Команды для работы с модулями:
- `lsmod` — список загруженных модулей
- `modinfo` — информация о модуле
- `instmod` — загрузить модуль без проверки на совместимость с АО
- `modprobe` — загрузить модуль
- `rmmod` — выгрузить модуль

Важные файлы и каталоги:
- `/boot/vmlinuz...` — сжатый образ ядра ОС
- `/boot/initrd...`   (либо `initramfs...`) — образ начальной ФС
- `/etc/modprobe.d/*` — настройки модулей.

`initrd` — образ начальной файловой системы, который содержит:
- модули ядра ОС (драйверы, отключаемые подсистемы ядра)
- системные утилиты
- копии важных конфигурационных файлов

Создание образа начальной файловой системы (`initrd`, `cpio`, `mkinitrd`, `mkinitramfs`, yaird, mkinitcpio).
`/etc/initramfs-tools/initramfs.conf` — конфигурационный файл `mkinitramfs`.
`update-initramfs` - скрипт для обновления `initrd` в дистрибутиве Ubuntu.

Параметры ядра ([Полный список](https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html)).

Редактирование параметров при загрузке (через загрузчик GRUB).
Редактирование параметров через `sysctl` (в рантайме либо через конф.файл `/etc/sysctl.conf`).

Режимы работы кода:
- kernel space - у кода есть системные права
- user space - код запускается с правами пользователя

Система инициализации:
- Systev V init (sysv init)
- SystemD (RedHat, Ленарт Поттеринг)

`PID` — номер (идентификатор) процесса.

`PPID` — номер родительского процесса.

## Systemd:

Unit - файл с описанием:
- службы (service, daemon)
- целевые состояния системы (target)
- точки монтирования (mount point)
- сокеты (socket)

и т.п.

Шаблонный модуль - файл который является шаблоном для запуска однотипных модулей.
