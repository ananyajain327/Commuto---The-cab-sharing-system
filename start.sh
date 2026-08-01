#!/bin/bash
set -e

# --- Database configuration (from environment; password auto-generated when not set) ---
: "${DB_USER:=app}"
: "${DB_NAME:=commuto}"
: "${DB_PASSWORD:=$(openssl rand -hex 16)}"
export DB_USER DB_NAME DB_PASSWORD

# Ensure MySQL data directory exists
mkdir -p /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql

# Start MariaDB
service mariadb start || service mysql start

# Wait for MariaDB to be ready
for i in $(seq 1 30); do
    if mysqladmin ping --silent; then break; fi
    sleep 1
done

# Create the app database and a dedicated app user (idempotent + re-synced on restart)
mysql -uroot <<SQL
CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
ALTER USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
SQL

# Seed the schema (idempotent)
mysql -uroot "$DB_NAME" < /init.sql

# Start Tomcat (foreground)
exec catalina.sh run
