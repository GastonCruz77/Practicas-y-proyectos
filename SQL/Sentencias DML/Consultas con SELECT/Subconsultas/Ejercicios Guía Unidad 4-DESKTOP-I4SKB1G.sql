--Ejercicios Guía Unidad 4: Subconsultas.

use [LIBRERIA]

--1.
select a.pre_unitario, a.descripcion
from articulos a
where a.pre_unitario < 
(select avg(a.pre_unitario)
from articulos a)

--2.

select a.descripcion, de.pre_unitario, year(f.fecha)
from facturas f join detalle_facturas de on f.nro_factura = de.nro_factura
join articulos a on a.cod_articulo = de.cod_articulo
where de.pre_unitario = (select pre_unitario from detalle_facturas
where pre_unitario between 50 and 100)
group by f.fecha, a.descripcion, de.pre_unitario,
having;

------------MODELO PARCIAL---------------
select cod_vendedor, 111
from vendedores

select c.[e-mail], count(c.cod_cliente)
from clientes c
group by c.[e-mail]

select * from vendedores
where cod_vendedor = all (select cod_vendedor from facturas f where f.fecha = '2019-01-01')