# SQL Server
## Ход работы
1. Подключиться к серверу
2. Скачать дистрибутив SQL Server по [ссылке](https://leveryev.s3.ap-northeast-2.amazonaws.com/SQLServer2019-x64-ENU.iso)
3. Запустить установку
   * Выбрать редакцию (Evalution)
   * Feature Selection (Database Engine)
   * Instance Configuration (Default Instance)
   * Server Configuration, Collation (Cyrillic Case Sensitive)
   * Database Engine Configuration, Server configuration (Mixed Mode, задать пароль для SA, добавить текущего администратора Windows Server)
   * Database Engine Configuration, Data Directories (**сделать скриншот**)
4. Установить SQL Server Management Studio
   * Скачать Management Studio
   * Запустить Management Studio
   * Подключиться к серверу
   * Развернуть список существующих баз данных, открыть свойства базы MASTER и **сделать скриншот**
   * Развернуть список логинов, открыть свойства SA и **сделать скриншот**
5. Создать план поддержки
   * запустить SQL Server Agent
   * запустить мастер Maintenance Plan Wizard
   * выбрать вариант с одним расписанием для всех действий
   * выбрать действия по резервному копированию БД (full), перестройке индексов и обновлению статистики
   * для каждого действия выберите запуск для всех баз данных
   * **сделать скриншот диаграммы**
