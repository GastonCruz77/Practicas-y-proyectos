--LEFT JOIN, es para cuando queremos que aparezcan todos los campos de la izquierda, y los NULL serán los de la derecha.
--RIGHT JOIN, es para cuando queremos que aparezcan todos los campos de la derecha, y los NULL serán los de la izquierda.
USE LIBRERIA;
--Problema N° 4: Resuelva utilizando JOIN los siguientes reportes:

--2. Genere un reporte con los datos de la facturación (datos de las facturas incluidos los del vendedor y cliente)
--de los años 2006, 2007, 2009 y 2012.
SELECT F.NRO_FACTURA, F.FECHA, C.NOM_CLIENTE + ', ' + C.APE_CLIENTE 'CLIENTE', V.nom_vendedor + ', ' + V.ape_vendedor 'VENDEDOR'
FROM FACTURAS F JOIN CLIENTES C ON F.COD_CLIENTE = C.COD_CLIENTE JOIN VENDEDORES V ON F.COD_VENDEDOR = V.cod_vendedor
WHERE YEAR(F.FECHA) IN (2006, 2007, 2009, 2012);


--3. Liste los datos de la facturación, de los artículos y de la venta de las facturas correspondientes al mes pasado.
SELECT F.*, DF.*, A.*
FROM FACTURAS F JOIN DETALLE_FACTURAS DF ON F.nro_factura = DF.nro_factura JOIN ARTICULOS A ON A.cod_articulo = DF.cod_articulo
WHERE MONTH(F.FECHA) = MONTH(GETDATE()) -1 AND YEAR(F.FECHA) = YEAR(GETDATE());


--4. Emita un listado con los datos del vendedor y las ventas que ha realizado en lo que va del año. Muestre los
--vendedores aun así no tengan ventas registradas en el año solicitado.
--Corregido por el profe.
SELECT V.nom_vendedor + ', ' + V.ape_vendedor 'VENDEDOR', F.FECHA
FROM VENDEDORES V LEFT JOIN FACTURAS F ON V.COD_VENDEDOR = F.COD_VENDEDOR
AND YEAR(F.FECHA) = YEAR(GETDATE()) AND MONTH(F.FECHA) >= MONTH(GETDATE());

SELECT * FROM facturas;
--5. Liste descripción, cantidad e importe; aun para aquellos artículos que no registran ventas.
SELECT A.DESCRIPCION, DF.CANTIDAD, A.PRE_UNITARIO
FROM ARTICULOS A LEFT JOIN detalle_facturas DF ON A.cod_articulo = DF.cod_articulo;

--6. Genere un reporte con los datos de la facturación (datos de las facturas incluidos los del vendedor y cliente)
--y de la venta (incluido el importe); para las ventas de febrero y marzo de los años 2006 y 2007 y siempre que el artículo
--empiece con letras que van de la “a” a la “m”. Ordene por fecha, cliente y artículo.
SELECT F.NRO_fACTURA, F.FECHA, C.NOM_CLIENTE + ', ' + C.APE_CLIENTE 'CLIENTE', V.nom_vendedor + ', ' + V.ape_vendedor 'VENDEDOR', A.DESCRIPCION,
DF.PRE_UNITARIO * DF.CANTIDAD 'IMPORTE VENTA'
FROM FACTURAS F JOIN CLIENTES C ON F.cod_cliente = C.cod_cliente JOIN VENDEDORES V ON F.cod_vendedor = V.cod_vendedor JOIN detalle_facturas DF ON
F.nro_factura = DF.nro_factura JOIN ARTICULOS A ON DF.cod_articulo = A.cod_articulo
WHERE YEAR(F.FECHA) IN (2006, 2007) AND MONTH(F.FECHA) IN (02, 03) AND A.descripcion LIKE '[A-M]%'
ORDER BY 2, 3, 5;

--7. Liste código de cliente, nombre, fecha y factura para las ventas del año 2007. Muestre los clientes hayan comprado o
--no en ese año.
--Corregido por el profe, para que me traiga los NULL (o sea los que no compraron en 2007), la condición va en el FROM.
SELECT C.COD_CLIENTE, C.NOM_CLIENTE + ' ' + C.APE_CLIENTE 'CLIENTE', F.FECHA, F.NRO_FACTURA
FROM CLIENTES C LEFT JOIN FACTURAS F ON C.cod_cliente = F.cod_cliente
AND YEAR(F.FECHA) = 2007;
--8. Se quiere saber los artículos que compro la cliente Elvira López en lo que va del año. Liste artículo, observaciones e importe.
SELECT A.DESCRIPCION, C.NOM_CLIENTE + ' ' + C.APE_CLIENTE 'CLIENTE',A.OBSERVACIONES, DF.PRE_UNITARIO * DF.CANTIDAD 'IMPORTE'
FROM ARTICULOS A JOIN detalle_facturas DF ON A.cod_articulo = DF.cod_articulo JOIN FACTURAS F ON DF.nro_factura = F.nro_factura JOIN CLIENTES C ON
F.cod_cliente = C.cod_cliente
WHERE C.nom_cliente LIKE 'ELVIRA' AND C.ape_cliente LIKE 'LOPEZ';

--9. Se quiere saber los artículos que compraron los clientes cuyos apellidos empiezan con “p”. Liste cliente, articulo, cantidad e importe.
--Ordene por cliente y artículo, este en forma descendente. Rotule como CLIENTE, ARTICULO, CANTIDAD, IMPORTE.
SELECT C.NOM_CLIENTE + ' ' + C.APE_CLIENTE 'CLIENTE', A.DESCRIPCION 'ARTICULO', DF.CANTIDAD, DF.CANTIDAD * DF.PRE_UNITARIO 'IMPORTE'
FROM ARTICULOS A JOIN detalle_facturas DF ON A.cod_articulo = DF.cod_articulo JOIN FACTURAS F ON DF.nro_factura = F.nro_factura JOIN CLIENTES C ON
F.cod_cliente = C.cod_cliente
WHERE C.ape_cliente LIKE 'P%'
ORDER BY 1, 2 DESC;