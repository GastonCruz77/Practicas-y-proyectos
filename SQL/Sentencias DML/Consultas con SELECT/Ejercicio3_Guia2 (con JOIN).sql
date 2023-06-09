--Problema 3: 31-44, con sentencia JOIN
USE VIVERO_FENIX;

--31. Listado de clientes mostrando apellido y nombre, calle y n�mero.
SELECT C.APELLIDO + ', ' +  C.NOMBRE 'APELLIDO Y NOMBRE', CA.NOMBRE 'NOMBRE CALLE', C.ALTURA
FROM CLIENTES C JOIN CALLES CA ON C.COD_CALLE = CA.COD_CALLE;

--32. Listado de clientes mostrando apellido, nombre y localidad a la que pertenece.
SELECT C.APELLIDO, C.NOMBRE, L.NOMBRE 'LOCALIDAD'
FROM CLIENTES C JOIN LOCALIDADES L ON C.COD_LOCALIDAD = L.COD_LOCALIDAD;

--33. Listado de clientes mostrando apellido, nombre y barrio al que pertenece.
SELECT C.APELLIDO, C.NOMBRE, B.NOMBRE 'BARRIO'
FROM CLIENTES C JOIN BARRIOS B ON C.COD_BARRIO = B.COD_BARRIO;

--34. Todas las facturas abonadas en efectivo, ordenada por c�digo de cliente.
SELECT  DISTINCT C.COD_CLIENTE, C.APELLIDO + ', ' + C.NOMBRE 'APELLIDO Y NOMBRE', F.NRO_FACTURA, F.FECHA, FO.DESCRIPCION
FROM CLIENTES C JOIN FACTURAS F ON C.COD_CLIENTE = F.COD_CLIENTE JOIN FORMAS_PAGO FO ON F.COD_FORMA_PAGO = FO.COD_FORMA_PAGO
WHERE FO.DESCRIPCION LIKE 'EFECTIVO'
ORDER BY C.COD_CLIENTE;

--35. Listar todas plantas donde el tipo de planta sea Flores.
SELECT P.DESCRIPCION, T.NOMBRE 'TIPO DE PLANTA'
FROM PLANTAS P JOIN TIPOS_PLANTAS T ON P.COD_TIPO_PLANTA = T.COD_TIPO_PLANTA
WHERE T.NOMBRE LIKE 'FLORES';

--36. Todos los clientes cuya localidad sea AREQUITO.
SELECT C.APELLIDO, C.NOMBRE, L.NOMBRE
FROM CLIENTES C JOIN LOCALIDADES L ON C.COD_LOCALIDAD = L.COD_LOCALIDAD
WHERE L.NOMBRE LIKE 'AREQUITO';

--37. Todos los registros completos de clientes cuyo IVA sea igual a Monotributo, ordenado por localidad.
SELECT C.*, CO.DESCRIPCION, L.NOMBRE
FROM CLIENTES C JOIN CONDICIONES_IVA CO ON C.COD_CONDICION_IVA = CO.COD_CONDICION_IVA 
JOIN LOCALIDADES L ON C.COD_LOCALIDAD = L.COD_LOCALIDAD
WHERE CO.DESCRIPCION LIKE 'MONOTRIBUTISTA'
ORDER BY L.NOMBRE;

--38. Listar todos los datos de los clientes que viven en la localidad de C�rdoba o su apellido comience con la letra �A�.
SELECT C.*, L.NOMBRE
FROM CLIENTES C JOIN LOCALIDADES L ON C.COD_LOCALIDAD = L.COD_LOCALIDAD
WHERE L.NOMBRE LIKE 'CORDOBA' OR C.APELLIDO LIKE 'A%';

--39. Listar clientes que viven en la localidad de Carlos Paz, Alta Gracia y Cba Capital.
SELECT C.APELLIDO + ', ' + C.NOMBRE 'APELLIDO Y NOMBRE', L.NOMBRE
FROM CLIENTES C JOIN LOCALIDADES L ON C.COD_LOCALIDAD = L.COD_LOCALIDAD
WHERE L.NOMBRE IN ('CARLOS PAZ', 'ALTA GRACIA', 'CORDOBA');

--40. Mostrar todos los clientes que no viven en las localidades de AREQUITO y MERLO.
SELECT C.APELLIDO + ', ' + C.NOMBRE 'APELLIDO Y NOMBRE', L.NOMBRE
FROM CLIENTES C JOIN LOCALIDADES L ON C.COD_LOCALIDAD = L.COD_LOCALIDAD
WHERE L.NOMBRE NOT IN ('ARQUITO', 'MERLO');

--41. Mostrar nombre, apellido y barrio de los clientes de Cba. Capital o de aquellos cuyos apellidos no comiencen con letras
--de la �D�a la �P�. Ordenar por barrio.
SELECT C.APELLIDO + ', ' + C.NOMBRE 'APELLIDO Y NOMBRE', B.NOMBRE
FROM CLIENTES C JOIN BARRIOS B ON C.COD_BARRIO = B.COD_BARRIO JOIN LOCALIDADES L ON C.COD_LOCALIDAD = L.COD_LOCALIDAD
WHERE L.NOMBRE LIKE 'CORDOBA' OR C.APELLIDO NOT LIKE '[D-P]%'
ORDER BY B.NOMBRE;

--42. Listar el detalle de la factura calculando la cantidad por el precio.
SELECT F.NRO_FACTURA, D.NRO_FACTURA 'DETALLE FACT. NRO.', D.COD_PLANTA, D.CANTIDAD, P.PRECIO, D.CANTIDAD * P.PRECIO 'PRECIO TOTAL'
FROM DETALLES_FACTURAS D JOIN PLANTAS P ON D.COD_PLANTA = P.COD_PLANTA JOIN FACTURAS F ON F.NRO_FACTURA = D.NRO_FACTURA;

--43. Listar todos los clientes que vivan en provincias que comiencen con 'San' y que sea Monotributista.
SELECT C.APELLIDO, C.NOMBRE, P.NOMBRE, CO.DESCRIPCION
FROM CLIENTES C JOIN PROVINCIAS P ON C.COD_PROVINCIA = P.COD_PROVINCIA 
JOIN CONDICIONES_IVA CO ON C.COD_CONDICION_IVA = CO.COD_CONDICION_IVA
WHERE P.NOMBRE LIKE 'SAN%' AND CO.DESCRIPCION LIKE 'MONOTRIBUTISTA';

--44. Listar todos los clientes que viven en barrio Alberdi, Alta C�rdoba y que adem�s posean tel�fono.
SELECT C.APELLIDO, C.NOMBRE, B.NOMBRE
FROM CLIENTES C JOIN BARRIOS B ON C.COD_BARRIO = B.COD_BARRIO
WHERE B.NOMBRE IN ('ALBERDI', 'ALTA CORDOBA') AND C.TELEFONO IS NOT NULL;

