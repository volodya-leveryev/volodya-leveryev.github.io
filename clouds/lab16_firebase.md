# Firebase

## Теоретическая часть

Современная разработка веб- и мобильных приложений требует эффективных решений для хранения данных, аутентификации пользователей и управления ресурсами. Firebase – это облачная платформа от Google, которая предоставляет широкий набор инструментов для создания и масштабирования приложений без необходимости развертывания собственного сервера.

Firebase – это платформа для бэкенд-разработки, предоставляющая облачные сервисы, которые помогают разработчикам быстро и удобно создавать приложения. Она предлагает готовые решения для хранения данных, аутентификации, хостинга и многого другого, устраняя необходимость в сложной серверной инфраструктуре.

Firebase легко интегрируется с популярными фронтенд-фреймворками, такими как Vue.js, React, Angular, а также используется в мобильной разработке для Android и iOS.

Firebase включает в себя несколько ключевых сервисов, которые помогают разработчикам быстро реализовать функциональность приложения:
1. Firebase Authentication – сервис аутентификации, поддерживающий вход через Email/Password, Google, Facebook, GitHub и другие провайдеры.
2. Cloud Firestore – облачная NoSQL-база данных в реальном времени, обеспечивающая хранение и синхронизацию данных.
3. Realtime Database – альтернатива Firestore, работающая как JSON-хранилище и обновляющая данные мгновенно.
4. Firebase Storage – облачное хранилище файлов (изображения, видео, документы и т. д.).
5. Firebase Hosting – сервис для развертывания статических веб-приложений.
6. Cloud Functions – серверные функции, позволяющие выполнять бэкенд-логику без управления серверами.
7. Firebase Analytics – мощная система аналитики для мониторинга поведения пользователей.

Firebase обладает рядом преимуществ, которые делают его удобным для веб- и мобильных разработчиков:
- Быстрое развертывание – разработчики могут легко подключить базу данных, аутентификацию и хостинг без настройки серверов.
- Реальное время – Firestore и Realtime Database позволяют мгновенно обновлять данные в приложении.
- Кроссплатформенность – Firebase одинаково хорошо подходит для веб-приложений, Android и iOS.
- Масштабируемость – платформа автоматически адаптируется к увеличению нагрузки без сложных настроек.
- Интеграция с Google Cloud – при необходимости можно использовать продвинутые инструменты, такие как BigQuery или машинное обучение.

Использование Firebase значительно упрощает разработку современных приложений, сокращая время на создание серверной инфраструктуры. В рамках данной лабораторной работы мы создадим веб-приложение с Vue.js, которое будет использовать Cloud Firestore для хранения данных.

## Практическая часть

<!-- https://firebase.google.com/codelabs/firestore-web -->

**Шаг 1. Создать проект Firebase**

