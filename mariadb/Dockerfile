FROM mariadb:latest

# Copy the SQL script from /sql to Docker's entrypoint
ADD sql/ /docker-entrypoint-initdb.d

ENV MYSQL_ROOT_PASSWORD testpw
ENV MYSQL_DATABASE testDB
ENV MYSQL_USER testusr
ENV MYSQL_PASSWORD test

EXPOSE 3306

CMD ["mysqld"]

