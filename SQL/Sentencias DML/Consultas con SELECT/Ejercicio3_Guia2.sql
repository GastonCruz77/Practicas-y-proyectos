USE VIVERO_FENIX

--1. Listado de los clientes de la empresa, mostrando solo el código, apellido y nombre, ordenado por código.
SELECT c.COD_CLIENTE, c.APELLIDO, c.NOMBRE
FROM CLIENTES C
ORDER BY c.COD_CLIENTE;

--2. Ídem al anterior pero rotule los campos como Código de Cliente, Apellido, Nombre. Ordenar por apellido y nombre en forma ascendente.
SELECT c.COD_CLIENTE 'Código de Cliente', c.APELLIDO 'Apellido', c.NOMBRE 'Nombre'
FROM CLIENTES C
ORDER BY c.APELLIDO, c.NOMBRE;

--3. Listado de las plantas que se venden, mostrando el código, descripción y precio, ordenadas por código en forma descendente.
SELECT p.COD_PLANTA, p.DESCRIPCION, p.PRECIO
FROM PLANTAS P
ORDER BY p.COD_PLANTA DESC;

--4. Mostrar el stock de cada planta, ordenadas por la descripción de las plantas. Rotular: Nombre Planta, Stock Actual.
SELECT P.DESCRIPCION 'Nombre Planta', p.STOCK 'Stock Actual'
FROM PLANTAS P
ORDER BY p.DESCRIPCION;

--5. Listado de las localidades que compran a la empresa, ordenados por orden alfabético.
SELECT l.NOMBRE
FROM LOCALIDADES L
ORDER BY l.NOMBRE;

--6. Mostrar apellido y nombre del cliente en una sola columna, además de su código.
SELECT c.APELLIDO + ', ' + c.NOMBRE, c.COD_CLIENTE
FROM CLIENTES C;

--7. Mostrar todos los datos de las plantas y además calcular el precio con un descuento del 10%.
SELECT *, p.PRECIO - (10*100/p.PRECIO) AS 'Descuento de 10%'
FROM PLANTAS P;

--8. Mostrar el precio total de stock de cada planta.
SELECT p.PRECIO 'Precio por unidad', p.STOCK, p.STOCK * p.PRECIO 'Precio total por Stock'
FROM PLANTAS P;

--9. Mostrar todos los clientes deudores (deudor=’S’), solo su código, nombre, apellido.
SELECT C.COD_CLIENTE, C.NOMBRE, C.APELLIDO
FROM CLIENTES C
WHERE C.DEUDOR like 'S';

--10. Mostrar todas las plantas cuyo stock sea mayor a 20, ordenadas por stock.
SELECT *
FROM PLANTAS P 
WHERE P.STOCK > 20
ORDER BY P.STOCK;

--11. Mostrar todas las plantas cuyo stock no sea 30, ordenados por código.
SELECT *
FROM PLANTAS P
WHERE P.STOCK != 30
ORDER BY P.COD_PLANTA;

--12. Mostrar todas las facturas cuyas fechas sean mayores al 01/06/09.
SELECT *
FROM FACTURAS F
WHERE F.FECHA > '01/06/09';

--13. Listar todas las plantas cuyo stock es menor a 10 unidades.
SELECT *
FROM PLANTAS P
WHERE P.STOCK < 10;

--14. Ídem a la consulta anterior pero las fechas oscilen entre 01/06/08 y 01/03/10.
SELECT *
FROM FACTURAS F
WHERE F.FECHA >=  01/06/09 AND F.FECHA <= 01/03/10;

--15. Listar los datos de las plantas cuyo precio esté entre 200 y 700.
SELECT * 
FROM PLANTAS P
WHERE P.PRECIO BETWEEN 200 AND 700;

--16. Mostrar la descripción, stock y precio de las plantas cuyo stock oscile entre 5 y 10.
SELECT P.DESCRIPCION, P.STOCK, P.PRECIO
FROM PLANTAS P
WHERE P.STOCK BETWEEN 5 AND 10

SELECT P.DESCRIPCION, P.STOCK, P.PRECIO
FROM PLANTAS P
WHERE P.STOCK >= 5 AND <= 200

--17. Todos los clientes cuyo apellido comience con “f”.
SELECT *
FROM CLIENTES C
WHERE C.APELLIDO LIKE 'F%';

--18. Todos los clientes cuyo nombre contenga una “u”.
SELECT *
FROM CLIENTES C
WHERE C.NOMBRE LIKE '%U%';

--19. Todos los clientes cuyo apellido no comience con letras que van de la “a” a la “c”.
SELECT *
FROM CLIENTES C
WHERE C.APELLIDO LIKE '[A-C]%';

