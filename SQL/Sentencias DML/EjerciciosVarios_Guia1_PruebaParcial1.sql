--Con la base de datos creada:


--creación de la tabla escritores
CREATE TABLE ESCRITORES(
cod_escritor int IDENTITY(1,1), 
nombre varchar(15) NOT NULL,
apellido varchar(15) NOT NULL,
nacionalidad varchar(20) NOT NULL,
fecha_nac datetime NOT NULL,
fecha_def datetime

CONSTRAINT pk_escritores PRIMARY KEY (cod_escritor)
);
----------------LIBROS------------------------
CREATE TABLE LIBROS(
legajo int IDENTITY(1,1),
titulo varchar(60),
genero varchar(30),
editorial varchar(30),
edicion int,
cod_escritor int

CONSTRAINT pk_libros PRIMARY KEY (legajo)
CONSTRAINT fk_libros_escritores FOREIGN KEY (cod_escritor) REFERENCES ESCRITORES (cod_escritor)
);

ALTER TABLE LIBROS
ADD fecha datetime;

ALTER TABLE LIBROS 
ALTER COLUMN genero int;

ALTER TABLE LIBROS
ADD precio money;

ALTER TABLE LIBROS
ALTER COLUMN precio decimal(10,2);

--No existe pero lo hago igual;
ALTER TABLE LIBROS
DROP COLUMN cant_pag;

--No existe pero lo hago igual;
ALTER TABLE LIBROS
DROP COLUMN seudonimo

ALTER TABLE LIBROS
ADD CONSTRAINT fk_libros_generos FOREIGN KEY (genero) REFERENCES GENEROS (id_genero);




--------------PAISES---------------------------
CREATE TABLE PAISES(
id_pais int IDENTITY(1,1),
pais varchar(50)
);

ALTER TABLE PAISES
ALTER COLUMN id_pais int NOT NULL;

ALTER TABLE PAISES
ADD CONSTRAINT pk_paises PRIMARY KEY (id_pais);


--------------------AUTORES--------------------
CREATE TABLE AUTORES(
id_autor int IDENTITY(1,1),
nombre_autor varchar(60),


CONSTRAINT pk_autores PRIMARY KEY (id_autor)
);

ALTER TABLE AUTORES
ADD id_pais_origen int NOT NULL;

ALTER TABLE AUTORES
ADD CONSTRAINT fk_autores_paises FOREIGN KEY (id_pais) REFERENCES PAISES (id_pais);

ALTER TABLE AUTORES 
ADD anio_nac int NOT NULL;

ALTER TABLE AUTORES 
ADD anio_def int NOT NULL;

ALTER TABLE AUTORES
ALTER COLUMN nombre_autor varchar(80);



------------GENEROS------------------------
CREATE TABLE GENEROS(
id_genero int IDENTITY(1,1),
genero varchar(50)

);

ALTER TABLE GENEROS
ALTER COLUMN id_genero int NOT NULL;

ALTER TABLE GENEROS
ADD CONSTRAINT pk_generos PRIMARY KEY (id_genero);





