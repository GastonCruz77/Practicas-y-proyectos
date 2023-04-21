--Guía 2 - 2.4 Triggers

--Ejercicio 1 - a: Restar stock DESPUES de INSERTAR una VENTA

CREATE TRIGGER dis_ventas_insertar
on detalle_facturas
for insert
as
declare @stock int
select @stock = stock from articulos a join inserted on inserted.cod_articulo = a.cod_articulo
if (@stock >= (select cantidad from inserted))
	update articulos
		set stock = stock - inserted.cantidad
		from articulos a join inserted on inserted.cod_articulo = a.cod_articulo
else
	begin
		raiserror ('El stock en artículos es menor que la cantidad solicitada', 16, 1)
		rollback transaction
	end;

--Ejercicio 1 - b: Para no poder modificar el nombre de algún artículo.
alter TRIGGER dis_articulos_modificar
on articulos
for update
as
declare @nombre varchar(50)
select @nombre = descripcion from articulos
if (@nombre = (select descripcion from inserted))
	update articulos
		set descripcion = inserted.descripcion from inserted
else
	begin
		print('No se puede modificar la descripcion de los articulos')
		rollback transaction
	end;

select * from articulos

update articulos
set descripcion = 'Lapiz feo'
where cod_articulo = 1

--Ejercicio 1 - c: Insertar en la tabla HistorialPrecio el precio anterior de un artículo si el mismo ha cambiado.
CREATE TRIGGER dis_insertar_historialPrecio
on historial_precios
for insert
as
declare @precio int
select @precio = pre_unitario from articulos
if (@precio != (select precio from inserted))
	--insertar en la tabla.
else
	begin
	raiserror ('No se puede insertar un nuevo registro a la tabla de historiales porque el precio no ha cambiado')
	rollback transaction
	end;

--Ejercicio 1 - d: Bloquear al vendedor con código 4 para que no pueda registrar ventas en el sistema.
alter TRIGGER dis_vendedor_facturas
on facturas
for insert
as
if (4 = (select cod_vendedor from inserted))
print('El vendedor (4) NO está habilitado para registrar ventas')
rollback transaction

insert into facturas values('20/09/2021', 5, 4)
