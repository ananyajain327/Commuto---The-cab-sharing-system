CREATE DATABASE IF NOT EXISTS commuto;
USE commuto;

CREATE TABLE IF NOT EXISTS users (
    user_id    INT AUTO_INCREMENT PRIMARY KEY,
    full_name  VARCHAR(100) NOT NULL,
    email      VARCHAR(100) NOT NULL UNIQUE,
    password   VARCHAR(100) NOT NULL,
    phone      VARCHAR(20),
    role       VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS rides (
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

CREATE TABLE IF NOT EXISTS bookings (
    booking_id     INT AUTO_INCREMENT PRIMARY KEY,
    ride_id        INT NOT NULL,
    passenger_id   INT NOT NULL,
    seats_booked   INT NOT NULL,
    fare_per_person DOUBLE NOT NULL,
    booking_status VARCHAR(20),
    FOREIGN KEY (ride_id)      REFERENCES rides(ride_id),
    FOREIGN KEY (passenger_id) REFERENCES users(user_id)
);
