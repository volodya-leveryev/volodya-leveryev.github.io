# Введение

## Постановка проблемы

С чего все началось: Google нужно было индексировать данные для поиска по веб-страницам.

Что такое большие данные?

* данные не помещаются в ОЗУ одного компьютера
* данные собираются быстрее чем один компьютер успевает их обрабатывать

Особенности больших данных:

* конечный результат слабо зависит от одного элемента данных
* нерегулярная структура данных

Решение проблемы: распараллелить обработку данных на N компьютеров, объединенных в кластер.

Основные сложности, которые возникают при работе большими данными и пути их решения:

* Хранение данных перед обработкой

  - Файлы — неудобно хранить метаданные, возможны проблемы с надежностью хранения, возможны проблемы со скоростью доступа
  - Реляционные СУБД ([принципы ACID](https://ru.wikipedia.org/wiki/ACID)) — записывают данные медленнее чем неряционные СУБД, масштабируются хуже чем нереляционные СУБД
  - Нереляционные СУБД ([принципы BASE](https://ru.wikipedia.org/wiki/%D0%A2%D0%B5%D0%BE%D1%80%D0%B5%D0%BC%D0%B0_CAP)) — возможны проблемы с согласованностью данных

* Обработка данных

  - обработка данных с помощью функций типа Map и Reduce
  - системы построенные поверх MapReduce (например реализуют SQL-подобные запросы к данным)
  - обработка данных с помощью функций типа ETL (Extract, Transform, Load) 

## Apache Hadoop

Hadoop — первая платформа для работы с большими данными.

Кластеры Hadoop строятся на недорогом аппаратном обеспечении (Commodity Hardware). Кластер Hadoop готов к выходу из строя небольшого количества вычислительных узлов.

Hadoop был создан в Google, а затем передан для дальнейшего развития сообществом в фонд Apache.

Для хранения данных Hadoop использует  HDFS — Hadoop Distributed File System. Один элемент данных в HDFS дублируется на нескольких узлах, поэтому кластер готов к отказам оборудования.

Основные языки программирования:

* Java — предоставляет простую модель для параллельного программирования
* Scala — функциональный язык программирования работающий поверх JVM
* Python — универсальный "клей" — скриптовый язык высокого уровня, который хорошо интегрируется с компонентами, написанными другими на других языках программирования

Для обработки данных применяется MapReduce — модель вычислений состоящая из двух этапов:

* Map — отображение — это функция которая для каждого элемента из большого набора данных вычисляет результат
* Reduce — сведение — это функция, которая объединяет два результата в один

Основные языки программирования:

* Java — предоставляет простую модель для параллельного программирования
* Scala — функциональный язык программирования работающий поверх JVM
* Python — универсальный "клей" — скриптовый язык высокого уровня, который хорошо интегрируется с компонентами, написанными другими на других языках программирования

## Развитие Hadoop

В процессе развития платформы Hadoop было создано большое количество высокоуровневых средств образующих своего рода экосистему:

* [Apache Hive](https://hive.apache.org/) — средство выполнения SQL-подобных запросов к данным
* [Cloudera Impala](https://www.cloudera.com/products/open-source/apache-hadoop/impala.html) — средство выполнения SQL-подобных запросов к данным
* [Apache Pig](https://pig.apache.org/) — высокоуровневый скриптовый язык для обработки данных
* [Apache Mahout](https://mahout.apache.org/) — Machine Learning поверх MapReduce
* [Apache Sqoop](https://sqoop.apache.org/) — импорт-экспорт данных из / в базы данных
* [Apache Kafka](https://kafka.apache.org/) — потоковая обработка данных
* [Apache Flume](https://flume.apache.org/) — средство для сбора и обработки логов
* [Apache Zookeeper](https://zookeeper.apache.org/) — средство координации работы узлов
* [Apache Oozie](https://oozie.apache.org/) — этапы заданий (workflow) и очередь заданий (schedule)
* [Apache Ambari](https://ambari.apache.org/) — веб-интерфейс для управления и мониторинга
* [Cloudera Hue](https://www.cloudera.com/products/open-source/apache-hadoop/hue.html) — веб-интерфейс для работы с Hadoop
* [Apache HBase](https://hbase.apache.org/) — средство доступа к данным в виде widecolumn NoSQL БД
* и другие

[Apache Spark](https://spark.apache.org/) — платформа вычислений, которая работает в кластере Hadoop и ускоряет вычисления MapReduce благодаря тому, что хранит данные промежуточных результатов вычислений в ОЗУ узлов, а не в HDFS.

Платформа Spark также может работать в контейнерах под управлением [Kubernetes](https://kubernetes.io/) и на кластерах [Apache Mesos](http://mesos.apache.org/). Кроме того, Spark может управлять кластером самостоятельно.

На базе Spark работают несколько высокоуровневых программных средств:

* [Spark SQL](https://spark.apache.org/sql/) — средство выполнения SQL-подобных запросов к данным
* [Spark Streaming](https://spark.apache.org/streaming/) — средство потоковой обработки данных
* [MLlib](https://spark.apache.org/mllib/) — средство для машинного обучения
* [GraphX](https://spark.apache.org/graphx/) — средство для вычислений на графах

## Современные тренды

Современные тренды:

* развертывание компонентов Hadoop в Kubernetes
* хранение и обработка больших данные в облачных сервисах

Облачные решения:

* AWS
  - [AWS Redshift](https://aws.amazon.com/redshift/) — хранилище данных
  - [AWS Athena](https://aws.amazon.com/athena/) — SQL запросы к данным в AWS S3
  - [AWS Elastic MapReduce (EMR)](https://aws.amazon.com/emr/) — Apache Spark / Hadoop
  - [AWS Kinesis](https://aws.amazon.com/kinesis/) — потоковая обработка данных
* Microsoft Azure
  - [Microsoft Azure Storage](https://azure.microsoft.com/en-us/services/storage/) — хранилище данных
  - [Microsoft Azure HDInsight](https://azure.microsoft.com/en-us/services/hdinsight/) — Apache Spark / Hadoop
  - [Microsoft Azure Event Hub](https://azure.microsoft.com/en-us/services/event-hubs/) — потоковая обработка данных
* Google Cloud Platform
  - [Google Cloud BigQuery](https://cloud.google.com/bigquery) — хранилище данных
  - [Google Cloud Dataproc](https://cloud.google.com/dataproc) — Apache Spark / Hadoop
  - [Google Cloud Dataflow](https://cloud.google.com/dataflow) — потоковая обработка данных 
* IBM
* Ali Baba
* Yandex
* другие

## ElasticStack

Компоненты:

* [ElasticSearch](https://ru.wikipedia.org/wiki/Elasticsearch) — распределенная поисковая система
* Logstash — система сбора и обработки логов
* [Kibana](https://ru.wikipedia.org/wiki/Kibana) — платформа аналитики и визуализации
* Beats — коллекция легковесных средств экспорта данных

Часть программных компонентов имеет открытый исходный код.

На базе ElasticStack создано большое количество производных продуктов.

В настоящий момент активно развиваются облачные сервисы на базе продуктов ElasticStack.
