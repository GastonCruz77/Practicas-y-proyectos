CREATE DATABASE PROBLEMA2_GUIA2;

USE PROBLEMA2_GUIA2;

--CREACIÓN DE TABLA ARTICULOS. 
CREATE TABLE ARTICULOS(
cod_articulo int IDENTITY (1,1),
descripcion varchar(100),
stock_minimo int,
pre_unitario money,
observaciones varchar(100)

CONSTRAINT pk_articulos PRIMARY KEY (cod_articulo)
);

--INSTERT DE REGISTROS EN LA TABLA.
INSERT INTO ARTICULOS (descripcion, pre_unitario)
VALUES ('Lapices color largos * 12 u, Bic', 101.5);

INSERT INTO ARTICULOS (descripcion, pre_unitario, observaciones)
VALUES('Conjunto geométirico maped', 20.5, 'regla, escuadra y transportador');

INSERT INTO ARTICULOS (descripcion, stock_minimo, pre_unitario, observaciones)
VALUES('repuesto gloria rallado', 120, 326.3,'200 hojas');

INSERT INTO ARTICULOS (descripcion, pre_unitario, observaciones)
VALUES('repuesto rivadavia', 465.9,'260 hojas, margen reforzado');

--ACTUALIZACIÓN DE DATOS DE CAMPOS DE LA TABLA ARTICULOS.
UPDATE ARTICULOS
SET stock_minimo = 100,
observaciones = 'Caja con motivos de Disney',
pre_unitario = 17.2
WHERE descripcion LIKE 'Lapices color largos * 12 u, Bic';

UPDATE ARTICULOS
SET descripcion = 'Repuesto Rivadavia cuadriculado',
observaciones = '48 hojas'
WHERE descripcion LIKE 'repuesto rivadavia';



