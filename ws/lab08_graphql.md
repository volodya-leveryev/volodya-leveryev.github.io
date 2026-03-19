# GraphQL

## Теория

GraphQL — язык запросов и манипулирования данными, а также среда выполнения (runtime) для обработки этих запросов.

Преимущества по сравнению с REST API:
* Сокращение количества запросов. Например можно в одном запросе получить данные о профиле пользователя и всех его фолловерах.  
* Клиент может избирательно запросить определенные поля и лучше описать необходимые ему данные  
* GraphQL создает только один эндпойнт (например `/graphql`)

Недостатки по сравнению с REST API:
* Сложность кэширования (в отличие от REST, где можно кэшировать по URL)
* Проблема N+1 запросов
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
4. Загрузите [данные по странам](https://github.com/dr5hn/countries-states-cities-database/blob/master/json/countries.json) в SQLite с помощью скрипта `load.py`
5. Создайте `app.py`, запустите приложение и откройте в браузере [http://127.0.0.1:8000/graphql](http://127.0.0.1:8000/graphql)

`fastapi dev app.py`

6. Проверьте работу GraphQL API с помощью запроса:
    ```
    query {
      country (id: 1) {
        id, name
      }
    }
    ```
7. Добавьте возможность просмотривать данные по странам (кроме полей `timezones` и `translations`)
8. Добавите возможность фильтровать данные по названию столицы, по населению и площади
9. Cохраните код в репозитории: []()

## Приложения

**model.py**
```python
from os import path
from sqlmodel import SQLModel, Session, Field, create_engine


class Country(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True)


sqlite_file_name = "database.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"
engine = create_engine(sqlite_url, echo=True)

if not path.exists(sqlite_file_name):
    SQLModel.metadata.create_all(engine)
```

**load.py**  
```python
import json

from model import Country, Session, engine

with open('countries.json', encoding='utf-8') as f:
    data = json.load(f)

with Session(engine) as session:
    country_id = 1
    for country in data:
        db_country = Country(
            id=country_id,
            name=country['name'],
        )
        session.add(db_country)
        country_id += 1
    session.commit()
```

**app.py**
```python
from typing import Optional

import strawberry  
from fastapi import FastAPI  
from sqlmodel import select  
from strawberry.fastapi import GraphQLRouter

from model import Country, Session, engine


@strawberry.type  
class TypeCountry:  
    id: int  
    name: str  


@strawberry.type  
class Query:  
    @strawberry.field  
    def country(self, id: Optional[int] = None, name: Optional[str] = None) -> list[TypeCountry]:  
        with Session(engine) as session:  
            if id:  
                query = select(Country).where(Country.id == id)  
            elif name:  
                query = select(Country).where(Country.name.like(f'%{name}%'))  
            results = session.exec(query)  
            return [TypeCountry(**c.model_dump()) for c in results]  
        return []


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