--20. Todos los clientes cuyo apellido termine con “ez”.
SELECT * 
FROM CLIENTES C
WHERE C.APELLIDO LIKE '%EZ';

--21. Listar todos los clientes cuyo apellido no comience con “p”.
SELECT * 
FROM CLIENTES C
WHERE C.APELLIDO NOT LIKE 'P%';

--22. Ídem al anterior pero que no comience ni con “p” ni con “z”.
SELECT * 
FROM CLIENTES C
WHERE C.APELLIDO NOT LIKE 'P%' AND C.APELLIDO NOT LIKE 'Z%';

--23. Mostrar todos los clientes que no tengan teléfono.
SELECT * 
FROM CLIENTES C
WHERE TELEFONO IS NULL;

--24. Listar apellido, nombre, e-mail de los clientes cuyos direcciones de mail sea conocidas.
SELECT C.APELLIDO, C.NOMBRE, C.EMAIL
FROM CLIENTES C
WHERE C.EMAIL IS NOT NULL;

--25. Listar apellido, nombre, teléfono de los clientes cuyos teléfono sea conocido.
SELECT C.APELLIDO, C.NOMBRE, C.TELEFONO
FROM CLIENTES C
WHERE C.TELEFONO IS NOT NULL;

--26. Listar todas las plantas que comiencen con R y precio superior a $7.
SELECT * 
FROM PLANTAS P
WHERE P.DESCRIPCION LIKE 'R%' AND P.PRECIO > 7;

--27. Mostrar todas las plantas cuyo precio sean menor a $ 50 o mayor a $ 100, Mostrar también su precio con un aumento del 10%.
SELECT *, P.PRECIO * 1.10 'Precio con aumento de 10%'
FROM PLANTAS P
WHERE P.PRECIO < 50 OR P.PRECIO > 100;

--28. Listar apellido, nombre, teléfono e e-mail de los clientes cuyos direcciones de mail o teléfono sean conocidos.
SELECT C.APELLIDO, C.NOMBRE, C.TELEFONO, C.EMAIL
FROM CLIENTES C
WHERE C.EMAIL IS NOT NULL AND C.TELEFONO IS NOT NULL;

--29. Listar los datos de los clientes cuyos nombres comiencen ni con “m” ni con “n” ni con “p” o su precio sea mayor a 50 
--con una valoración de stock menor a $ 1.000. MAL REDACTADO
SELECT * 
FROM CLIENTES C
WHERE C.NOMBRE NOT LIKE '[M-N]%' AND C.NOMBRE NOT LIKE 'P%';

--30. Mostrar todas las plantas cuyo stock sea mayor a 5 y menor a 50 o bien su precio aumentado en un 15% esté entre 50 y 100. Ordenar por descripción.
SELECT *, P.PRECIO * 1.15 Precio_aumentado_en_15
FROM PLANTAS P
WHERE (P.STOCK < 50 AND P.STOCK > 5)
ORDER BY P.DESCRIPCION;

--31. Listado de clientes mostrando apellido y nombre, calle y número.
SELECT C.APELLIDO, C.NOMBRE, CA.NOMBRE 'Nombre calle', C.ALTURA
FROM CLIENTES C, CALLES CA
WHERE C.COD_CALLE = CA.COD_CALLE;

--32. Listado de clientes mostrando apellido, nombre y localidad a la que pertenece.
SELECT C.APELLIDO, C.NOMBRE, L.NOMBRE 'NOMBRE LOCALIDAD'
FROM CLIENTES C, LOCALIDADES L
WHERE C.COD_LOCALIDAD = L.COD_LOCALIDAD;

--33. Listado de clientes mostrando apellido, nombre y barrio al que pertenece.
SELECT C.APELLIDO, C.NOMBRE, B.NOMBRE 'NOMBRE BARRIO'
FROM CLIENTES C, BARRIOS B
WHERE C.COD_BARRIO = B.COD_BARRIO;

--34. Todas las facturas abonadas en efectivo, ordenada por código de cliente.
SELECT F.*, FO.DESCRIPCION
FROM FACTURAS F, FORMAS_PAGO FO
WHERE F.COD_FORMA_PAGO = FO.COD_FORMA_PAGO AND FO.DESCRIPCION LIKE 'EFECTIVO'
ORDER BY F.COD_CLIENTE;

--35. Listar todas plantas donde el tipo de planta sea Flores.
SELECT P.DESCRIPCION, T.NOMBRE 'TIPO DE PLANTA'
FROM PLANTAS P, TIPOS_PLANTAS T
WHERE P.COD_TIPO_PLANTA = T.COD_TIPO_PLANTA AND T.NOMBRE LIKE 'FLORES';