1. Откройте консоль Firebase ([https://console.firebase.google.com](https://console.firebase.google.com)) и войдите в аккаунт Google.

2. Нажмите "Create a Firebase project". Введите название проекта: `<группа>-<фамилия>`. Используйте настройки по умолчанию и завершите создание проекта.

3. Откройте созданный проект. В разделе `Project Overview`, под заголовком `Get started by adding Firebase to your app` нажмите кнопку `</>` (Web).
    * Введите название приложения (например `My Web App`).
    * Проставьте галочку `Also set up Firebase Hosting for this app`.
    * Остальные параметры оставить без изменения.

4. Настроить аутентификацию.
    * Перейдите в раздел `Authentication` → `Sing-in method`.
    * Включите режим анонимный режим аутентификации.

5. Настроить базу данных.
    * Перейдите в Firestore Database → Создать базу данных.
    * Выберите режим тестирования (позволяет записывать данные без аутентификации).

**Шаг 2. Создать создать сервер**

1. Откройте консоль GCP ([https://console.cloud.google.com](https://console.cloud.google.com)) и войдите в аккаунт Google.

2. Выберите проект `IMI-SVFU`.

3. Перейдите в сервис `Compute Engine` → `Виртуальные машины`.

4. Нажмите `Create instance`.
    * Имя: `<группа>-<фамилия>`.
    * Регион: `europe-north1 (Finland)` либо `europe-north2 (Stockholm)`.
    * Тип инстанса:
        - **Series: E2**
        - **Machine type: e2-small (2 vCPU, 2 GB RAM)**.
    * В разделе **Data protection** выберите **No backups**.
    * Нажмите **Create** и дождитесь создания виртуальной машины.

4. В списке инстансов найдите созданную VM, нажмите **SSH**, чтобы открыть терминал во всплывающем окне браузере.
    * Определите дистрибутив:
        ```sh
        cat /etc/os-release
        ```
    * Откройте инструкцию по установке Node.js: [https://github.com/nodesource/distributions/](https://github.com/nodesource/distributions/)
    * Установите LTS-версию Node.js. Если нужно открыть оболочку с правами root выполните: `sudo -i`.
    * Установите инструменты работы с firebase:
        ```sh
        sudo npm install --global firebase-tools
        ```

**Шаг 3. Создать код приложения**

1. Клонируйте репозиторий с кодом примера:
    ```bash
    sudo apt install git
    git clone https://github.com/firebase/friendlyeats-web
    cd friendlyeats-web/vanilla-js
    ```

2. Установите инструменты работы с Firebase:
    ```bash
    sudo npm install -g firebase-tools
    ```

3. Авторизуйтесь в инструментах (на финальной этапе создайте alias `default`):
    ```bash
    firebase login --no-localhost
    firebase use --add
    ```

4. Внесите изменения в код в файле `scripts/FriendlyEats.Data.js`:

    ```bash
    nano scripts/FriendlyEats.Data.js
    ```

5. Разверните приложение:

    * Разверните приложение:
    ```sh
    firebase deploy
    ```

5. В консоли Firestore, откройте раздел `Hosting`, найдите URL и откройте приложение.

6. Создайте тестовые данные данные и проверьте работу приложения. Проверьте созданные в БД Firestore данные.

## Приложения

```javascript
FriendlyEats.prototype.addRestaurant = function(data) {
  var collection = firebase.firestore().collection('restaurants');
  return collection.add(data);
};
```

```javascript
FriendlyEats.prototype.getAllRestaurants = function(renderer) {
  var query = firebase.firestore()
      .collection('restaurants')
      .orderBy('avgRating', 'desc')
      .limit(50);

  this.getDocumentsInQuery(query, renderer);
};
```

```javascript
FriendlyEats.prototype.getDocumentsInQuery = function(query, renderer) {
  query.onSnapshot(function(snapshot) {
    if (!snapshot.size) return renderer.empty(); // Display "There are no restaurants".

    snapshot.docChanges().forEach(function(change) {
      if (change.type === 'removed') {
        renderer.remove(change.doc);
      } else {
        renderer.display(change.doc);
      }
    });
  });
};
```

```javascript
FriendlyEats.prototype.getRestaurant = function(id) {
  return firebase.firestore().collection('restaurants').doc(id).get();
};
```

```javascript
FriendlyEats.prototype.getFilteredRestaurants = function(filters, renderer) {
  var query = firebase.firestore().collection('restaurants');

  if (filters.category !== 'Any') {
    query = query.where('category', '==', filters.category);
  }

  if (filters.city !== 'Any') {
    query = query.where('city', '==', filters.city);
  }

  if (filters.price !== 'Any') {
    query = query.where('price', '==', filters.price.length);
  }

  if (filters.sort === 'Rating') {
    query = query.orderBy('avgRating', 'desc');
  } else if (filters.sort === 'Reviews') {
    query = query.orderBy('numRatings', 'desc');
  }

  this.getDocumentsInQuery(query, renderer);
};
```

```javascript
FriendlyEats.prototype.addRating = function(restaurantID, rating) {
  var collection = firebase.firestore().collection('restaurants');
  var document = collection.doc(restaurantID);
  var newRatingDocument = document.collection('ratings').doc();

  return firebase.firestore().runTransaction(function(transaction) {
    return transaction.get(document).then(function(doc) {
      var data = doc.data();

      var newAverage =
          (data.numRatings * data.avgRating + rating.rating) /
          (data.numRatings + 1);

      transaction.update(document, {
        numRatings: data.numRatings + 1,
        avgRating: newAverage
      });
      return transaction.set(newRatingDocument, rating);
    });
  });
};
```