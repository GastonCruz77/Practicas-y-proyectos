use [Cine_2021]

--Top 3 funciones más vendidas OK
CREATE SP_CONSULTA_1
AS
BEGIN
select top 3p.titulo, count(de.id_funcion) 'Cantidad de funciones vendidas'
from Peliculas p join funciones f on p.id_pelicula = f.id_pelicula
join detalle_ventas de on de.id_funcion = f.id_funcion
group by p.titulo
order by 'Cantidad de funciones vendidas' desc
END

exec SP_CONSULTA_1
--Cantidad de clientes que compraron una función por mes.OK
create procedure SP_CONSULTA_2
@año int
as
select str(month(t.fecha)) + ' - ' + datename(month,t.fecha) 'Mes', year(t.fecha), count(t.id_cliente) 'Cantidad'
from tickets t
where year(t.fecha) = @año
group by str(month(t.fecha)) + ' - ' + datename(month,t.fecha), year(t.fecha)

--OK
create procedure SP_CONSULTA_3
as
select p.titulo, i.idioma
from peliculas p join idiomas i on p.id_idioma = i.id_idioma
group by p.titulo, i.idioma

--
create procedure SP_CONSULTA_4
AS
BEGIN


-------- IGNORAR TODO LO ANTERIOR ----------
drop procedure SP_CONSULTA_1
drop procedure SP_CONSULTA_2
drop procedure SP_CONSULTA_3

--1--Cantidad de entradas vendidas e importe por cada género de película donde la clasificación sea apta para todo público.
alter procedure SP_CONSULTA_1
AS
BEGIN
SELECT COUNT(dv.id_detalle_venta) AS 'Cantidad vendida', SUM(dv.precio_Subtotal) AS 'Importe', g.detalle_genero AS Genero, c.descripcion AS Clasificacion
FROM Detalle_Ventas dv JOIN Funciones f ON dv.id_funcion=f.id_funcion
JOIN Peliculas p ON f.id_pelicula= p.id_pelicula
JOIN Generos g ON p.id_genero=g.id_genero
JOIN Clasificacion_Peliculas c ON p.id_clasificacion=c.id_clasificacion
GROUP BY g.detalle_genero, c.descripcion
HAVING c.descripcion = 'Mayores de 18'
END;

exec SP_CONSULTA_1


--2. Cantidad de ventas por función, en la última semana, separado por días.

create procedure SP_CONSULTA_2
as
begin
select  str(dv.id_funcion) + ', ' + p.titulo AS Funcion ,COUNT(dv.id_detalle_venta) 'Cantidad de ventas', t.fecha AS Fecha
FROM Detalle_Ventas dv JOIN Funciones f ON dv.id_funcion=f.id_funcion
JOIN Peliculas p ON f.id_pelicula=p.id_pelicula
JOIN Tickets t ON dv.id_ticket=t.id_ticket
GROUP BY str(dv.id_funcion) + ', ' + p.titulo, t.fecha, titulo
HAVING t.fecha BETWEEN DATEADD(DAY, -7, t.fecha) AND GETDATE()
end;

exec SP_CONSULTA_2


--3--Películas estrenadas entre los meses de febrero y octubre de este año.

CREATE PROCEDURE SP_CONSULTA_3
AS
BEGIN
SELECT id_pelicula 'Id. Pelicula',titulo Pelicula, idioma Idioma, detalle_formato Formato, CONVERT(VARCHAR(10), p.fecha_estreno, 103) 'Fecha de Estreno'
FROM Peliculas p JOIN Idiomas i ON p.id_idioma = i.id_idioma 
            JOIN Formatos_Peliculas f ON p.id_formato = f.id_formato
WHERE id_pelicula IN
(
        	SELECT id_pelicula
        	FROM Peliculas 
        	WHERE year (fecha_estreno) = year(getdate()) 
        	AND month (fecha_estreno) BETWEEN 2 AND 10
)
ORDER BY detalle_formato
END;

EXEC SP_CONSULTA_3




4--Cantidad de tickets vendidos por vendedor entre los meses de mayo y diciembre del año actual.

