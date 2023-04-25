--Ejercicios Guía Unidad 3 : Consutlas sumarias.

use [LIBRERIA]
use [LIBRERIA_LAB2]
--1.
select sum(pre_unitario*cantidad) 
from detalle_facturas

--2.
select sum(de.pre_unitario*de.cantidad) 'Monto total factura', count(de.cod_articulo) 'cantidad articulos'
, min(de.pre_unitario) 'minimo precio individual', max(de.pre_unitario) 'maximo precio individual'
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
where f.nro_factura = 236

--3.
select f.nro_factura, sum(de.pre_unitario*de.cantidad) 'importe total'
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
where year(f.fecha) = year(getdate())-1
group by f.nro_factura

--4.
select count([e-mail]) 'Clientes con mail'
from clientes 

--5.
select sum(de.pre_unitario*de.cantidad) 'monto total de facturación', count(f.nro_factura) 'Cantidad de facturas emitidas'
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura

--6.
select avg(de.pre_unitario*de.cantidad) 'promedio de facturación' , f.nro_factura
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
where year(f.fecha) = year(getdate())-1
group by f.nro_factura

--7.
select count(f.nro_factura) 'Cantidad de ventas', v.cod_vendedor
from facturas f join vendedores v on f.cod_vendedor = v.cod_vendedor
group by v.cod_vendedor
having v.cod_vendedor = 3;

--8.
select min(f.fecha) 'Primera venta', max(f.fecha) 'ultima venta'
from facturas f

--9.
select sum(de.cantidad) 'total de unidades vendidas',
count(distinct de.cod_articulo) 'cantidad e articulos diferentes',
sum(de.pre_unitario*de.cantidad) 'importe total'
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
where de.nro_factura = 450;

--10.
select sum(de.cantidad) 'Cantidad de unidades vendidas',
sum(de.pre_unitario*de.cantidad) 'importe total',
avg(de.pre_unitario*de.cantidad) 'promedio de venta',
v.nom_vendedor
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
join vendedores v on f.cod_vendedor = v.cod_vendedor
where v.nom_vendedor like '[D-I]%'
group by v.nom_vendedor

--11.
select sum(de.pre_unitario*de.cantidad) 'importe total vendido',
avg(de.pre_unitario*de.cantidad) 'promedio de venta',
sum(de.cantidad) 'cantidad de articulos vendidos',
c.nom_cliente + ' ' + c.ape_cliente 'Cliente'
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
join clientes c on f.cod_cliente = c.cod_cliente
where c.nom_cliente like 'Roque' and c.ape_cliente like 'Paez'
group by c.nom_cliente + ' ' + c.ape_cliente

--12.
select min(f.fecha) 'primera venta', sum(de.cantidad) 'Cantidad de articulos vendidos',
sum(de.pre_unitario*de.cantidad) 'importe total',
a.descripcion
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
join articulos a on a.cod_articulo = de.cod_articulo
where a.descripcion like 'C%'
group by a.descripcion

--13.
select sum(de.cantidad) 'Cantidad vendidos',
sum(de.pre_unitario*de.cantidad) 'Improte total', f.fecha 'Periodo'
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
where f.fecha between '2011-06-15' and '2017-06-15' --AÑOS PRIMERO!!!
group by f.fecha

--14.
select count(f.nro_factura) 'Cantidad veces', max(f.fecha) 'Ultima visita',
c.ape_cliente 'Cliente', sum(de.cantidad*de.pre_unitario) 'Importe total'
from facturas f join detalle_facturas de on f.nro_factura = de.nro_factura
join clientes c on f.cod_cliente = c.cod_cliente
where c.ape_cliente like 'Abarca'
group by c.ape_cliente

--15.
select sum(de.cantidad*de.pre_unitario) 'Importe total',
avg(de.cantidad*de.pre_unitario) 'promedio venta', c.ape_cliente
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
join clientes c on c.cod_cliente = f.cod_cliente
where c.[e-mail] IS NOT NULL
group by c.ape_cliente

--16.
select sum(de.cantidad*de.pre_unitario) 'Importe total',
avg(de.cantidad*de.pre_unitario) 'promedio venta',
sum(de.cantidad) 'Cantidad articulos',
de.pre_unitario, f.nro_factura
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
group by f.nro_factura, de.pre_unitario
having f.nro_factura NOT IN (13,5,17,33,14)

-----------Problema 3.2------------
--3.
--Anualmente
select sum(de.cantidad*de.pre_unitario) 'Importe total', year(f.fecha) 'año'
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
group by year(f.fecha)
order by 2 asc

--mensualmente
select sum(de.cantidad*de.pre_unitario) 'Importe total', month(f.fecha) 'mes'
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
group by month(f.fecha)
order by 2 asc

--diaramente
select sum(de.cantidad*de.pre_unitario) 'Importe total', day(f.fecha) 'dia'
from detalle_facturas de join facturas f on de.nro_factura = f.nro_factura
group by day(f.fecha)
order by 2 asc

--4.
select count(f.nro_factura) 'Cantidad facturas', day(f.fecha) 'día'
from facturas f
where month(f.fecha) NOT IN (1, 6, 12)
group by day(f.fecha)
order by 1 desc, 2


