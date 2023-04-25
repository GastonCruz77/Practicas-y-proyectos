---MODELO PARCIAL 2 LAB2---
--TEMA A PREGUNTA 1:

select m.cod_mascota + ' ' + m.nom_mascota 'Mascota',
me.cod_medico + ' ' + me.nom_medico 'Medico',
c.fec_consulta 'Fecha consulta'
from consultas c join medicos me on c.cod_medico = me.cod_medico
join mascotas m on c.cod_mascota = m.cod_mascota
join due�os d on d.cod_due�o = m.cod_due�o
where c.fec_consulta IN (year(getdate())-1, year(getdate())-2)
and (d.dir_due�o NOT LIKE '%pe�a%' and d.dir_due�o NOT LIKE '%moreno%')
and c.fec_prox IS NULL
order by c.fec_consulta asc, m.nom_mascota desc

--Ejercicio 1 de nuevo.
select m.cod_mascota + ' ' + m.nom_mascota 'Mascota',
me.cod_medico + ' ' + me.nom_medico 'Medico',
c.fec_consulta 'Fecha consulta'
from consultas c join medicos me on c.cod_medico = me.cod_medico
join mascotas m on c.cod_mascota = m.cod_mascota
join due�os d on d.cod_due�o = m.cod_due�o
where d.dir_due�o not in ('%pe�a%', '%moreno%')
and c.fec_prox = (select fec_prox from consultas where fec_prox IS NULL group by fec_prox)
order by c.fec_consulta asc, m.nom_mascota desc

--2.
select count(c.fec_consulta) 'Cantidad consultas', sum(c.importe) 'Total de importe',
avg(c.importe) 'Promedio de importe', d.nom_due�o 'Due�o'
from consultas c join mascotas m on c.cod_mascota = m.cod_mascota
join due�os d on m.cod_due�o = d.cod_due�o
where c.fec_consulta between 2006 and 2013
group by d.nom_due�o
having sum(c.importe) > 1000

--3.
select m.nom_mascota 'Mascota', d.nom_due�o 'Due�o', d.dir_due�o 'Direcci�n', d.tel_due�o 'Telefono due�o',
c.fec_consulta 'Fechas de consultas'
from consultas c join mascotas m  on c.cod_mascota = m.cod_mascota
join due�os d on m.cod_due�o = d.cod_due�o
where year(c.fec_consulta) != year(getdate()) -1

--4.
select me.nom_medico 'Medico', count(c.fec_consulta) 'Consultas atendidas',
min(c.fec_consulta) 'Primera consulta', max(c.fec_consulta) 'Ultima consulta',
sum(c.importe) 'Importe total del mes'
from consultas c join medicos me on c.cod_medico = me.cod_medico
where month(c.fec_consulta) = month(getdate())
group by me.nom_medico
having count(c.fec_consulta) < ANY (select count(fec_consulta) from consultas co join medicos med on co.cod_medico = med.cod_medico
where month(c.fec_consulta) = month(getdate()) -1)

--------REPASO 2DO PARCIAL---------
use [LIBRERIA_LAB2]

select pre_unitario 'Precio', 'Articulo' Tipo
from articulos
union
select pre_unitario, 'Detalle'
from detalle_facturas
order by 2

select [e-mail], count(*) --Cuenta y separa los NULL
from clientes
group by [e-mail]

select count([e-mail]) --Cuenta solo los NO NULL
from clientes

select count(*) --Cuenta todo, (pero no hay filas completas NULL)
from clientes

select count(*) 'Clientes', count([e-mail]) 'Clientes con mail'
from clientes

----Unidad 4: Tests------

select distinct de.nro_factura
from detalle_facturas de 
where exists (select f.nro_factura
				from facturas f
				where de.nro_factura = f.nro_factura)

