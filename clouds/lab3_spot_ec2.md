**Лаб. работа 3: Спотовые инстансы EC2**

### **Цель работы:**
Ознакомиться с расчетом стоимости инстансов AWS, созданием спотовых инстансов, настройкой доменного имени, установкой Docker и HAProxy, развертыванием Redmine и настройкой TLS-сертификатов.

---

### **Шаг 1: Сравнение стоимости аренды сервера t3.small**
1. Откройте [AWS Pricing Calculator](https://calculator.aws/).
2. Рассчитайте стоимость месячной аренды EC2-инстанса **t3.small** в следующих режимах (в произвольно выбранном регионе):
   - **Compute Savings Plans (1 год, без предоплаты)**
   - **EC2 Instance Savings Plans (1 год, без предоплаты)**
   - **On-demand** (по требованию)
   - **Spot instances** (спотовые инстансы) при среднем проценте скидки
3. Сравните разницу в стоимости между этими вариантами.

---

### **Шаг 2: Вход в веб-консоль AWS через IAM-аккаунт**
1. Перейдите на [AWS Management Console](https://aws.amazon.com/console/).
2. Введите учетные данные IAM-пользователя (логин и пароль).

---

### **Шаг 3: Создание запроса на спотовый инстанс t3.small**
1. Откройте **EC2** → **Instances** → **Spot Requests**.
2. Создайте новый запрос:
   - AMI **Amazon Linux 2**.
   - Key pair name: (optional)
   - Advanced launch parameters → Tags: Name, <Фамилия>, Instances, Fleet
   - vCPUs: minimum 2, maximum 4
   - Memory: minimum 2, maximum 4
   - Capacity optimized
3. Дождитесь создания инстанса и запомните его IP-адрес.

---

### **Шаг 4: Создание доменного имени в Hosted Zone**
1. Откройте **Route 53**.
2. Перейдите в **Hosted Zones** и выберите готовую зону.
3. Создайте A-запись для доменного имени, указывая IP-адрес полученного сервера.

---

### **Шаг 5: Подключение к инстансу через EC2 Instance Connect**
1. Перейдите в **EC2** → **Instances**.
2. Выберите созданный инстанс и нажмите **Connect**.
3. Используйте **EC2 Instance Connect** для доступа в терминал сервера.

---

### **Шаг 6: Установка Docker, Certbot и HAProxy**
1. Обновите систему:
   ```sh
   sudo yum update -y
   ```
2. Установите Docker:
   ```sh
   sudo amazon-linux-extras install -y docker
   sudo systemctl start docker
   sudo systemctl enable docker
   sudo usermod -a -G docker ec2-user
   newgrp docker
   ```
3. Установите Certbot:
   ```sh
   sudo amazon-linux-extras install -y epel
   sudo yum install -y certbot
   ```
4. Установите HAProxy:
   ```sh
   sudo yum install -y haproxy
   sudo systemctl enable haproxy
   ```

---

### **Шаг 7: Запуск Redmine в Docker на порту 8080**
1. Запустите контейнер Redmine:
   ```sh
   docker run -d --name redmine -p 8080:3000 redmine
   ```
2. Проверьте работу в браузере по адресу `http://<IP-адрес>:8080`.

---

### **Шаг 8: Получение TLS-сертификата через Certbot**
1. Запустите команду для получения сертификата (замените `<DNS-имя сервера>` на ваш домен):
   ```sh
   sudo certbot certonly --standalone -d <DNS-имя сервера> --email <email-адрес> --agree-tos --non-interactive
   ```
2. Объедините полученный сертификат с ключом
   ```sh
   sudo cat /etc/letsencrypt/live/<DNS-имя сервера>/cert.pem \
       /etc/letsencrypt/live/<DNS-имя сервера>/privkey.pem \
       | sudo tee /etc/haproxy/cert_key.pem > /dev/null
   ```

---

### **Шаг 9: Настройка HAProxy с TLS и проксирование к Docker-контейнеру**
1. Откройте конфигурацию HAProxy:
   ```sh
   sudo nano /etc/haproxy/haproxy.cfg
   ```
2. Закомментируйте разделы `frontend` и `backend`
3. Добавьте следующую конфигурацию:
   ```txt
   frontend http_front
       bind *:80
       redirect scheme https unless { ssl_fc }

   frontend https_front
       bind *:443 ssl crt /etc/haproxy/cert_key.pem
       default_backend site_back

   backend site_back
       server wordpress 127.0.0.1:8080 check
   ```
4. Проверьте конфигурацию HAProxy:
   ```sh
   sudo haproxy -f /etc/haproxy/haproxy.cfg -c
   ```
5. Запустите HAProxy:
   ```sh
   sudo systemctl start haproxy
   ```

---

### **Шаг 10: Проверка работы WordPress через HAProxy**
1. Откройте браузер и введите `https://<DNS-имя сервера>`.
2. Убедитесь, что сайт доступен по HTTPS и корректно проксируется через HAProxy.


### **Шаг 11: Отмените запрос спотовых инстансов EC2**
1. Откройте **EC2** → **Instances** → **Spot Requests**.
2. Выделите свой запрос и отмените его **Actions** → **Cancel Request**.
