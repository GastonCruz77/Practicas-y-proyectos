--Ejercicio 1.3: Funciones definidas por el usuario.

--Ejercicio 5 - a: Hora: una funci�n que les devuelva la hora del sistema en el formato
--HH:MM:SS (tipo car�cter de 8).

ALTER FUNCTION HORA()
returns char(8)
as
begin
declare @resultado char(8)
select @resultado = convert(char(8), getdate(), 108) --as [hh:MM:ss];
return @resultado
end;

select dbo.HORA()

--Ejercicio 5 - b: Fecha: una funci�n que devuelva la fecha en el formato AAAMMDD (en
--car�cter de 8), a partir de una fecha que le ingresa como par�metro
--(ingresa como tipo fecha).

ALTER FUNCTION FECHA()
returns char(10)
as
begin
declare @resultado char(10)

select @resultado = convert(char(4), YEAR(getdate())) + '-' + convert(char(2), MONTH(getdate()))
+ '-' + convert(char(2), DAY(getdate()))
return @resultado
end;

select dbo.FECHA()

--Ejercicio 5 - c: Dia_Habil: funci�n que devuelve si un d�a es o no h�bil (considere
--como d�as no h�biles los s�bados y domingos). Debe devolver 1
--(h�bil), 0 (no h�bil)

CREATE FUNCTION DIA() --No funciona a�n
returns int
as
begin
declare @resultado int
	case datename(day, getdate())
	when 'monday' then @resultado = 1
	when 'tuesday' then @resultado = 1
	when 'wednesday' then @resultado = 1
	when 'thursday' then @resultado = 1
	when 'friday' then @resultado = 1
	when 'saturday' then @resultado = 0
	when 'sunday' then @resultado = 0
	return @resultado
end;

select datename(day, getdate())