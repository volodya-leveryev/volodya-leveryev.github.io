---
layout: default
title: 1. Установка Ubuntu
---
# Установка Ubuntu в виртуальную машину VirtualBox

## Цель работы

Получить навыки практической работы в Ubuntu.

## Теория

Oracle VirtualBox — это программа для виртуализации операционных систем.

Ubuntu – дистрибутив основанный на Debian GNU/Linux.

Компания Canonical поддерживает десктопную и серверную версии Ubuntu.

Для целей данной работы лучше всего подходит **десктопная версия Ubuntu**. Однако, если ваш компьютер не имеет достаточных вычислительных ресурсов вы можете попробовать серверную версию или **Xubuntu**.

## Подготовка

Убедитесь, что у вас установлена актуальная версия [VirtualBox](https://www.virtualbox.org/).

## Ход работы

1. Скачайте образ диска Ubuntu LTS с [официальной страницы дистрибутива](https://ubuntu.com/) и сохраните его в папке на жестком диске.

2. Создайте виртуальную машину для установки. Для этого запустите VirtualBox и нажмите на пункт "Создать".

3. В пошаговом мастере создания виртуальной машины выполните следующее следующее:

    * Придумайте название для вашей виртуальной машины (если вы работаете в компьютерном классе, то назовите её вашим ФИО - "Фамилия Имя Отчество"). 

    * Укажите каталог где нужно расположить файл с данными виртуальной машины.

    * На этом этапе оставьте путь к ISO-файлу не выбранным.

    * Выберите тип виртуальной машины — Linux.

    * Выберите версию виртуальной машины — Ubuntu соответствующей версии. Если версии на 64-бита отсутствуют, то это признак неверной конфигурации в BIOS (отключена технология аппаратной виртуализации в настройках CPU).

    * При установке десктопной версии Ubuntu рекомендуется выделить 4 Гб ОЗУ для виртуальной машины (для серверной версии достаточно 1 Гб ОЗУ).

    * При установке десктопной версии Ubuntu рекомендуется выделить 2 процессорных ядра (для серверной версии достаточно выделить 1 процессорное ядро).

    * При установке десктопной версии Ubuntu достаточно выделить 25 Гб для диска виртуальной машины (для серверной версии Ubuntu достаточно 10 Гб). Обратите внимание, что нужно указать формат хранения - "динамический виртуальный диск" (это означает то, что при необходимости, размер диска будет увеличен автоматически).

4. После создания виртуальной машины откройте настройки виртуальной машины и выполните следующее:

    * Для того, чтобы графический интерфейс в десктопной версии Ubuntu работал более плавно следует увеличить размер видеопамяти. Для этого перейдите в раздел "Дисплей" и увеличьте размер до 128 Мб. Если вы устанавливаете серверную версию.

    * *Данный шаг можно пропустить.* Для того, чтобы ускорить установку (не устанавливая обновления) можно временно отключить доступ к сети Интернет. Для этого перейдите в раздел "Сеть", разверните раздел "Дополнительно" и снимите галочку "Кабель подключен".

    * в разделе "Носители", выделите диск и выберите скачанный ранее образ диска Ubuntu.

5. Сохраните изменения и запустите виртуальную машину.

5. При старте установщика Ubuntu будет произведена проверка диска. После успешного старта установщика Ubuntu, нам необходимо выбрать язык, который будет использоваться при установке системы и начать установку, нажав на кнопку "Установить Ubuntu".



9. Определяем раскладку, которая будет добавлена при установке и нажимаем на "Продолжить"
10. Далее выбираем тип установки Ubuntu. Необходимо выбрать МИНИМАЛЬНУЮ УСТАНОВКУ. Убираем галочки в других опциях и нажимаем на "Продолжить".
11. Выбираем пункт “Стереть диск и установить Ubuntu” и нажимаем на "Установить"