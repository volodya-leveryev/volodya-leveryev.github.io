# Apache Pig

Apache Pig Latin — язык обработки данных. Все данные 
 
Режимы работы:
* MapReduce - режим по умолчанию
* Local
* Tez
* Spark
* ...
 
Режимы запуска кода:
* Интерактивный
* Пакетный (запуск скрипта)
 
Работа с файловой системой:

```
fs ...
```
 
[Данные](https://www.kaggle.com/rounakbanik/the-movies-dataset?select=ratings.csv)

```bash 
curl -o "leverev.zip" "<URL>"
 
hadoop fs -mkdir /leverev
hadoop fs -put *.csv /leverev/
 
pig
```
 
Смена текущего каталога:

```bash
cd /leverev
```
 
Как читать CSV с учетом всех особенностей формата:

```
REGISTER '/home/sshuser/piggybank.jar';
 ```

Чтение данных:
```
links_small = LOAD 'links_small.csv' USING org.apache.pig.piggybank.storage.CSVLoader() AS (movieId:int, imdbId:int, tmbldId:int);
```

Чтение данных:
```
movies_metadata = LOAD 'movies_metadata.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'UNIX', 'SKIP_INPUT_HEADER') AS (adult:boolean, belongs_to_collection: chararray, budget:int, genres: chararray, homepage: chararray, id: int, imdb_id: chararray, original_language: chararray, original_title: chararray, overview: chararray);
```

Отфильтруем в новую переменную фильмы с определенным жанром:
```
comedy = FILTER movies_metadata BY (genres MATCHES '.*\'Comedy\'.*');
```

Сохранение результата в файл:
```
STORE comedy INTO '/leverev1' USING org.apache.pig.piggybank.storage.CSVExcelStorage();
```

Написать скрипт на Apache Pig для получения списка драматических фильмов из 'movies_metadata.csv'
 
Отображение данных на экране:
```
DUMP A;
```

Отображение структуры данных:
```
DESCRIBE A;
```

Выборка первых 10 строк:
```
B = LIMIT A 10;
DUMP B;
```

Как подсчитать количество строк в файле?
```
all_rows = LOAD 'links_small.csv' USING PigStorage(',') AS (movieId:int, imdbId:int, tmbldId:int);
data_rows = FILTER all_rows BY $0 > 0;
result = FOREACH (GROUP data_rows ALL) GENERATE COUNT(data_rows);
DUMP result;
```

Как найти 10 фильмов с наибольшим суммарным рейтингом?

```
all_rows = LOAD 'ratings.csv' USING PigStorage(',') AS (userId:int, movieId:int, rating:float, timestamp:int);
data_rows = FILTER all_rows BY $0 > 0;
groups = GROUP data_rows BY movieId;
result = FOREACH groups GENERATE group AS movie, SUM(data_rows.rating) AS sum_rating;
sorted = ORDER result BY sum_rating DESC;
best = LIMIT sorted 10;
DUMP best;
```
 
Как сохранить данные из 'ratings.csv' в три разных файла

```
[0,2)
[2,4)
[4,5]
```

```
all_rows = LOAD '/pig/ratings.csv' USING PigStorage(',') AS (userId:int, movieId:int, rating:float, timestamp:int);
data_rows = FILTER all_rows BY $0 > 0;
cat1 = FILTER data_rows BY rating < 2;
cat2 = FILTER data_rows BY rating >= 2 and rating < 4;
cat3 = FILTER data_rows BY rating >= 4;
STORE cat1 INTO '/leveryev1' USING PigStorage(',');
STORE cat2 INTO '/leveryev2' USING PigStorage(',');
STORE cat3 INTO '/leveryev3' USING PigStorage(',');
```

[Документация Apache Pig](http://pig.apache.org/docs/latest/basic.html#store)
