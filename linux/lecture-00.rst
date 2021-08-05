Введение
--------

`Linux <https://www.youtube.com/watch?v=7XTHdcmjenI>`_ — операционная система с открытым исходным кодом.

Что делает ядро ОС?

- предоставление прикладным программам удобной и эффективной среды для работы;
- организация эффективной совместной работы прикладных программ;
- управление ресурсами компьютера (процессорным временем, оперативной памятью, внешней памятью, устройствами ввода-вывода и т. д.);
- реализация высокоуровневых программных абстракций (файл, процесс, сетевое соединение и т. д.)

`Ядро Linux <https://www.kernel.org/>`_ было создано `Линусом Торвальдсом <https://github.com/torvalds>`_. Ядро Linux продолжает развиваться с 1991 года по сегодняшний день под его руководством.

Для создания полноценной ОС ядру Linux необходимо системное ПО:

- системные утилиты;
- компиляторы (трансляторы, компоновщики, интерпретаторы, ассемблеры и т.п.);
- командный интерпретатор (оболочка);
- и т. д.

`FSF — Free software Foundation <https://www.fsf.org/>`_ (Р. Столлман) — фонд свободного ПО, который в рамках проекта GNU, разрабатывает широкий спектр ПО под `лицензией GPL <https://www.gnu.org/licenses/licenses.html>`_.

В ОС Linux в качестве системного ПО используются:

- GNU Coreutils
- GNU Binutils
- GNU Compiler Collection
- GNU Bash

Дистрибутив Linux = Ядро Linux + системное ПО + прикладное ПО. 

`Дистрибутивы Linux <https://www.distrowatch.com>`_:

- `Debian <https://www.debian.org/>`_. Дистрибутив Debian создан в 1993 году супругами Деброй и Иеном Мердок и является одним из старейших дистрибутивов Linux, активно развивающихся на сегодняшний день. Имеет 3 варианта:

    - `Debian Stable <https://www.debian.org/releases/stable/>`_ — вариант Debian в котором все пакеты максимально оттестированы;
    - `Debian Unstable (Sid) <https://www.debian.org/releases/testing/>`_ — вариант Debian в котором самые новые, но не неоттестированные пакеты;
    - `Debian Testing <https://www.debian.org/releases/unstable/>`_ — вариант Debian в котором пакеты проходят тестирование. В определенный момент он становится Stable-дистрибутивом;

- Семейство `Ubuntu <https://www.ubuntu.com/>`_ создано на базе Debian Testing и поддерживается компанией Canonical во главе с `Марком Шаттлвортом <https://www.markshuttleworth.com/>`_.

    - `Ubuntu Desktop <https://ubuntu.com/desktop>`_ — десктопный дистрибутив на базе Gnome 3;
    - `Ubuntu Server <https://ubuntu.com/server>`_ — популярный серверный дистрибутив;
    - `Edubuntu <https://edubuntu.org>`_ — десктопный дистрибутив на базе Gnome 3 для образования;
    - `Ubuntu Studio <https://ubuntustudio.org>`_ — десктопный дистрибутив на базе Gnome 3 для редактирования мультимедиа-контета;
    - `Ubuntu Kylin <https://ubuntukylin.com>`_ — десктопный дистрибутив на базе Gnome 3 для Китая;
    - `Kubuntu <https://kubuntu.org>`_ — десктопный дистрибутив на базе KDE;
    - `Lubuntu <https://lubuntu.net>`_ — десктопный дистрибутив на базе LXDE/LXQT;
    - `Ubuntu Budgie <https://ubuntubudgie.org>`_ — десктопный дистрибутив на базе Budgie;
    - `Ubuntu Mate <https://ubuntu-mate.org>`_ — десктопный дистрибутив на базе Mate;
    - `Xubuntu <https://xubuntu.org>`_ — десктопный дистрибутив на базе Xfce.
  
