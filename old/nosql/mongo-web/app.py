from flask import Flask, render_template, request, redirect
from pymongo import MongoClient
from bson.objectid import ObjectId

app = Flask(__name__, template_folder='')


def get_user_data():
    return {
        "last_name": request.form['last_name'],
        "first_name": request.form['first_name'],
    }


@app.route('/')
def users_list():
    return render_template('list.html', users=users.find())


@app.route('/create/', methods=['GET', 'POST'])
def user_create():
    if request.method == 'POST':
        users.insert_one(get_user_data())
        return redirect('/')
    return render_template('edit.html')


@app.route('/update/<pk>/', methods=['GET', 'POST'])
def user_update(pk):
    if request.method == 'POST':
        users.update_one({"_id": ObjectId(pk)}, {"$set": get_user_data()})
        return redirect('/')
    user = users.find_one({"_id": ObjectId(pk)})
    return render_template('edit.html', user=user)


@app.route('/delete/<pk>/', methods=['GET', 'POST'])
def user_delete(pk):
    if request.method == 'POST':
        users.delete_one({"_id": ObjectId(pk)})
        return redirect('/')
    return render_template('remove.html', user=users.find_one({"_id": ObjectId(pk)}))


MONGO_HOST = '127.0.0.1'
MONGO_PORT = 27017
MONGO_DATABASE = 'mongo-web-example'

client = MongoClient(host=MONGO_HOST, port=MONGO_PORT)
db = client.get_database(MONGO_DATABASE)
users = db.get_collection('users')
app.run(debug=True)
