use LIBRERIA_LAB2
--Gu�a 2.6 Repaso 1er Parcial

--Vistas:
--Cree una vista que liste la fecha, la factura, el c�digo y nombre del vendedor, el art�culo, la cantidad e importe,
--para lo que va del a�o. Rotule como FECHA, NRO_FACTURA, CODIGO_VENDEDOR, NOMBRE_VENDEDOR, ARTICULO, CANTIDAD, IMPORTE.
create view detalle_venta
as
select f.fecha 'FECHA', f.nro_factura 'NRO_FACTURA', v.cod_vendedor 'CODIGO_VENDEDOR', v.nom_vendedor 'NOMBRE_VENDEDOR',
a.descripcion 'ARTICULO', de.cantidad, de.cantidad * de.pre_unitario 'IMPORTE'
from vendedores v join facturas f on v.cod_vendedor = f.cod_vendedor
join detalle_facturas de on de.nro_factura = f.nro_factura
join articulos a on de.cod_articulo = a.cod_articulo
where year(f.fecha) = 2021;


--Consulta las vistas seg�n el siguiente detalle:
--a. Llame a la vista creada en el punto anterior pero filtrando por importes inferiores a $120.
select * from detalle_venta where IMPORTE < 120

--b. Llame a la vista creada en el punto anterior filtrando para el vendedor Miranda.
select * from detalle_venta where NOMBRE_VENDEDOR like 'Miranda'


--1)Crear un SP que muestre todos los registros de una tabla seg�n se ingrese una opci�n
alter procedure sp_tablaXopcion
@tablaIngresada varchar(20)
as
if @tablaIngresada is not null
begin
	if @tablaIngresada like 'facturas'  select * from facturas else raiserror('La tabla que intenta recuperar no existe', 16, 1)
	-- coloco un else con raiserror para que si el parametro de entrada es no nulo pero ademas no coincide con al menos uno
	--de los ifs, entonces ah� s� me muestra el error.
	if @tablaIngresada like 'articulos' select * from articulos
	if @tablaIngresada like 'detalle_facturas' select * from detalle_facturas
	if @tablaIngresada like 'vendedores' select * from vendedores
	if @tablaIngresada like 'clientes' select * from clientes
end
else

	raiserror('La tabla que intenta recuperar no existe', 16, 1)


exec sp_tablaXopcion factura


--2)Crear una funci�n que muestre una fecha en formato fecha larga en espa�ol. Ej.: jueves, 23 de Septiembre de 2021
alter function convertir_fechaLarga
(@fechaIngresada date )
returns varchar(60)
as
begin
declare @fechaSalida varchar(60)
set @fechaSalida = datename(weekday,@fechaIngresada) + str(day(@fechaIngresada)) + ' de ' + datename(month,@fechaIngresada) + ' de ' + str(year(@fechaIngresada))
return @fechaSalida
end

 

select dbo.convertir_fechaLarga('25/09/2021')

select month(fecha) from facturas
select datepart(month, fecha) from facturas
select datename(month,fecha) from facturas
select day(fecha) from facturas

print 'Hola' + '2' + '.'



--3)Cree un procedimiento almacenado que muestre las facturas de la fecha que se ingresa por par�metro mostrando la fecha
--en formato fecha larga.
alter procedure sp_facturasXfecha
@fechaIngresada date
as
begin
select nro_factura, datename(weekday,@fechaIngresada) + str(day(@fechaIngresada)) + ' de ' + datename(month,@fechaIngresada)
+ ' de ' + str(year(@fechaIngresada)) 'Fecha larga', cod_cliente, cod_vendedor
from facturas
where year(fecha) = year(@fechaIngresada)
and month(fecha) = month(@fechaIngresada)
and day(fecha) = day(@fechaIngresada)
end

exec sp_facturasXfecha '02/02/2005'


--4)cree un trigger que muestre el stock disponible de un art�culo luego de una venta del mismo
alter trigger t_stock_disponible
on articulos
for update
as
select d.stock 'Stock anterior a la venta', i.stock 'Stock actual' from deleted d join inserted i on d.cod_articulo = i.cod_articulo

update articulos
set stock = stock -45
where cod_articulo = 1