- Дистрибутивы основанные на базе Debian / Ubuntu:

    - `Mint <https://www.linuxmint.com/>`_ — дистрибутив ориентированный на удобство и стабильность;
    - `elementary <https://elementary.io/>`_ — дистрибутив с интерфейсом напоминающим Mac OS;
    - `Zorin <https://zorinos.com/>`_ — дистрибутив с красивым графическим интерфейсом пользователя;
    - `Kali Linux <https://www.kali.org/>`_ — дистрибутив для специалистов по информационной безопасности;
    - `The Amnesic Incognito Live System (Tails) <https://tails.boum.org/>`_ — дистрибутив ориентированный на приватность и конфиденциальность;
    - `Deepin <https://www.deepin.org/en/>`_ — дистрибутив на базе Debian Stable с графическим окружением Deepin;
    - `MX Linux <https://mxlinux.org/>`_ — сбалансированный дистрибутив с графическим окружением Xfce на базе Debian Stable;
    - `antiX <https://antixlinux.com>`_ — дистрибутив для устаревших компьютеров на базе Debian Stable;
    - `SteamOS <https://store.steampowered.com/steamos/>`_ — игровой дистрибутив основанный на Debian.

- `RedHat <https://www.redhat.com/en>`_ — американская корпорация, крупный разработчик свободного ПО и одноименное семейство дистрибутивов: 

    - `RedHat Enterprise Linux (RHEL) <https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux>`_ — серверный дистрибутив с платной поддержкой;
    - `Fedora <https://getfedora.org/>`_ — бесплатный дистрибутив, на котором RedHat обкатывает все новейшие изменения;
    - `CentOS <https://www.centos.org/>`_ — свободный бесплатный клон RHEL.

- `ArchLinux <https://www.archlinux.org/>`_ — независимый дистрибутив, развиваемый сообществом и отличающийся максимально новым ПО, простотой и гибкостью кастомизации.

    - `Manjaro <https://manjaro.org/>`_ — вариант дистрибутив ArchLinux с графическим установщиком и рядом всмопогательных утилит.

- Другие известные дистрибутивы:

    - `Slackware <https://www.slackware.com/>`_ — олдскульный и простой дистрибутив, поддерживаемый Патриком Фолькердингом
    - `openSUSE <https://www.opensuse.org/>`_ — популярный бесплатный дистрибутив от компании SUSE
    - `SUSE Linux Enterprise Server (SLES) <https://www.suse.com/products/server/>`_ — популярный серверный дистрибутив с платной поддержкой от компании SUSE
    - `Gentoo <https://www.gentoo.org/>`_ — дистрибутив использующий установку ПО из исходных кодов.
    - `Solus <https://getsol.us/home/>`_ — дистрибутив с графическим окружением Budgie.

Рыночные доли десктопных ОС:

* Windows - 85-88%
* Mac OS - 10%
* Linux - 2-5%

Рыночные доли мобильных ОС:

* Linux - 77%
* iOS - 20%

Рыночные доли серверных ОС:

* UNIX - 30%
* Linux - 30%
* Windows Server - 30%

Основные сферы применения Linux:

- серверы (веб-сервер, сервер СУБД, файл-сервер, сервер виртуализации, сервер службы каталогов)
- смартфоны и носимая электроника (Android, Tizen, Maemo)
- встраиваемые системы (Raspberry Pi, медиа-приставки, смарт-телевизоры, автомобили)
- сетевое оборудование
- вычислительные кластеры
- технологическое оборудование

Каким специалистам нужно изучать Linux?

- Научные работники;
- Системные администраторы и администраторы БД;
- Разработчики.

На сегодняшный день на рынке серверных ОС представлены следующие системы:

- различные версии Windows Server (около трети рынка)
- семейство Unix (около трети рынка):

    - BSD (FreeBSD, OpenBSD, DragonflyBSD, NetBSD)
    - Mac OS for Server
    - IBM AIX
    - Hewlett-Packard HP-UX
    - Oracle Solaris

- Семейство Linux (около трети рынка):

    - `RedHat Enterprise Linux (RHEL)`_
    - `Community Enterprise OS (CentOS) <https://www.centos.org/>`_
    - `Debian Stable <https://www.debian.org/releases/stable/>`_
    - `Ubuntu Server`_
    - `SLES <https://www.suse.com/products/server/>`_
    - `Oracle Linux <https://www.oracle.com/technetwork/server-storage/linux/overview/index.html>`_

Литература
""""""""""

- `Дмитрий Кетов. Внутреннее устройство Linux <https://drive.google.com/file/d/1EEAeifu3R92E5JA4aylDzufeKugmMYW5/view>`_
- `Михаэль Кофлер. Linux. Установка, администрирование, настройка <https://drive.google.com/file/d/1hj0J7sKO3bUa06a8g74oEyO7DXRhyt8m/view>`_
- `Уильям Шоттс. Командная строка Linux <https://drive.google.com/file/d/1VsfWKZtfu_--NmsFi7YgclpP0iVPdA9q/view>`_

