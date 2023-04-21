CREATE DATABASE EJERCICIO1_GUIA1;

USE EJERCICIO1_GUIA1;

CREATE TABLE ESCRITORES(
cod_escritor int IDENTITY (1,1),
nombre varchar (15),
apellido varchar (15),
nacionalidad varchar (10),
fecha_nac datetime,
fecha_def datetime

CONSTRAINT pk_escritores PRIMARY KEY (cod_escritor)
);

CREATE TABLE LIBROS(
legajos int IDENTITY (1,1),
titulo varchar (30),
genero varchar (10),
editorial varchar (10),
edicion int,
cod_escritor int,

CONSTRAINT pk_legajos PRIMARY KEY (legajos),
CONSTRAINT fk_libros_escritores FOREIGN KEY (cod_escritor) REFERENCES escritores (cod_escritor)
);

--MODIFICACIÓN Y ELIMINACIÓN DE TABLAS

ALTER TABLE LIBROS
ADD fecha datetime;

CREATE TABLE PAISES(
id_pais int IDENTITY (1,1),
pais varchar(30),

CONSTRAINT pk_paises PRIMARY KEY (id_pais)
);

ALTER TABLE ESCRITORES
ADD id_pais int NOT NULL;

ALTER TABLE ESCRITORES
ADD CONSTRAINT fk_escritores_paises FOREIGN KEY (id_pais) REFERENCES paises (id_pais);

ALTER TABLE ESCRITORES
DROP COLUMN fecha_nac;

ALTER TABLE ESCRITORES
DROP COLUMN fecha_def;

ALTER TABLE ESCRITORES
ADD fecha_nac int NOT NULL;

ALTER TABLE ESCRITORES
ADD fecha_def  int NULL;

ALTER TABLE LIBROS
ALTER COLUMN genero int;

CREATE TABLE GENEROS(
id_genero int IDENTITY (1,1),
genero varchar(30)

CONSTRAINT pk_generos PRIMARY KEY (id_genero)
);

ALTER TABLE LIBROS
ADD CONSTRAINT fk_libros_generos FOREIGN KEY (genero) REFERENCES generos (id_genero);

ALTER TABLE ESCRITORES
ALTER COLUMN nombre varchar(80);

ALTER TABLE LIBROS 
ADD precio money;

ALTER TABLE LIBROS
ALTER COLUMN precio decimal (10,2);









