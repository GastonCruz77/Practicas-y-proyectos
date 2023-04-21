--1. Crear la base de datos “PERSONAL_DOCENTE” y abrirla para su uso
CREATE DATABASE EJ7_GUIA1_PERSONAL_DOCENTE;

USE EJ7_GUIA1_PERSONAL_DOCENTE;

----2.Crear la tabla docentes sin claves (legajo_docente(int), nombre, apellido, e_mail)

CREATE TABLE DOCENTES(
legajo_docente int,
nombre varchar(15),
apellido varchar(15),
e_mail varchar(30)
);

--3.3. Cambie el campo legajo_docente para que no acepte nulos

ALTER TABLE DOCENTES
ALTER COLUMN legajo_docente int NOT NULL;

--4. Agregar la clave primaria a la tabla docentes

ALTER TABLE DOCENTES
ADD CONSTRAINT pk_legajo_docente PRIMARY KEY (legajo_docente);

--5. Crear la tabla titulos con los siguientes campos: id_titulo, descripcion. Cree la tabla sin PK

CREATE TABLE TITULOS(
id_titulo int,
descripcion varchar(100)
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
ALTER COLUMN id_titulo int NOT NULL;

--10. Agregar la clave foránea sobre id_titulo en la tabla docentes. ¿Se podría haber creado la clave foránea antes de crear la tabla títulos? ¿Por qué?

ALTER TABLE DOCENTES
ADD CONSTRAINT fk_docentes_titulos FOREIGN KEY (id_titulo) REFERENCES titulos (id_titulo);

--11. Cree en SQL Server el diagrama de la base de datos para observar su estructura.

--LISTO.

--12. Elimine la clave foránea sobre id_titulo de la tabla docentes.

ALTER TABLE DOCENTES
DROP CONSTRAINT fk_docentes_titulos;

--13. Elimine la clave primaria de la tabla título. ¿Podría haber eliminado esta clave primaria antes del realizar el punto 14? ¿Por qué?

ALTER TABLE TITULOS
DROP pk_id_titulo;

--14. Eliminar una tabla creada por Ud. ¿Puede eliminar la tabla autores antes de libros? ¿Por qué?

--NO HICE LA CONSIGNA ANTERIOR XD
