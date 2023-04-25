--Ejercicios Guía Unidad 4: Subconsultas.

use [LIBRERIA]
use [LIBRERIA_LAB2]
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
where de.pre_unitario = ANY (select pre_unitario from detalle_facturas
where pre_unitario between 50 and 100)
group by f.fecha, a.descripcion, de.pre_unitario
having year(f.fecha) != 2021


------------MODELO PARCIAL---------------
select cod_vendedor, 111
from vendedores

select c.[e-mail], count(c.cod_cliente)
from clientes c
group by c.[e-mail]

select * from vendedores
where cod_vendedor = all (select cod_vendedor from facturas f where f.fecha = '2019-01-01')

--3.
select count(f.nro_factura) 'Cantidad de facturas', c.ape_cliente, f.fecha
from facturas f join clientes c on f.cod_cliente = c.cod_cliente
where year(f.fecha) = year(getdate())-1
group by c.ape_cliente, f.fecha
having count(f.nro_factura) >= 2

--4.
select c.cod_cliente, c.nom_cliente +' '+ c.ape_cliente
from clientes c
where not exists (select cod_cliente
				from facturas f 
				where f.cod_cliente = c.cod_cliente
				and (year(f.fecha) between 2010 and 2015
				and month(f.fecha) between 07 and 12
				and day(f.fecha) between 12 and 13))

--5.
select f.fecha, f.nro_factura, c.cod_cliente, c.nom_cliente +' '+ c.ape_cliente
from facturas f join clientes c on f.cod_cliente = f.cod_cliente
where month(f.fecha) = (select distinct month(fecha) from facturas where month(fecha) = 02)

--6.
select count(f.nro_factura) 'Cantidad de facturas', c.nom_cliente +' '+ c.ape_cliente 'Cliente'
from clientes c join facturas f on c.cod_cliente = f.cod_cliente
group by c.nom_cliente +' '+ c.ape_cliente
having count(f.nro_factura) < 9

--7.
select f.fecha, f.nro_factura, a.descripcion, sum(de.cantidad*de.pre_unitario) 'Importe de factura'
from facturas f join detalle_facturas de on f.nro_factura = de.nro_factura
join articulos a on de.cod_articulo = a.cod_articulo
group by f.nro_factura, f.fecha, a.descripcion
having sum(de.cantidad*de.pre_unitario) > (select top 1 sum(d.cantidad*d.pre_unitario) from detalle_facturas d join  facturas fa
											on d.nro_factura = fa.nro_factura
											where (d.cantidad*d.pre_unitario) > 1500
											group by fa.nro_factura
											order by 1)

--8.
select v.nom_vendedor, f.cod_cliente	
from vendedores v join facturas f on v.cod_vendedor = f.cod_vendedor
where f.cod_cliente IN (select cod_cliente from clientes where cod_cliente NOT IN (1, 6))

--9. Un asco la consigna.
select a.*
from articulos a join detalle_facturas de on a.cod_articulo = de.cod_articulo
where a.pre_unitario > (select sum(d.cantidad*d.pre_unitario)/count(fa.nro_factura) 
						from detalle_facturas d join facturas fa
						on d.nro_factura = fa.nro_factura)

--10.
select a.descripcion, a.cod_articulo
from articulos a 
where a.descripcion NOT LIKE '[D-P]%'
and a.cod_articulo NOT IN (select a.cod_articulo
from articulos a join detalle_facturas de on a.cod_articulo = de.cod_articulo)

--11.
select f.nro_factura, f.fecha, str(c.cod_cliente) + ' ' + c.ape_cliente 'Cliente'
from facturas f join clientes c on f.cod_cliente = c.cod_cliente
where f.cod_vendedor = (select cod_vendedor from vendedores v where cod_vendedor = 3)

--12.
select f.nro_factura, f.fecha, a.descripcion 'Articulo', sum(de.cantidad) 'cantidad de articulos',
sum(de.cantidad*de.pre_unitario) 'Importe total'
from facturas f join detalle_facturas de on f.nro_factura = de.nro_factura
join articulos a on a.cod_articulo = de.cod_articulo
group by f.nro_factura, f.fecha, a.descripcion
having sum(de.cantidad) > 40

--13. muy similar al 12.

--14.
select f.nro_factura, f.fecha, c.ape_cliente 'Cliente', a.descripcion 'Articulo', sum(de.cantidad*de.pre_unitario) 'Importe'
from facturas f join detalle_facturas de on f.nro_factura = de.nro_factura
join articulos a on a.cod_articulo = de.cod_articulo
join clientes c on c.cod_cliente = f.cod_cliente
group by f.nro_factura, f.fecha, c.ape_cliente, a.descripcion 
having sum(de.cantidad*de.pre_unitario) < 3000




