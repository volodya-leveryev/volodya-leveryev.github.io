# Темы курса Linux 2

## Тема 1. Docker
## Тема 2. Nginx, HTTP Proxy, Docker, Certbot SSL
## Тема 3. Docker Compose, Build,  Django, PostgreSQL

```python
# models.py

import django.db import models


class Student(models.Model):
    last_name = models.CharField('фамилия', max_length=50)
    first_name = models.CharField('имя', max_length=50)
    second_name = models.CharField('отчество', max_length=50, blank=True, default='')
    group = models.ForeignKey('StudyGroup', verbose_name='группа')

    def __str__(self):
        res = self.last_name + ' ' + self.first_name[0] + '.'
        if self.second_name:
            res += self.second_name[0] + '.'
        return res

    class Meta:
        verbose_name = 'студент'
        verbose_name_plural = 'студенты'


class StudyGroup(models.Model):
    name = models.CharField('название', max_length=50)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = 'группа'
        verbose_name_plural = 'группы'
```


```python
# admin.py

from django.contrib import admin

from .models import Student, StudyGroup

admin.site.register(Student)
admin.site.register(StudyGroup)
```

## Тема 4. 
## Тема 5. 
## Тема 6. 
## Тема 7. 
## Тема 8. 
## Тема 9. 
## Тема 10. 
## Тема 11. 
## Тема 12. 
