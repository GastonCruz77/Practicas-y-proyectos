--2.1: Introducci�n a la Programaci�n en SQL Server

USE LIBRERIA_LAB2

--Ejercicio 1
declare @codigo int = 3
declare @stock int
declare @stockMinimo int

select @stock = articulos.stock
from articulos
where articulos.cod_articulo = @codigo

select @stockMinimo = articulos.stock_minimo
from articulos
where articulos.cod_articulo = @codigo

print 'Stock: ' + convert(varchar, @stock) 
print ' Stock minimo: ' + convert(varchar,@stockMinimo)

--Ejercicio 2: 
declare @codigo2 int = 1
declare @stockMinimo2 int

select @stockMinimo2 = articulos.stock_minimo
from articulos
where articulos.cod_articulo = @codigo2

if @stockMinimo2 is null or @stockMinimo2 = 0
begin
	print 'Debe reponer art�culos del c�digo ' + convert(varchar,@codigo2)
end
else
	print  ' Stock minimo: ' + convert(varchar,@stockMinimo2)


select * from articulos