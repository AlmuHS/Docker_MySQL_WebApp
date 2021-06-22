DROP DATABASE IF EXISTS TESTDB;

CREATE TABLE IF NOT EXISTS CLIENTES(
    id int AUTO_INCREMENT,
    usuario varchar(20) UNIQUE NOT NULL,
    nombre varchar(100),
    apellidos varchar(100),
    email varchar(50),
    direccion varchar(100),
    ciudad varchar(15),
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS PRODUCTOS(
        id int AUTO_INCREMENT,
        modelo varchar(30) UNIQUE,
        descripcion varchar(100),
        precio float,
        stock int,
        PRIMARY KEY(ID)
);

CREATE TABLE IF NOT EXISTS COMPRAS(
        id int AUTO_INCREMENT,
        id_producto int NOT NULL,
        id_usuario int NOT NULL,
        num_unidades int NOT NULL,
        PRIMARY KEY(id),
        FOREIGN KEY(id_producto) REFERENCES PRODUCTOS(ID)
);

INSERT INTO CLIENTES(usuario, nombre, apellidos, email, direccion, ciudad) 
    VALUES("marcos_gomez", "Marcos", "Gomez", "jgon@gmail.com", "Calle Falsa, 5", "Jaen");

INSERT INTO CLIENTES(usuario, nombre, apellidos, email, direccion, ciudad) 
    VALUES("sara_guay", "Sara", "Perez", "sarita@hotmail.com", "Calle Vacia, 24", "Madrid");

INSERT INTO CLIENTES(usuario, nombre, apellidos, email, direccion, ciudad) 
    VALUES("juanito1990", "Juan", "Fernandez", "juanfer@email.com", "Urbanización Villafría, 35", "Toledo");
    
INSERT INTO CLIENTES(usuario, nombre, apellidos, email, direccion, ciudad) 
    VALUES("tommy", "Tomas", "Martin", "tom25@gmail.com", "Avenida del Comercio, 18", "Málaga");

INSERT INTO PRODUCTOS(modelo, descripcion, precio, stock)
        VALUES("i7-4710MQ", "Procesador Intel Core i7 de cuarta generación, de 4 núcleos", 75.94, 5);

INSERT INTO PRODUCTOS(modelo, descripcion, precio, stock)
        VALUES("Sony Xperia-XA2", "Smartphone de pantalla curva y cámara de 10 Mp", 80.5, 10);

INSERT INTO PRODUCTOS(modelo, descripcion, precio, stock)
        VALUES("Thinkpad T14v2", "Portátil empresarial de 14 pulgadas, con procesador i5 de décima generación", 1150.75, 50);

INSERT INTO PRODUCTOS(modelo, descripcion, precio, stock)
        VALUES("Crucial MX-500 500 GB", "Disco duro de estado sólido, de gama alta", 50.4, 100);

INSERT INTO COMPRAS(id_producto, id_usuario, num_unidades)
        VALUES(1, 2, 1);

INSERT INTO COMPRAS(id_producto, id_usuario, num_unidades)
        VALUES(2, 2, 1);

INSERT INTO COMPRAS(id_producto, id_usuario, num_unidades)
        VALUES(3, 3, 2);
        
INSERT INTO COMPRAS(id_producto, id_usuario, num_unidades)
        VALUES(3, 4, 2);
        
INSERT INTO COMPRAS(id_producto, id_usuario, num_unidades)
        VALUES(2, 1, 2);

INSERT INTO COMPRAS(id_producto, id_usuario, num_unidades)
        VALUES(2, 4, 2);

