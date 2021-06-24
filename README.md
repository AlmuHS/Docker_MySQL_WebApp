# Tarea: Contenedores como Servicio

## Enunciado

Crea una pequeña aplicación web, usando un tecnología a tu elección, que se conecte a un almacenamiento redis o a una base de datos SQL o noSQL.

Crea un Dockerfile para generar la imagen y súbela al Docker Hub.

Crea un fichero docker-compose.yml que al menos lance dos servicios: la aplicación y la base de datos, y un volumen para que los datos persistan.

Sube la aplicación, el dockerfile y el docker-compose a un repositorio Github, y publícalo en esta tarea.

## 1. Creación de la aplicación web

Para la aplicación web, hemos utilizado flask. La aplicación web se conecta a una base de datos MySQL.

Para esto, hemos creado dos contenedores: uno para la aplicación web, y otro para la base de datos.

- La aplicación web se basa en el contenedor oficial de [python](https://hub.docker.com/_/python).
- La base de datos se basa en el contenedor de [MariaDB](https://hub.docker.com/_/mariadb)

La aplicación web ejecuta el script [webapp.py](https://github.com/AlmuHS/Practica_Docker_MySQL/blob/main/python-webapp/webapp.py), el cual establece la conexión con la base de datos y muestra un pequeño formulario con dos tipos de consultas.

La base de datos se carga mediante el script [test.sql](https://github.com/AlmuHS/Practica_Docker_MySQL/blob/main/mariadb/test.sql), el cual crea las tablas y las rellena con la información perteneciente al inventario de compras de un pequeño comercio.

La base de datos tiene las siguientes credenciales:

- **nombre:** testDB
- **contraseña:** test
- **usuario: ** testusr
- **contraseña root:** testpw

## 2. Dockerfile

Para crear las imágenes de cada contenedor, disponemos de dos Dockerfile

- En la base de datos, su [Dockerfile](https://github.com/AlmuHS/Practica_Docker_MySQL/blob/main/mariadb/Dockerfile) crea la base de datos en sí y carga sus tablas, aprovechándose para ello de una característica propia de la imagen, en la que se puede ejecutar un script SQL copiándolo en un directorio llamado `SQL/` dentro de `/docker-entrypoint-initdb.d`, e invocando a `mysqld` . También expone el puerto 3306, para permitir establecer conexión TCP a MySQL.

- En la aplicación web, el [Dockerfile](https://github.com/AlmuHS/Practica_Docker_MySQL/blob/main/python-webapp/Dockerfile) copia el script y el fichero de requisitos a la imagen, instala sus requisitos mediante pip, expone el puerto 80, y lanza el script mediante Python

## 3. Compilación y despliegue manual de las imágenes

Con toda esta infraestructura, podemos probar el sistema siguiendo los siguientes pasos

### 3.1. Compilación de las imágenes

#### Descarga de los datos

Para construir las imágenes, debemos clonar el repositorio y situarnos en el directorio de cada imagen

	git clone https://github.com/AlmuHS/Practica_Docker_MySQL.git

#### Construcción de la imagen de la base de datos

Nos situamos en el directorio `mariadb` y usamos el comando `docker build` para construir la imagen

	cd mariadb
	sudo docker build . -t compras-mariadb

Esto nos creará una imagen llamada *compras-mariadb*

#### Construcción de la imagen de la aplicación web

	cd python-webapp
	sudo docker build . -t flask-mariadb

Esto nos creará una imagen llamada *flask-mariadb*

### 3.2. Lanzamiento de los contenedores

Los comandos anteriores generarán las imágenes, que se quedarán almacenadas en Docker.
Para utilizarlas, debemos lanzar contenedores basados en las mismas.

#### Preparación de la red

Para que los contenedores se puedan comunicar entre sí, estos deben estar situados en la misma red. Esto permitirá acceder a los mismos utilizando simplemente el nombre del contenedor al que queramos conectarnos, sin necesidad de conocer su dirección IP.

Para crear la red, utilizamos el comando `docker network create`. Para simplificar el despliegue, creamos una red de tipo *bridge*, la mas básica.

	sudo docker network create -d bridge mynet

Esto nos creará una red llamada *mynet*

#### Despliegue de los contenedores

Una vez con las imágenes y la red ya preparada, desplegamos los contenedores utilizando el comando `docker run`. **Dado que la aplicación web se conecta a la base de datos, la base de datos debe desplegarse en primer lugar**

##### Despliegue de la base de datos

	sudo docker run --name maria --network mynet -d compras-mariadb

##### Despliegue de la aplicación web

La aplicación web recibe el nombre del contenedor de la base de datos mediante la variable de entorno `MYSQL_HOST`  
  
  	sudo docker run --name webapp -e MYSQL_HOST="maria" -d -p 5000:80 --network mynet flask-mariadb


