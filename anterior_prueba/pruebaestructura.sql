mysql -u root

CREATE DATABASE EJ_PRUEBA;

USE EJ_PRUEBA;

CREATE TABLE fabricantes(
    Codigo INT(8) NOT NULL,
    Nombre Varchar(50) NOT NULL,
    PRIMARY KEY(Codigo)
);
CREATE TABLE articulos(
    Codigo INT(8) NOT NULL,
    Codigo_fabricantes INT(8) NOT NULL,
    Nombre Varchar(50) NOT NULL,
    Precio DOUBLE(10,2) NOT NULL,
    FOREIGN KEY(Codigo_fabricantes) REFERENCES fabricantes(Codigo)
);