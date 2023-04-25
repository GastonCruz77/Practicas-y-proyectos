use LIBRERIA_LAB2


--1. El código y nombre completo de los clientes, la dirección (calle y número) y barrio.
CREATE VIEW vEjercicio1_Guia1
as
select c.cod_cliente, c.nom_cliente + ' ' + c.ape_cliente as Nombre_cliente, c.calle + ' ' + str(c.altura) as Calle_altura, b.barrio
from clientes c join barrios b on c.cod_barrio = b.cod_barrio;


--2.Cree una vista que liste la fecha, la factura, el código y nombre del vendedor, el artículo, la cantidad e importe, para lo que va del año.
CREATE VIEW vEjercicio2_Guia1
as
select f.fecha, f.nro_factura, v.cod_vendedor + '-' + v.nom_vendedor as Datos_vendedor, a.descripcion, de.cantidad, de.pre_unitario
from facturas f join vendedores v on f.cod_vendedor = v.cod_vendedor
join detalle_facturas de on de.nro_factura = f.nro_factura
join articulos a on a.cod_articulo = de.cod_articulo
where year(f.fecha) = year(getdate()); 


--Modifique la vista creada en el punto anterior, agréguele la condición de que solo tome el mes pasado
-- (mes anterior al actual) y que también muestre la dirección del vendedor.
CREATE VIEW vEjercicio3_Guia1
as
select f.fecha, f.nro_factura, str(v.cod_vendedor) + '-' + v.nom_vendedor as Datos_vendedor, b.barrio as Barrio_vendedor, a.descripcion,
de.cantidad, de.pre_unitario, de.cantidad * de.pre_unitario as importe
from facturas f join vendedores v on f.cod_vendedor = v.cod_vendedor
join detalle_facturas de on de.nro_factura = f.nro_factura
join articulos a on a.cod_articulo = de.cod_articulo
join barrios b on b.cod_barrio = v.cod_barrio
where month(f.fecha) = month(getdate())-1
and year(f.fecha) = year(getdate());

--Ejercicio 4:
--a. Llame a la vista creada en el punto anterior pero filtrando por importes inferiores a $120.
select * from vEjercicio3_Guia1 v
where v.pre_unitario * v.cantidad < 120;

--b. Llame a la vista creada en el punto anterior filtrando para el vendedor Miranda.
select * from vEjercicio3_Guia1 v
where v.Datos_vendedor LIKE '%Miranda'

--c. Llama a la vista creada en el punto 4 filtrando para los importes menores a 10.000.
select * from vEjercicio3_Guia1 v
where v.importe < 10000;

--5. Elimine las vistas creadas en el punto 3
DROP VIEW vEjercicio3_Guia1; --No lo ejecuto porque no quiero eliminarla xd.