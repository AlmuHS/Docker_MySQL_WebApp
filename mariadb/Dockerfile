FROM mariadb:latest

# Set the working directory to /sql
WORKDIR /sql
# Copy the current directory contents into the container at /sql
COPY . /sql

ENV MYSQL_ROOT_PASSWORD testpw
ENV MYSQL_DATABASE testDB
ENV MYSQL_USER testusr
ENV MYSQL_PASSWORD ttest

RUN apt-get update && apt-get -y install nano

EXPOSE 3306

CMD ["mysqld"]

