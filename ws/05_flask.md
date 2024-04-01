---
layout: default
title: Оглавление
---
# Тема 5. Flask

Документация:
* [Flask](https://flask.palletsprojects.com/)
* [Jinja2](https://jinja.palletsprojects.com/)
* [Flask-SQLAlchemy](https://flask-sqlalchemy.palletsprojects.com/)
* [Flask-Migrate](https://flask-migrate.readthedocs.io/)
* [Flask-Admin](https://flask-admin.readthedocs.io/)
* [Flask-RESTX](https://flask-restx.readthedocs.io/)
* [Flask-GraphQL](https://github.com/graphql-python/flask-graphql/)

Структура проектов Flask по шаблону Application Factory.

Flask BluePrint.

Ресурсы Flask-RESTX.

Пространства имен Flask-RESTX.


```
from flask import Flask
from flask_admin import Admin
from flask_admin.contrib.sqla import ModelView
from flask_migrate import Migrate
from flask_graphql import GraphQLView

from models import api, db, course, students, task, solution
from models.students import schema


def get_secret_key():
    try:
        f = open('secret_key')
        return f.readline()
    except FileNotFoundError as e:
        print('Secret key file not found!')
    return 'secret'


app = Flask(__name__)
app.config['SECRET_KEY'] = get_secret_key()
app.config['SERVER_NAME'] = 'localhost:5000'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///app.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)
Migrate(app, db)

admin = Admin(app)
admin.add_view(ModelView(students.Student, db.session))
admin.add_view(ModelView(course.Course, db.session))
admin.add_view(ModelView(task.Task, db.session))

api.init_app(app)
api.add_resource(students.StudentApi, '/students/<int:obj_id>/')
api.add_resource(students.StudentListApi, '/students/')
api.add_resource(course.CourseApi, '/course/<int:obj_id>/')
api.add_resource(course.CourseListApi, '/course/')
api.add_resource(task.TaskApi, '/task/<int:obj_id>/')
api.add_resource(task.TaskListApi, '/task/')
api.add_resource(solution.SolutionApi, '/solutions/<string:obj_id>/')
api.add_resource(solution.SolutionListApi, '/solutions/')

app.add_url_rule(
    '/graphql',
    view_func=GraphQLView.as_view(
        'graphql',
        schema=schema,
        graphiql=True # for having the GraphiQL interface
    )
)
```

```
from flask import abort, request
from flask_restx import Api, Resource, marshal, reqparse
from flask_sqlalchemy import SQLAlchemy

authorizations = {
    'ApiKeyAuth': {
        'type': 'apiKey',
        'in': 'header',
        'name': 'X-API-Key',
    }
}
api = Api(authorizations=authorizations)
db = SQLAlchemy()


def api_key_required(func):
    def wrapper(*args, **kwargs):
        # api_key = request.headers.get('X-API-Key')
        # if not api_key:
        #     abort(403)
        # elif api_key != '12345':
        #     abort(403)
        return func(*args, **kwargs)
    return wrapper


class ObjectApi(Resource):
    model_cls = db.Model
    fields = {}
    parser = reqparse.RequestParser()

    @api_key_required
    def get(self, obj_id):
        s = self.model_cls.query.get_or_404(obj_id)
        return marshal(s, self.fields)

    @api_key_required
    def delete(self, obj_id):
        s = self.model_cls.query.get_or_404(obj_id)
        db.session.delete(s)
        db.session.commit()
        return {'success': True}

    @api_key_required
    def put(self, obj_id):
        s = self.model_cls.query.get_or_404(obj_id)
        args = self.parser.parse_args()
        for k, v in args.items():
            s.__setattr__(k, v)
        db.session.merge(s)
        db.session.commit()
        return marshal(s, self.fields)


class ObjectListApi(Resource):
    model_cls = db.Model
    fields = {}
    parser = reqparse.RequestParser()

    @api.doc(params={'p': {
        'description': 'Page number, positive integer number',
        'type': 'int',
    }})
    @api_key_required
    def get(self):
        size, page = 20, int(request.args.get('p', 0))
        res = self.model_cls.query.offset(size * page).limit(size).all()
        return marshal(res, self.fields)

    @api_key_required
    def post(self):
        args = self.parser.parse_args()
        s = self.model_cls(**args)
        db.session.add(s)
        db.session.commit()
        return marshal(s, self.fields)
```

```
from flask_restx import fields, reqparse
from models import db, ObjectApi, ObjectListApi


class Course(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(30), nullable=False)
    name = db.Column(db.String(50), nullable=False)
    # task_set = db.relationship('Task', backref='course', lazy=True)

    def __repr__(self):
        return self.code + ' ' + self.name


fields = {
    'id': fields.Integer,
    'code': fields.String,
    'name': fields.String,
}


parser = reqparse.RequestParser()
parser.add_argument('code', type=str, required=True)
parser.add_argument('name', type=str, required=True)

class CourseApi(ObjectApi):
    model_cls = Course
    fields = fields
    parser = parser


class CourseListApi(ObjectListApi):
    model_cls = Course
    fields = fields
    parser = parser
```
