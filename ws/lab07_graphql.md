# GraphQL

## Теория

GraphQL — язык запросов и манипулирования данными, а также среда выполнения (runtime) для обработки этих запросов.

Преимущества по сравнению с REST API:
* Сокращение количества запросов. Например можно в одном запросе получить данные о профиле пользователя и всех его фолловерах.
* Клиент может избирательно запросить определенные поля и лучше описать необходимые ему данные.
* GraphQL создает только один эндпойнт (например `/graphql`).

Недостатки по сравнению с REST API:
* Сложность кэширования (в отличие от REST, где можно кэшировать по URL)
* [Проблема N+1 запросов](https://habr.com/ru/articles/805769/)
* Сложность ограничения глубины/стоимости запросов (защита от злоупотреблений)
* Более сложная обработка ошибок (всегда HTTP 200)

Изменения в REST API реализуются с помощью версий эндпойнтов, в GraphQL меняется схема данных

Типы запросов в GraphQL:

* query ­— получение данных по запросу
* mutation — изменение данных
* subscription — подписка на изменение данных в реальном времени

Элементы синтаксиса GraphQL:

* Поля (Fields)
* Аргументы (Arguments)
* Псевдонимы (Aliases)
* Фрагменты (Fragments)
* Переменные (Variables)
* Директивы (Directives)
* Операции (Operations)
* Inline Fragments
* Input Types (входные типы для мутаций)

Схема GraphQL — документ на сервере, который описывает доступные для клиента сущности и их поля.

SDL — Schema Definition Language — язык для написания схем в GraphQL.

TypeDefs — описания типов данных (сущностей) и их полей.

Resolvers — функции для получения и модификации данных (например из БД, файла или другого API).

## Практика

1. Создайте каталог и виртуальное окружение Python
2. Активировуйте виртуальное окружение и установите FastAPI
   `venv\scripts\activate`
   `pip install fastapi[standard] sqlmodel strawberry-graphql`
3. Создайте `model.py`
4. Загрузите данные по [странам](https://github.com/dr5hn/countries-states-cities-database/blob/master/csv/countries.csv) и [городам](https://github.com/dr5hn/countries-states-cities-database/blob/master/csv/cities.csv) в SQLite с помощью скрипта `load.py`
5. Создайте `app.py`, запустите приложение и откройте в браузере [http://127.0.0.1:8000/graphql](http://127.0.0.1:8000/graphql)
    ```
    fastapi dev app.py
    ```
6. Проверьте работу GraphQL API с помощью запроса:
    ```
    query {
      country (id: 1) {
        id, name
      }
    }
    ```
7. Добавьте возможность просмотривать данные по городам
8. Добавьте описания полей в таблицах City и Country (кроме внешних индексов)
9. Добавьте возможность фильтровать по названию столицы, по населению и площади
10. Создать репозиторий по [ссылке](https://classroom.github.com/a/cVzj-pSM) и сохранить код в него

## Приложения

**model.py**
```python
from os import path

from sqlmodel import Field, Relationship, Session, SQLModel, create_engine


class City(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True)
    country_id: int = Field(foreign_key="country.id")
    country: 'Country' | None = Relationship(back_populates="cities")


class Country(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True)
    cities: list["City"] = Relationship(back_populates="country")


sqlite_filename = "database.db"
sqlite_url = f"sqlite:///{sqlite_filename}"
engine = create_engine(sqlite_url, echo=True)

if not path.exists(sqlite_filename):
    SQLModel.metadata.create_all(engine)
```

**load.py**
```python
from csv import DictReader

from model import City, Country, Session, engine

with Session(engine) as session:

    with open('countries.csv', encoding='utf-8') as file1:

        country_reader = DictReader(file1)
        for country_dict in country_reader:
            country = Country(**country_dict)
            session.add(country)

    with open('cities.csv', encoding='utf-8') as file2:

        city_reader = DictReader(file2)
        for city_dict in city_reader:
            city = City(**city_dict)
            session.add(city)

    session.commit()
```

**app.py**
```python
from typing import Optional

import strawberry
from fastapi import FastAPI
from sqlmodel import select
from strawberry.fastapi import GraphQLRouter

from model import City, Country, Session, engine


@strawberry.type
class TypeCity:
    id: int
    name: str
    country_id: int


@strawberry.type
class TypeCountry:
    id: int
    name: str


@strawberry.type
class Query:
    @strawberry.field
    def country(self, id: Optional[int] = None, name: Optional[str] = None) -> list[TypeCountry]:
        with Session(engine) as session:
            if id is not None:
                query = select(Country).where(Country.id == id)
            elif name:
                query = select(Country).where(Country.name.like(f'%{name}%'))
            results = session.exec(query)
            return [TypeCountry(**c.model_dump()) for c in results]


schema = strawberry.Schema(query=Query)

graphql_app = GraphQLRouter(schema)

app = FastAPI()
app.include_router(graphql_app, prefix="/graphql")
```

## Источники

* [https://habr.com/ru/articles/765064/](https://habr.com/ru/articles/765064/)
* [https://youtu.be/Xkx5wroOt7o](https://youtu.be/Xkx5wroOt7o)
* [https://habr.com/ru/articles/728476/](https://habr.com/ru/articles/728476/)
* [https://habr.com/ru/companies/ru\_mts/articles/766428/](https://habr.com/ru/companies/ru_mts/articles/766428/)
* [https://graphql.org/](https://graphql.org/)

Примеры бесплатных GraphQL API: [https://www.apollographql.com/blog/8-free-to-use-graphql-apis-for-your-projects-and-demos](https://www.apollographql.com/blog/8-free-to-use-graphql-apis-for-your-projects-and-demos)

Клиенты для тестирования GraphQL API:

* [Postman](https://www.postman.com/) ([веб-версия](https://web.postman.co/home?ref_key=cvg53Jjw7uSgMf3U0z6UEF))
* [Insomnia](https://insomnia.rest/download)
