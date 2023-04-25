use LIBRERIA_LAB2

CREATE PROCEDURE spPrueba1
as
select * from clientes;

exec spPrueba1;

CREATE PROCEDURE spPrueba2
@nom_cliente varchar(30) = '%'
as
select * from clientes
where nom_cliente like @nom_cliente;

exec spPrueba2;
exec spPrueba2 'Rodolfo';
exec spPrueba2 @nom_cliente = 'Roque'

--Crear un procedimiento almacenado que muestre la descripción de un artículo de código determinado (enviado como parámetro de entrada)
--y nos retorne el total facturado para ese artículo y el promedio ponderado de los precios de venta de ese artículo
CREATE PROCEDURE sp_ventas_articulo
@codigo int,
@total decimal (10,2) output,
@precioprom decimal (6,2) output
as
select descripcion from articulos where cod_articulo=@codigo
select @total=sum(cantidad*pre_unitario) from detalle_facturas where cod_articulo=@codigo 
select @precioprom=sum(pre_unitario)/sum(cantidad) from detalle_facturas where cod_articulo=@codigo;

exec sp_ventas_articulo; --No funciona porque no paso parametro de entrada y no tiene parametro por defecto.
exec sp_ventas_articulo 1; --No funciona porque no paso el parametro @total.

declare @s decimal (10,2)
exec sp_ventas_articulo 1, @s output; --No funciona porque no paso el parametro @precioprom


declare @t decimal (10,2), @pp decimal (6,2)
exec sp_ventas_articulo 1, @t output, @pp output --Funciona, pero solo me devuelve la descripcion del que tiene código 1.



declare @t decimal (10,2), @pp decimal (6,2)
exec sp_ventas_articulo 1, @t output, @pp output
select @t total, @pp as Precio_promedio --Funciona y devuelve la descripcion del articulo que tiene codigo 1 en una consulta, y aparte
-- el total y precio promedio de dicho articulo en otra.


--Crear un procedimiento que muestre todos los articulos vendidos por el vendedor de código que se ingresa como parametro.
ALTER PROCEDURE spVendedor_Producto
@cod_ven int,
@suma int output
as
select a.descripcion, v.cod_vendedor
from articulos a join detalle_facturas de on a.cod_articulo = de.cod_articulo
join facturas f on f.nro_factura = de.nro_factura
join vendedores v on v.cod_vendedor = f.cod_vendedor
where v.cod_vendedor = @cod_ven;
select sum(v.cod_vendedor) from articulos a join detalle_facturas de on a.cod_articulo = de.cod_articulo
join facturas f on f.nro_factura = de.nro_factura
join vendedores v on v.cod_vendedor = f.cod_vendedor
where v.cod_vendedor = @cod_ven;

declare @s int
exec spVendedor_Producto 2, @s output; --Funciona pero no puedo renombrar la columna devuelta del conteo de cod_vendedor.

--EJERCICIO 1.2:
--a. Detalle_Ventas: liste la fecha, la factura, el vendedor, el cliente, el artículo, cantidad e importe. Este SP recibirá como parámetros de E un rango de fechas.
CREATE PROCEDURE detalle_ventas
@fecha_desde date = '01/01/1900',
@fecha_hasta date = '01/01/3000'
as

select f.fecha, f.nro_factura, v.ape_vendedor as Vendedor, c.ape_cliente as Cliente, a.descripcion as Artiuclo, de.cantidad, de.cantidad * de.pre_unitario as Importe
from facturas f join detalle_facturas de on f.nro_factura = de.nro_factura
join articulos a on a.cod_articulo = de.cod_articulo
join clientes c on f.cod_cliente = c.cod_cliente
join vendedores v on f.cod_cliente = v.cod_vendedor
where (f.fecha) between (@fecha_desde) and (@fecha_hasta)

exec detalle_ventas @fecha_desde = '01/01/2020', @fecha_hasta = '01/01/2021'

--b. CantidadArt_Cli : este SP me debe devolver la cantidad de artículos o clientes (según se pida) que existen en la empresa.

ALTER PROCEDURE CantidadArt_Cli
@clientes int  = -1,
@articulos int = -1
as
if @clientes = 1
select count(*) from clientes
if @articulos = 2
select count(*) from articulos


exec CantidadArt_Cli @clientes = 1
--Funciona pero no de la forma mas user friendly posible xd.

--c. INS_Vendedor: Cree un SP que le permita insertar registros en la tabla vendedores.
ALTER PROCEDURE INS_Vendedor
@nom_vendedor varchar(30),
@ape_vendedor varchar(30),
@calle varchar(30),
@altura int = NULL,
@cod_barrio int,
@nro_tel int = NULL,

@fec_nac date = NULL
as
INSERT INTO vendedores values (@cod_vendedor, @nom_vendedor, @ape_vendedor, @calle, @altura, @cod_barrio, @nro_tel, @fec_nac)
print 'Vendedor cargado'

exec INS_Vendedor  1,'lady', 'gaga', 2, 1, 1, 3513, '01/01/1998' --Funciona pero mal.

SELECT * FROM vendedores

--d. UPD_Vendedor: cree un SP que le permita modificar un vendedor cargado.
ALTER PROCEDURE UPD_Vendedor
@cod_vendedor int,
@campo_editar varchar(30),
@entrada int
as
BEGIN
update vendedores
set @campo_editar = @entrada
where cod_vendedor = @cod_vendedor
print 'Vendedor modificado'
END


exec UPD_Vendedor @cod_vendedor = 2, @campo_editar = [altura], @entrada = 2 --No arroja error pero no aplica los cambios

update vendedores
set altura = 200
where cod_vendedor = 1

--e. DEL_Vendedor: cree un SP que le permita eliminar un vendedor ingresado.
CREATE PROCEDURE DEL_Vendedor
@cod_vendedor int
as
delete vendedores
where cod_vendedor = @cod_vendedor
print 'Vendedor eliminado'

exec DEL_Vendedor 13;



