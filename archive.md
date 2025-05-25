# IF2240-Tubes-Basis-Data

## ✅ Entities Checklist

* [x] Users
* [x] Stocks
* [x] Stock\_IPO
* [x] Stock\_Daily\_Price
* [x] Live\_Stock\_Price\_Change
* [x] Transactions
* [x] Orders
* [x] Moderators
* [x] Monitoring\_Posts
* [x] Posts
* [x] Post\_Likes
* [x] Post\_Comments
* [x] Comments
* [x] Comment\_Likes
* [x] Comment\_Replies
* [x] Post\_Tags
* [x] Portfolios
* [x] Predictions
* [x] Prediction\_Voting
* [x] Order\_IPO

## 📋 Tables and Attributes

### Users

| Column          | Data Type |
| --------------- | --------- |
| nik             | VARCHAR   |
| nama            | VARCHAR   |
| email           | VARCHAR   |
| telepon         | VARCHAR   |
| password        | VARCHAR   |
| nomor\_rekening | VARCHAR   |
| kyc\_status     | ENUM('verified', 'unverified') NOT NULL|
| saldo           | INT       |

### Stocks

| Column           | Data Type |
| ---------------- | --------- |
| ticker           | VARCHAR   |
| nama\_perusahaan | VARCHAR   |
| sektor           | VARCHAR   |
| profil           | TEXT      |
| tipe             | VARCHAR   |

### Stock\_IPO

| Column           | Data Type |
| ---------------- | --------- |
| ticker           | VARCHAR   |
| harga\_penawaran | INT       |
| status\_ipo      | ENUM ('open', 'closed') |
| tanggal\_ipo     | DATE      |

### Stock\_Daily\_Price

| Column  | Data Type |
| ------- | --------- |
| ticker  | VARCHAR   |
| date    | DATE      |
| open    | DOUBLE    |
| close   | DOUBLE    |
| highest | DOUBLE    |
| lowest  | DOUBLE    |

### Live\_Stock\_Price\_Change

| Column    | Data Type |
| --------- | --------- |
| ticker    | VARCHAR   |
| price     | DOUBLE    |
| timestamp | DATETIME  |

### Transactions

| Column          | Data Type |
| --------------- | --------- |
| transaction\_id | INT       |
| order\_id       | INT       |
| jumlah          | INT       |
| waktu\_eksekusi | DATETIME  |

### Orders

| Column         | Data Type |
| -------------- | --------- |
| order\_id      | INT       |
| nik            | VARCHAR   |
| ticker         | VARCHAR   |
| tipe\_order    | ENUM      |
| harga          | INT       |
| jumlah\_lembar | INT       |
| status         | ENUM('pending','partial','executed') |

### Moderators

| Column   | Data Type |
| -------- | --------- |
| username | VARCHAR   |
| password | VARCHAR   |

### Monitoring\_Posts

| Column           | Data Type |
| ---------------- | --------- |
| username         | VARCHAR   |
| post\_id         | INT       |
| approval\_status | ENUM      |
| timestamp        | DATETIME  |

### Posts

| Column    | Data Type |
| --------- | --------- |
| post\_id  | INT       |
| nik       | VARCHAR   |
| isi       | TEXT      |
| timestamp | DATETIME  |

### Post\_Likes

| Column    | Data Type |
| --------- | --------- |
| nik       | VARCHAR   |
| post\_id  | INT       |
| timestamp | DATETIME  |

### Post\_Comments

| Column      | Data Type |
| ----------- | --------- |
| comment\_id | INT       |
| post\_id    | INT       |

### Comments

| Column      | Data Type |
| ----------- | --------- |
| comment\_id | INT       |
| nik         | VARCHAR   |
| isi         | TEXT      |
| timestamp   | DATETIME  |

### Comment\_Likes

| Column      | Data Type |
| ----------- | --------- |
| nik         | VARCHAR   |
| comment\_id | INT       |
| timestamp   | DATETIME  |

### Comment\_Replies

| Column            | Data Type |
| ----------------- | --------- |
| comment\_id\_from | INT       |
| comment\_id\_to   | INT       |
| timestamp         | DATETIME  |

### Post\_Tags

| Column   | Data Type |
| -------- | --------- |
| post\_id | INT       |
| ticker   | VARCHAR   |

### Portfolios

| Column         | Data Type |
| -------------- | --------- |
| nik            | VARCHAR   |
| ticker         | VARCHAR   |
| jumlah\_lembar | INT       |
| average\_cost  | DOUBLE    |

### Predictions

| Column   | Data Type |
| -------- | --------- |
| post\_id | INT       |
| ticker   | VARCHAR   |
| price    | INT       |
| duration | INT       |

### Prediction\_Voting

| Column   | Data Type |
| -------- | --------- |
| nik      | VARCHAR   |
| post\_id | INT       |
| tipe     | ENUM('yes','no')      |
