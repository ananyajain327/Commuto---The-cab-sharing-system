<div align="center">

<img src="https://raw.githubusercontent.com/ananyajain327/Commuto---The-cab-sharing-system/main/Commuto/web/assets/images/logo.jpg" alt="Commuto Logo" width="120"/>

# 🚕 Commuto — Smart Cab Sharing System

**Ride Together, Save Together** — a web-based cab sharing & ride booking platform for smart, affordable and efficient transportation.

[![Java](https://img.shields.io/badge/Java-17-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.java.com/)
[![JSP](https://img.shields.io/badge/JSP-Servlets-007396?style=for-the-badge&logo=java&logoColor=white)]()
[![MySQL](https://img.shields.io/badge/MySQL-8-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![GlassFish](https://img.shields.io/badge/GlassFish-Server-007396?style=for-the-badge&logo=java&logoColor=white)]()
[![NetBeans](https://img.shields.io/badge/NetBeans-IDE-1B6AC6?style=for-the-badge&logo=apachenetbeanside&logoColor=white)](https://netbeans.apache.org/)

[![Stars](https://img.shields.io/github/stars/ananyajain327/Commuto---The-cab-sharing-system?style=for-the-badge&logo=github&color=yellow)](https://github.com/ananyajain327/Commuto---The-cab-sharing-system)
[![Forks](https://img.shields.io/github/forks/ananyajain327/Commuto---The-cab-sharing-system?style=for-the-badge&logo=github&color=blue)](https://github.com/ananyajain327/Commuto---The-cab-sharing-system/forks)
[![Open Issues](https://img.shields.io/github/issues/ananyajain327/Commuto---The-cab-sharing-system?style=for-the-badge&logo=github&color=red)](https://github.com/ananyajain327/Commuto---The-cab-sharing-system/issues)
[![License](https://img.shields.io/github/license/ananyajain327/Commuto---The-cab-sharing-system?style=for-the-badge&color=green)](./LICENSE)

[![Last Commit](https://img.shields.io/github/last-commit/ananyajain327/Commuto---The-cab-sharing-system?style=for-the-badge&color=purple)](https://github.com/ananyajain327/Commuto---The-cab-sharing-system/commits/main)
[![Repo Size](https://img.shields.io/github/repo-size/ananyajain327/Commuto---The-cab-sharing-system?style=for-the-badge&color=orange)]()
[![Top Language](https://img.shields.io/github/languages/top/ananyajain327/Commuto---The-cab-sharing-system?style=for-the-badge&color=brightgreen)]()

</div>

---

## 📖 About the Project

**Commuto** is a full-stack web application that connects **drivers** and **passengers** on a single ride-sharing platform. Drivers can post their trips with available seats and fares, while passengers can search, compare and book rides instantly. Built as a college major project, it demonstrates a clean **Model-View-Controller (MVC)** architecture with Java, JSP, Servlets and MySQL.

> 🎯 **Project Objective:** Provide a smart, affordable and efficient ride-sharing platform for daily commuters.

---

## ✨ Features

### 👤 User Management
- ✅ Secure user **registration** & **login**
- 👨‍✈️ Separate **Driver** & **Passenger** roles
- 📞 Profile with name, email, phone & role

### 🚗 Ride Management
- ➕ Post a ride with source, destination, date, time, seats & fare
- 🔍 Search rides by **source** & **destination**
- 📋 Browse all **available rides**
- 📊 Live **available seats** & fare per person

### 📅 Booking System
- 🎫 Book seats on any available ride
- ✅ **Accept / Reject** ride requests as a driver
- 📜 Full **booking history** & fare split per passenger
- 🧾 Dedicated dashboards for both roles

### 🗄️ Database & Architecture
- 🧱 Clean **MVC** layering — `controller` → `dao` → `model`
- 🔒 Prepared statements to prevent **SQL Injection**
- 📈 MySQL relational schema with foreign keys

---

## 🛠️ Tech Stack

| Layer      | Technology                                       |
|------------|--------------------------------------------------|
| Frontend   | HTML5, CSS3, JSP                                  |
| Backend    | Java (JDK 8+), Servlet API 3.1                    |
| Database   | MySQL 8.x                                         |
| Server     | GlassFish 5.x / Apache Tomcat                     |
| Build Tool | Apache Ant (NetBeans)                             |
| IDE        | Apache NetBeans                                   |
| Connector  | `mysql-connector-j` 9.7.0                         |

---

## 🚀 Getting Started

### ✅ Prerequisites
- [JDK 8 or higher](https://www.oracle.com/java/technologies/downloads/)
- [Apache NetBeans IDE](https://netbeans.apache.org/download/index.html)
- [GlassFish 5+](https://glassfish.org/) or Apache Tomcat
- [MySQL Server 8.x](https://dev.mysql.com/downloads/mysql/) + MySQL Workbench

### 📦 Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/ananyajain327/Commuto---The-cab-sharing-system.git
   cd Commuto---The-cab-sharing-system/Commuto
   ```

2. **Create the database** — open MySQL Workbench and run:
   ```sql
   CREATE DATABASE commuto;
   USE commuto;

   CREATE TABLE users (
       user_id    INT AUTO_INCREMENT PRIMARY KEY,
       full_name  VARCHAR(100) NOT NULL,
       email      VARCHAR(100) NOT NULL UNIQUE,
       password   VARCHAR(100) NOT NULL,
       phone      VARCHAR(20),
       role       VARCHAR(20) NOT NULL
   );

   CREATE TABLE rides (
       ride_id         INT AUTO_INCREMENT PRIMARY KEY,
       driver_id       INT NOT NULL,
       source          VARCHAR(100) NOT NULL,
       destination     VARCHAR(100) NOT NULL,
       ride_date       DATE NOT NULL,
       ride_time       TIME NOT NULL,
       total_seats     INT NOT NULL,
       available_seats INT NOT NULL,
       total_fare      DOUBLE NOT NULL,
       vehicle_number  VARCHAR(20),
       source_lat      DOUBLE,
       source_lng      DOUBLE,
       status          VARCHAR(20) DEFAULT 'ACTIVE',
       FOREIGN KEY (driver_id) REFERENCES users(user_id)
   );

   CREATE TABLE bookings (
       booking_id     INT AUTO_INCREMENT PRIMARY KEY,
       ride_id        INT NOT NULL,
       passenger_id   INT NOT NULL,
       seats_booked   INT NOT NULL,
       fare_per_person DOUBLE NOT NULL,
       booking_status VARCHAR(20),
       FOREIGN KEY (ride_id)      REFERENCES rides(ride_id),
       FOREIGN KEY (passenger_id) REFERENCES users(user_id)
   );
   ```

3. **Configure DB credentials** — edit `src/java/dao/DBConnection.java` and set your local username/password (or export `DB_USER` / `DB_PASSWORD` environment variables).

4. **Run the project**
   - Open the `Commuto` folder in NetBeans
   - Clean & Build (**Shift+F11**)
   - Deploy to GlassFish and press **▶ Run**
   - Visit 👉 `http://localhost:8080/Commuto/`

---

## 🗄️ Database Schema

```
┌────────────┐      ┌────────────┐      ┌────────────┐
│   users    │      │   rides    │      │  bookings  │
├────────────┤      ├────────────┤      ├────────────┤
│ user_id  PK│◄────►│ driver_id FK│◄────►│ ride_id   FK│
│ full_name  │      │ source      │      │ passenger_id FK
│ email      │      │ destination │      │ seats_booked│
│ password   │      │ ride_date   │      │ fare_per_person
│ phone      │      │ ride_time   │      │ booking_status
│ role       │      │ total_seats │      └────────────┘
└────────────┘      │ available_seats
                    │ total_fare
                    │ status
                    └────────────┘
```

---

## 📁 Project Structure

```
Commuto/
├── src/
│   ├── java/
│   │   ├── controller/        # Servlets (Login, Register, Ride, Booking...)
│   │   │   ├── LoginServlet.java
│   │   │   ├── RegisterServlet.java
│   │   │   ├── AddRideServlet.java
│   │   │   ├── SearchRideServlet.java
│   │   │   ├── BookRideServlet.java
│   │   │   ├── RideRequestServlet.java
│   │   │   ├── AcceptRideServlet.java
│   │   │   ├── RejectRideServlet.java
│   │   │   └── ...
│   │   ├── dao/               # Database access layer
│   │   │   ├── DBConnection.java
│   │   │   ├── UserDAO.java
│   │   │   ├── RideDAO.java
│   │   │   └── BookingDAO.java
│   │   └── model/             # POJOs (User, Ride, Booking)
│   └── conf/
├── web/                       # JSP views + static assets
│   ├── index.jsp
│   ├── login.jsp
│   ├── register.jsp
│   ├── addRide.jsp
│   ├── searchRide.jsp
│   ├── availableRides.jsp
│   ├── driverDashboard.jsp
│   ├── passengerDashboard.jsp
│   ├── bookingHistory.jsp
│   ├── rideRequests.jsp
│   ├── myBookings.jsp
│   ├── profile.jsp
│   ├── navbar.jsp
│   ├── footer.jsp
│   └── assets/
│       ├── css/
│       └── images/
├── nbproject/                 # NetBeans project files
├── build.xml                  # Ant build script
└── dist/                      # Build output (WAR)
```

---

## 📸 Screenshots

> 📝 *Screenshots coming soon — add your app screenshots in the `assets/images` folder and update this section.*

---

## 🗺️ Roadmap

- [x] User registration & login
- [x] Ride posting & search
- [x] Ride booking & fare split
- [x] Driver request approval flow
- [ ] Live location tracking
- [ ] Fare estimation API
- [ ] Payment gateway integration
- [ ] Ride reviews & ratings

---

## 🤝 Contributing

Contributions, issues and feature requests are welcome!
Feel free to check the [issues page](https://github.com/ananyajain327/Commuto---The-cab-sharing-system/issues) and open a PR.

Please read the [Contributing Guidelines](./CONTRIBUTING.md) first.

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](./LICENSE) file for details.

---

## 👤 Author

**Ananya Jain**
- 🔗 [LinkedIn](https://www.linkedin.com/in/ananya-jain327)
- 🐙 [GitHub](https://github.com/ananyajain327)

---

<div align="center">

⭐ **If you find this project helpful, give it a star!** ⭐

</div>
