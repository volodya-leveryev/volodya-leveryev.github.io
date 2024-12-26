---
layout: default
title: Оглавление
---

# Практическая работа 1

## Цель работы

Написать программу для текстовой игры «Угадай число»

## Ход работы

1. Зарегистрироваться на сайте https://replit.com
2. Создать проект (Repl) по шаблону Python
3. В файле `main.py` написать программный код игры
4. После выполнения задания, пригласить преподавателя в проект (кнопка Invite в правом верхнем углу)

## Требования

Программа загадывает число. Пользователь должен угадать это число.

После запуска программы, она загадывает число в диапазоне от 1 до 100 и спрашивает догадку пользователя.
Пользователю дается 7 попыток чтобы угадать число. На каждую догадку пользователя программа отвечает:

* "You Win!!!" — если пользователь угадал число за 7 или меньше попыток.
* "You Lose!!!" — если пользователь не угадал число за 7 попыток.
* "Your guess is greater than answer" — если попытка пользователя больше чем ответ.
* "Your guess is lesser than answer" — если попытка пользователя меньше чем ответ.

После того как пользователь угадал число программа спрашивает, хочет ли он начать новую игру.
Если пользователь отказывается — программа завершается.

Если во время игры пользователь вводит не число или число за пределами разрешенного диапазона, то программа должна вывести сообщение об ошибке и повторить ввод данных. 
Количество попыток при этом не должно уменьшаться.

Исходный код должен быть оформлен в соответствии с требованиями PEP-8. Для проверки будет использоватся линтер `flake8`.