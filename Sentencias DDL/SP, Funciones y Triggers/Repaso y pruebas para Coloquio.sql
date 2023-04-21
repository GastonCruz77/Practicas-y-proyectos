use [LIBRERIA_LAB2]


--Creación de vistas.

create view prueba1
as
select str(cod_cliente) + ' ' + ape_cliente 'Persona', 'Cliente' Tipo
from clientes 
union 
select str(cod_vendedor) + ' ' + ape_vendedor, 'Vendedor'
from vendedores

select * from prueba1
drop view prueba1
--

create view prueba2
as
select nom_cliente
from clientes

select * from prueba2
--

alter view prueba3
as
select a.pre_unitario 'Precio artículo', de.pre_unitario 'Precio de venta'
from articulos a join detalle_facturas de on a.cod_articulo = de.cod_articulo

select * from prueba3
--

select Persona from prueba1
--

select convert(money, cod_cliente)
from clientes 

select fecha, convert(date, fecha, 'dd/MM/yyyy')
from facturas
--

--SP
create procedure SP_PRUEBA2
@entrada int = 0,
@salida varchar(50) output
as
begin
select @salida = str(cod_cliente)
from clientes
where cod_cliente = @entrada
end

declare @s varchar(50)
exec SP_PRUEBA2 1, @s output
select @s


create procedure SP_PRUEBA1
@entrada int = 0,
@salida varchar(50) output
as
begin
select @salida = ape_cliente
from clientes
where cod_cliente = @entrada
end

declare @s varchar(50)
exec SP_PRUEBA1 1, @s output
select @s

alter procedure SP_PRUEBA3
@entrada int = null
as
if @entrada is null
begin
select'La entrada es null'
return
end
select  ape_cliente, cod_cliente
from clientes 
where cod_cliente = @entrada

exec SP_PRUEBA3 2

--Manejo de errores y bloque try-catch

begin try
select 1/0 as error
end try
begin catch
select 'se produjo el error en la lína: ', ERROR_LINE() as linea, ERROR_SEVERITY()
end catch

--Pregunta coloquio
select count(*) --Agrupa por facturas y cuenta cuantos detalles tiene cada una
from detalle_facturas
group by nro_factura select max(nro_factura)from facturasselect count(*), count(nro_factura), count(distinct nro_factura)
from detalle_facturas
group by nro_factura

declare @v int = 1
select @v

declare @v int
set @v = 2
select @v