--36. Todos los clientes cuya localidad sea AREQUITO.
SELECT DISTINCT C.APELLIDO, C.NOMBRE, L.NOMBRE 'NOMBRE LOCALIDAD'
FROM CLIENTES C, LOCALIDADES L
WHERE C.COD_LOCALIDAD = L.COD_LOCALIDAD AND L.NOMBRE LIKE 'ARQUITO';

SELECT * FROM CLIENTES;
SELECT * FROM LOCALIDADES;

--37. Todos los registros completos de clientes cuyo IVA sea igual a Monotributo, ordenado por localidad.
SELECT C.*, CO.DESCRIPCION 'CONDICIÓN IVA', L.NOMBRE 'NOMBRE LOCALIDAD'
FROM CLIENTES C, CONDICIONES_IVA CO, LOCALIDADES L
WHERE (C.COD_CONDICION_IVA = CO.COD_CONDICION_IVA AND CO.DESCRIPCION LIKE 'MONOTRIBUTO') AND
(C.COD_LOCALIDAD = L.COD_LOCALIDAD)
ORDER BY L.NOMBRE;

--38. Listar todos los datos de los clientes que viven en la localidad de Córdoba o su apellido comience con la letra ‘A’.
SELECT C.*, L.NOMBRE 'NOMBRE LOCALIDAD'
FROM CLIENTES C, LOCALIDADES L
WHERE (C.COD_LOCALIDAD = L.COD_LOCALIDAD AND L.NOMBRE LIKE 'CORDOBA') AND C.APELLIDO LIKE 'A%';

--39. Listar clientes que viven en la localidad de Carlos Paz, Alta Gracia y Cba Capital.
SELECT C.APELLIDO, C.NOMBRE, L.NOMBRE 'NOMBRE LOCALIDAD'
FROM CLIENTES C, LOCALIDADES L
WHERE C.COD_LOCALIDAD = L.COD_LOCALIDAD AND L.NOMBRE IN ('CARLOS PAZ', 'ALTA GRACIA', 'CBA CAPITAL');

--40. Mostrar todos los clientes que no viven en las localidades de AREQUITO y MERLO.
SELECT C.*, L.NOMBRE 'LOCALIDADES'
FROM CLIENTES C, LOCALIDADES L
WHERE C.COD_LOCALIDAD = L.COD_LOCALIDAD AND L.NOMBRE NOT IN ('AREQUITO', 'MERLO');

--41. Mostrar nombre, apellido y barrio de los clientes de Cba. Capital o de aquellos cuyos apellidos no comiencen con letras
--de la ‘D’a la ‘P’. Ordenar por barrio.
SELECT C.NOMBRE, C.APELLIDO, B.NOMBRE
FROM CLIENTES C, BARRIOS B, LOCALIDADES L
WHERE C.COD_BARRIO = B.COD_BARRIO AND C.COD_LOCALIDAD = L.COD_LOCALIDAD AND (L.NOMBRE LIKE 'CORDOBA' OR C.APELLIDO NOT LIKE '[D-P]%')
ORDER BY B.NOMBRE;

--42. Listar el detalle de la factura calculando la cantidad por el precio.
SELECT D.*, P.PRECIO, D.CANTIDAD * P.PRECIO 'PRECIO TOTAL'
FROM DETALLES_FACTURAS D, PLANTAS P;

--43. Listar todos los clientes que vivan en provincias que comiencen con 'San' y que sea Monotributista.
SELECT C.*, P.NOMBRE, CO.DESCRIPCION
FROM CLIENTES C, PROVINCIAS P, CONDICIONES_IVA CO
WHERE C.COD_PROVINCIA = P.COD_PROVINCIA AND P.NOMBRE LIKE 'SAN%'
AND C.COD_CONDICION_IVA = CO.COD_CONDICION_IVA AND CO.DESCRIPCION LIKE 'MONOTRIBUTISTA';

--44. Listar todos los clientes que viven en barrio Alberdi, Alta Córdoba y que además posean teléfono.
SELECT C.*, B.NOMBRE
FROM CLIENTES C, BARRIOS B
WHERE C.COD_BARRIO = B.COD_BARRIO AND B.NOMBRE IN ('ALBERDI', 'ALTA CORDOBA') AND C.TELEFONO IS NOT NULL;
--No existe ningún barrio llamado alberdi o alta cordoba en la BD.

USE VIVERO_FENIX

SELECT C.APELLIDO, B.NOMBRE
FROM CLIENTES C, BARRIOS B, LOCALIDADES L
ORDER BY L.COD_LOCALIDAD