CREATE DATABASE EJERCICIO4_GUIA1;

USE EJERCICIO4_GUIA1;

CREATE TABLE DOCENTES(
id_docente int IDENTITY (1,1),
nombre varchar(15),
apellido varchar(15),

CONSTRAINT pk_docentes PRIMARY KEY (id_docente)
);

CREATE TABLE CURSOS(
cod_curso int IDENTITY (1,1),
descripcion varchar(100),
nivel int,
id_docente int,
horario datetime,

CONSTRAINT pk_cursos PRIMARY KEY (cod_curso),
CONSTRAINT fk_cursos_docentes FOREIGN KEY (id_docente) REFERENCES docentes (id_docente),
);

CREATE TABLE PROVINCIAS(
id_provincia int IDENTITY (1,1),
nom_provincia varchar(50),

CONSTRAINT pk_provincias PRIMARY KEY (id_provincia)
);

CREATE TABLE LOCALIDADES(
id_localidad int IDENTITY (1,1),
nom_localidad varchar(50),
id_provincia int,

CONSTRAINT pk_localidades PRIMARY KEY (id_localidad),
CONSTRAINT fk_localidades_provincias FOREIGN KEY (id_provincia) REFERENCES provincias (id_provincia)
);

CREATE TABLE BARRIOS(
id_barrio int IDENTITY (1,1),
nom_barrio varchar(50),
id_localidad int,

CONSTRAINT pk_barrios PRIMARY KEY (id_barrio),
CONSTRAINT fk_barrios_localidades FOREIGN KEY (id_localidad) REFERENCES localidades (id_localidad)
);

CREATE TABLE ALUMNOS(
legajo int IDENTITY (1,1),
nombre varchar(15),
apellido varchar(15),
id_barrio int,
calle varchar(30),
nro_calle int,
telefono int,
email varchar(30),

CONSTRAINT pk_alumnos PRIMARY KEY (legajo),
CONSTRAINT fk_alumnos_barrios FOREIGN KEY (id_barrio) REFERENCES barrios (id_barrio)
);

CREATE TABLE PAGOS(
legajo int,
cod_curso int,
mes_año int,
fecha datetime,
monto money,

CONSTRAINT pk_pagos PRIMARY KEY (legajo, cod_curso, mes_año),
CONSTRAINT fk_pagos_alumnos FOREIGN KEY (legajo) REFERENCES alumnos (legajo),
CONSTRAINT fk_pagos_cursos FOREIGN KEY (cod_curso) REFERENCES cursos (cod_curso)
);

