import json
from redis import Redis
from flask import Flask, render_template
from jinja2 import Template

app = Flask(__name__, template_folder='.')
r = redis.Redis()


@app.route('/')
def hello_world():
    return render_template("index.html", username="Вова")


@app.route('/<int:season>/')
def game_of_thrones(season):
	return r.get(season)


with open('season.html') as t:
	template = Template(t.read())
	for season in range(1, 8):
		with open('season%d.json' % season) as f:
			data = json.load(f)
			result = template.render(data=data)
			r.set(season, result)

app.run()
