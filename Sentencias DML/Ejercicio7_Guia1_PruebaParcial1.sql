--Problema 7 guía 1:

--Se tiene una lista de especificaciones a realizar para la creación de una nueva
--base de datos llamada “PERSONAL_DOCENTE”.
--1. Crear la base de datos “PERSONAL_DOCENTE” y abrirla para su uso

CREATE DATABASE PERSONAL_DOCENTE;

USE PERSONAL_DOCENTE;

--2. Crear la tabla docentes sin claves (legajo_docente(int), nombre, apellido,
--e_mail)

CREATE TABLE DOCENTES(
legajo_docente int,
nombre varchar(20),
apellido varchar(20),
email varchar(30)
);

--3. Cambie el campo legajo_docente para que no acepte nulos
ALTER TABLE DOCENTES 
ALTER COLUMN legajo_docente int NOT NULL;

--4. Agregar la clave primaria a la tabla docentes.
ALTER TABLE DOCENTES
ADD CONSTRAINT pk_docentes PRIMARY KEY (legajo_docente);

--5. Crear la tabla titulos con los siguientes campos: id_titulo, descripcion. Cree la tabla sin PK.
CREATE TABLE TITULOS(
id_titulo int,
descripcion varchar(20)
);

--6. Cambie el campo id_titulo para que no acepte nulos.
ALTER TABLE TITULOS 
ALTER COLUMN id_titulo int NOT NULL;

--7. Agregar la clave primaria sobre el campo id_titulo.
ALTER TABLE TITULOS
ADD CONSTRAINT pk_id_titulo PRIMARY KEY (id_titulo);

--8. Agregar el campo id_titulo a la tabla docentes.
ALTER TABLE DOCENTES 
ADD id_titulo int;

--9. Modifique el campo id_titulo de la tabla docente para que sea int.
ALTER TABLE DOCENTES
ALTER COLUMN id_titulo int;

--10. Agregar la clave foránea sobre id_titulo en la tabla docentes. ¿Se podría haber
--creado la clave foránea antes de crear la tabla títulos? ¿Por qué?
ALTER TABLE DOCENTES
ADD CONSTRAINT fk_docentes_titulos FOREIGN KEY (id_titulo) REFERENCES TITULOS (id_titulo);

--11. Cree en SQL Server el diagrama de la base de datos para observar su estructura
--Listo.

--12. Elimine la clave foránea sobre id_titulo de la tabla docentes.
ALTER TABLE DOCENTES
DROP CONSTRAINT fk_docentes_titulos;

--13. Elimine la clave primaria de la tabla título. ¿Podría haber eliminado esta clave primaria antes del realizar el punto 14? ¿Por qué?
ALTER TABLE TITULOS
DROP CONSTRAINT pk_titulos;
--Primero debo eliminar la FK de la tabla docentes y luego la pk de titulos.

--14. Eliminar una tabla creada por Ud. ¿Puede eliminar la tabla autores antes de libros? ¿Por qué? --Nada que ver esta ultima parte de la pregunta
-- no existen esas tablas que menciona.
DROP TABLE TITULOS;



