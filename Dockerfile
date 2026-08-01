# ---------- Build stage: compile the Java sources into a WAR ----------
FROM eclipse-temurin:8-jdk AS build

WORKDIR /app

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl \
 && rm -rf /var/lib/apt/lists/*

# Download compile/runtime dependencies
RUN curl -fsSL -o servlet-api.jar https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar \
 && curl -fsSL -o mysql-connector.jar https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.7.0/mysql-connector-j-9.7.0.jar

# Copy application sources
COPY Commuto/src/java src/java
COPY Commuto/web web

# Compile + package WAR
RUN mkdir -p web/WEB-INF/classes web/WEB-INF/lib \
 && javac -encoding UTF-8 -cp servlet-api.jar -d web/WEB-INF/classes $(find src/java -name "*.java") \
 && cp mysql-connector.jar web/WEB-INF/lib/ \
 && cd web && jar -cf /app/commuto.war .

# ---------- Runtime stage: Tomcat + MariaDB in a single container ----------
FROM tomcat:9

RUN apt-get update \
 && apt-get install -y --no-install-recommends mariadb-server mariadb-client openssl \
 && rm -rf /var/lib/apt/lists/*

COPY --from=build /app/commuto.war /usr/local/tomcat/webapps/ROOT.war
COPY database.sql /init.sql
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# App database configuration. DB_PASSWORD has no committed default:
# it is auto-generated at container start unless DB_PASSWORD is set.
# When overriding DB_NAME, also update DB_URL accordingly.
ENV DB_USER=app \
    DB_NAME=commuto \
    DB_URL="jdbc:mysql://127.0.0.1:3306/commuto?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"

EXPOSE 8080

CMD ["/usr/local/bin/start.sh"]
