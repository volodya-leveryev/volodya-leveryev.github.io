---
layout: default
title: LVM - Logical Volume Manager
---

# LVM - Logical Volume Manager

## Цель работы

Познакомиться с основными возможностями менеджера логических томов - LVM.

## План работы

- Создать и подключить логический том
- Заменить физический диск
- Изменить размеры логического тома

## Теоретические основы

LVM имеет три уровня абстракции:
1. *Physical Volume* — физические тома, создаются в разделах дисков
2. *Volume Group* — группы томов, набор физических томов
3. *Logical Volume* — логические тома, размеры которых нужны пользователю. В них пользователь создает файловые системы и монтирует их к дереву каталогов.

Основной единицей размера в LVM является *экстент* размером 4 мб.

Названия утилит LVM для работы с физическими томами начинаются с букв `pv`.

Названия утилит LVM для работы с группами томов начинаются с букв `vg`.

Названия утилит LVM для работы с логическими томами начинаются с букв `lv`.

Все действия с LVM можно выполнить через утилиту `lvm`.

Система документации `man` использует утилиту `less` для просмотра. Поэтому работают все горячие клавиши от `less` (включая выход по клавише `q`).

## Подготовительный этап

- Подключитесь к серверу по протоколу SSH.
- Создайте отчет о выполнении лабораторной работы в формате `*.docx`.

## Создание и подключение логического тома

1. Создайте по одному разделу на всех свободных дисках и **добавьте в отчёт скриншот результата работы `lsblk`**

2. Создание физических томов LVM на созданных разделах:
   ```
   man pvcreate
   man pvdisplay
   ```
   **Добавьте в отчёт назначение утилит `pvcreate` и `pvdisplay`.**
   ```
   sudo pvcreate /dev/vdb1
   sudo pvcreate /dev/vdс1
   sudo pvdisplay
   ```
   **Добавьте в отчёт скриншот результата работы `pvdisplay`.**

3. Создание группы томов LVM из созданных физических томов:
   ```
   man vgcreate
   ```
   **Добавьте в отчёт назначение утилиты `vgcreate`.**
   ```
   sudo vgcreate my_group1 /dev/vdb1 /dev/vdc1
   sudo vgdisplay
   sudo pvdisplay
   ```
   **Добавьте в отчёт скриншот результатов работы `vgdisplay` и `pvdisplay`. Выделите изменившиеся значения в выводе `pvdisplay`.**

4. Создание логического тома LVM:
   ```
   man lvcreate
   ```
   **Добавьте в отчёт назначение утилиты `lvcreate`, а также назначение ключей `--size` и `--extents`.**
   ```
   sudo lvcreate --name my_volume1 --extents 90%VG my_group1
   sudo lvdisplay
   sudo pvdisplay
   ```
   **Добавьте в отчёт скриншот результатов работы `lvdisplay` и `pvdisplay`. Выделите изменившиеся значения в выводе `pvdisplay`.**

5. Создание файловой системы:
   ```
   sudo mkfs.ext4 /dev/my_group1/my_volume1
   sudo blkid
   ```
   **Добавьте в отчёт скриншот результатов работы `blkid`. Выделите строку с созданной файловой системой.**

6. Подключение файловой системы к дереву каталогов:
   ```
   sudo mount /dev/my_group1/my_volume1 /mnt
   lsblk
   ```
   **Добавьте в отчёт скриншот результатов работы `lsblk`. Выделите точку монтирования созданной файловой системы.**

## Замена физического тома

7. Замена физического тома без прерывания работы логического тома:
   ```
   man vgextend
   man pvmove
   man vgreduce
   ```
   **Добавьте в отчёт назначение утилит `vgextend`, `pvmove` и `vgreduce`.**
   ```
   sudo vgextend my_group1 /dev/vdd1
   sudo pvmove /dev/vdb1
   sudo vgreduce my_group1 /dev/vdb1
   sudo pvdisplay
   ```
   **Добавьте в отчёт скриншот результатов работы `pvdisplay`. Выделите изменившиеся значения в выводе `pvdisplay`.**

## Изменение размеров логического тома

8. Увеличение размера логического тома без прерывания его работы:
   ```
   man resize2fs
   man lvresize
   ```
   **Добавьте в отчёт назначение утилит `resize2fs`, `lvresize` и ключа `--resizefs`.**
   ```
   sudo lvresize --extents 100%VG --resizefs /dev/my_group1/my_volume1
   sudo lvdisplay
   ```
   **Добавьте в отчёт скриншот результатов работы `lvdisplay`. Выделите изменившиеся значения в выводе `lvdisplay`.**

9. Уменьшение размера логического тома:
   ```
   man lsof
   ```
   **Добавьте в отчёт назначение утилиты `lsof`.**
   ```
   cd /mnt
   sudo lsof /mnt
   cd ~
   sudo lsof /mnt
   sudo umount /mnt
   sudo lvresize --extents 90%VG --resizefs /dev/my_group1/my_volume1
   sudo mount /dev/my_group1/my_volume1 /mnt
   sudo lvdisplay
   ```
   **Добавьте в отчёт скриншот результатов работы `lvdisplay`. Выделите изменившиеся значения в выводе `lvdisplay`.**

## Дополнительная литература

* [LVM - xgu.ru](http://xgu.ru/wiki/LVM)
* [LVM - ArchWiki](https://wiki.archlinux.org/title/LVM)
* [Logical Volume Manager (LVM)](https://help.ubuntu.ru/wiki/lvm)
* [Повесть о Linux и LVM](https://www.opennet.ru/docs/RUS/linux_lvm/)
