--Ejercicio 5 Guía 2.

--10. Se necesita mostrar el código, nombre, apellido (todo el apellido en mayúsculas) y dirección (calle y altura en una sola columna; 
--para la altura utilice una función de conversión) de todos los clientes cuyo nombre comience con “C” y cuyo apellido termine con “Z”.
--Rotule como CÓDIGO DE CLIENTE, NOMBRE, DIRECCIÓN.
SELECT C.COD_CLIENTE 'CÓDIGO DE CLIENTE', C.NOM_CLIENTE + ' ' + UPPER(C.APE_CLIENTE) 'NOMBRE', C.CALLE + ' ' + 
STR(C.ALTURA, 4,0) + ', ' + B.BARRIO 'DIRECCIÓN'
FROM CLIENTES C JOIN BARRIOS B ON C.cod_barrio = B.cod_barrio
WHERE C.nom_cliente LIKE 'C%' AND C.ape_cliente LIKE '%Z';

--11. Ídem al anterior pero el apellido comience con letras que van de la “D” a la “L” y cuyo nombre no comience con letras que van de la “A” a la “G”.
SELECT C.COD_CLIENTE 'CÓDIGO DE CLIENTE', C.NOM_CLIENTE + ' ' + UPPER(C.APE_CLIENTE) 'NOMBRE', C.CALLE + ' ' + 
STR(C.ALTURA, 4,0) + ', ' + B.BARRIO 'DIRECCIÓN'
FROM CLIENTES C JOIN BARRIOS B ON C.cod_barrio = B.cod_barrio
WHERE C.nom_cliente NOT LIKE '[A-G]%' AND C.ape_cliente LIKE '[D-L]%';

--12. Muestre los datos de los vendedores (apellido todo en mayúsculas y en la misma columna que el nombre) cuyo nombre no contenga “Z”, haya nacido en
--la década del 70 y que haya realizado ventas el mes pasado.
SELECT V.COD_VENDEDOR, V.nom_vendedor+ ' ' + UPPER(V.ape_vendedor) 'NOMBRE', V.FEC_NAC, F.NRO_FACTURA, F.FECHA
FROM VENDEDORES V JOIN FACTURAS F ON V.COD_VENDEDOR = F.COD_VENDEDOR
WHERE YEAR(V.fec_nac) BETWEEN 1970 AND 1979 AND V.nom_vendedor NOT LIKE '%Z%' AND MONTH(F.fecha) = MONTH(GETDATE()) - 1 
AND YEAR(F.FECHA) = YEAR(GETDATE());;

--13. Mostrar las facturas realizadas entre el 1/1/2007 y el 1/5/2009 y cuyos códigos de vendedor sean 1, 3 y 4 o bien entre el
--1/1/2010 y el 1/5/2011 y cuyos códigos de vendedor sean 2 y 4. Mostrar la fecha en formato Dia, Mes, y Año (en ese orden y sin la hora)
SELECT F.nro_factura, FORMAT(F.fecha, 'dd/mm/yyyy') 'FECHA FACTURA', F.cod_vendedor
FROM FACTURAS F
WHERE (F.fecha BETWEEN '1/1/2007' AND '1/5/2009' AND F.cod_vendedor IN (1, 3, 4)) 
OR (F.fecha BETWEEN '1/1/2010' AND '1/5/2011' AND F.cod_vendedor IN (2, 4));

--14. Se quiere saber el subtotal de todos los artículos vendidos, para ello liste el artículo y multiplique la cantidad por el
--precio unitario de venta; mostrar el subtotal redondeado a dos decimales (o buscar la forma de dale formato apropiado).
--Ordene por alfabéticamente por artículo y cuyo subtotal mayor aparezca primero. No muestre datos duplicados.
SELECT DISTINCT DF.cod_articulo, A.DESCRIPCION,  ROUND(DF.CANTIDAD, DF.CANTIDAD * DF.PRE_UNITARIO, 2) 'SUBTOTAL'
FROM detalle_facturas DF JOIN ARTICULOS A ON DF.cod_articulo = A.cod_articulo
ORDER BY 2, 3;

--15. Muestre las ventas (tabla detalle_facturas) de los artículos cuyo precio unitario actual sea mayor o igual a 50 o cuyos
--códigos de artículos no sea uno de los siguientes: 2, 5, 6, 8, 10. En ambos casos los precios unitarios a los que fueron
--vendidos oscilen entre 10 y 100.
SELECT DF.*, A.descripcion 
FROM detalle_facturas DF JOIN ARTICULOS A ON DF.cod_articulo = A.cod_articulo
WHERE DF.pre_unitario >= 50 AND A.cod_articulo NOT IN (2,5,6,8,10);