create procedure SP_CONSULTA_4
as
begin
SELECT  t.fecha, str(t.id_vendedor) + ' - ' + ape_vendedor+'  '+nom_vendedor 'Código y nombre vendedor', count(*)'Cantidad de Tickets'
FROM Tickets t, vendedores v
WHERE month(t.fecha) BETWEEN 5 AND 12
AND t.id_vendedor = v.id_vendedor
GROUP BY str(t.id_vendedor) + ' - ' + ape_vendedor+'  '+nom_vendedor, t.fecha
ORDER BY 1,2
end;

exec SP_CONSULTA_4

--5--Las 10 películas con más ventas en el idioma inglés  

alter procedure SP_CONSULTA_5
as
begin
SELECT TOP 10 P.TITULO AS Peliculas, COUNT(d.id_detalle_venta) AS 'Cantidad Ventas'
FROM DETALLE_VENTAS D JOIN FUNCIONES F ON F.ID_FUNCION=D.ID_FUNCION 
JOIN PELICULAS P ON P.ID_PELICULA=P.ID_PELICULA 
JOIN IDIOMAS I ON I.ID_IDIOMA =P.ID_IDIOMA
WHERE I.IDIOMA= 'Inglés (Subtitulado)'
GROUP BY  P.titulo
ORDER BY 2 desc
end;

exec SP_CONSULTA_5

--6--Top 3 funciones más vendidas
create procedure SP_CONSULTA_6
as
begin
select top 3 p.titulo, count(de.id_funcion) 'Cantidad de funciones vendidas'
from peliculas p join funciones f on p.id_pelicula =
f.id_pelicula
join Detalle_Ventas de on de.id_funcion = f.id_funcion
group by p.titulo
order by 'Cantidad de funciones vendidas' desc
end;

exec SP_CONSULTA_6

--7--Cantidad de clientes que compraron una función agrupado por mes. --REVISAR EN C#
alter procedure SP_CONSULTA_7
@mes int
as
begin
select
str(month(t.fecha)) + ' - ' + datename(month,t.fecha) 'Mes', year(t.fecha) 'Año',count(t.id_cliente) 'Cantidad'
from tickets t
where month(t.fecha) = @mes
group by str(month(t.fecha)) + ' - ' + datename(month,t.fecha), year(t.fecha)
end

exec SP_CONSULTA_7 10

--8-- Vista de las diferentes peliculas y los idiomas en los que están disponibles 

alter procedure SP_CONSULTA_8
as
begin
select p.titulo 'Película', i.idioma 'Idioma'
from peliculas p join idiomas i on p.id_idioma = i.id_idioma
group by p.titulo, i.idioma
end;

exec SP_CONSULTA_8

--9-- Mostrar películas de terror que harán estreno en el dia de Hallowen
create procedure SP_CONSULTA_9
as
begin
Select id_pelicula 'Id Pelicula',titulo 'Pelicula', detalle_genero 'Genero', duracion 'Duracion', fecha_estreno 'Fecha'
from Peliculas p join Generos g ON p.id_genero = g.id_genero
where detalle_genero = 'Terror'
and month(fecha_estreno) = 10
and day(fecha_estreno) = 31
and year(fecha_estreno) = year(getdate())
end

exec SP_CONSULTA_9

--10--Ingresando la forma de pago, conocer  el nombre completo del cliente, su número de documento, titulo de la película y fecha de emisión del ticket.
alter procedure SP_CONSULTA_10 --REVISAR EN C#
@forma varchar(50)
as
begin
select cl.nom_cliente + ', ' + cl.ape_cliente 'Cliente', cl.nro_doc 'Nro Documento', p.titulo 'Función comparada', t.fecha 'Fecha de compra', fo.descripcion 'Forma de pago'
from clientes cl join tickets t on cl.id_cliente = t.id_cliente
join detalle_ventas de on t.id_ticket = de.id_ticket
join funciones f on de.id_funcion = f.id_funcion
join peliculas p on p.id_pelicula = f.id_pelicula
join formas_pago fo on de.id_forma_pago = fo.id_forma_pago
where fo.descripcion = @forma
group by cl.nom_cliente + ', ' + cl.ape_cliente, cl.nro_doc, p.titulo, t.fecha, fo.descripcion
end

exec SP_CONSULTA_10 'Crédito'