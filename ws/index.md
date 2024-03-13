---
layout: default
title: Оглавление
---

# Веб-сервисы и микросервисная архитектура

## Занятие 1. Протокол HTTP и инструментарий

Как работает HTTP? Какие инструменты позволяют с ним работать?

- Взаимосвязь с другими протоколами (HTTPS, HTTP/2, HTTP/3, TCP и т.п.)
- Методы HTTP
- Статусы ответов
- Заголовки запросов и ответов
- Cookies
- Web Developer Tools, CURL, Postman

## Занятие 2. Python Django REST Framework

Как быстро создать веб-сервис с помощью Django DRF?

- Django
- Django-Ninja
- Аутентификация
- CORS

Ход занятия:
- Создать каталог для проекта и виртуальное окружение
- Установить Django, Django REST Framework
- Создать проект
- Проверить работу
- Создать приложение и добавить его в настройки приложения
- Создать модели (готовый код)
- Выполнить миграцию
- Настроить админку и создать админа
- Проверить работу админки
- Создать сериализаторы
- Создать вьюсеты
- Создать роутер
- Проверить работу API
- Запустить код клиента
- Исправить ошибку с CORS
- Настроить аутентификацию

```python
class Product(models.Model):
    name = models.CharField('название', max_length=50)
    desc = models.TextField('описание', default='')
    photo = models.ImageField('фотография', blank=True, null=True)
    price = models.DecimalField('цена', max_digits=2)

    class Meta:
        verbose_name = 'товар'
        verbose_name_plural = 'товары'

    def __str__(self):
        return self.name


class Customer(models.Model):
    first_name = models.CharField('имя', max_length=50)
    last_name = models.CharField('фамилия', max_length=50)
    address = models.TextField('адрес', default='')

    class Meta:
        verbose_name = 'покупатель'
        verbose_name_plural = 'покупатели'

    def __str__(self):
        return f'{self.last_name} {self.first_name}'


class Order(models.Model):
    date = models.DateField('дата', auto_now_add=True)
    product = models.ForeignKey('Product', on_delete=models.CASCADE,
                                verbose_name='товар')
    customer = models.ForeignKey('Customer', on_delete=models.CASCADE,
                                 verbose_name='покупатель')
    quantity = models.IntegerField('количество', default=0)

    class Meta:
        verbose_name = 'покупатель'
        verbose_name_plural = 'покупатели'

    def __str__(self):
        return f'Заказ №{self.pk} от {self.date:%Y-%m-%d}'
```

## Резерв тем

- Авторизация в веб-сервисе
- Публикация веб-сайта с помощью Docker-Compose
- Создание спецификации веб-сервисов
- Хранение данных в ORM MongoEngine
- Кеширование данных в Redis
- Обмен данными с помощью Celery
- Python Flask-Restful
- Python FastAPI
- Go
- Node.js
