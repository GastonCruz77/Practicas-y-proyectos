create database Cine_2021
go
use Cine_2021
go

create table Clasificacion_Peliculas --Bien
(
	id_clasificacion int identity (1,1),
	descripcion varchar(50) not null,
	constraint pk_id_clasificacion primary key (id_clasificacion)
)

create table Idiomas --Bien
(
	id_idioma int identity (1,1),
	idioma varchar (50) not null,
	constraint pk_id_idioma primary key (id_idioma)
)

create table Formatos_Peliculas --Bien
(
	id_formato int identity (1,1),
	detalle_formato varchar (10) not null,
	constraint pk_id_formato primary key (id_formato)
)

create table Generos --Bien
(
    id_genero int identity (1,1),
	detalle_genero varchar (50) not null,
	constraint pk_id_genero primary key (id_genero)
)

create table Actores --Bien pero hay que agregarla a la normalización. LISTO
(
	id_actor int identity (1,1),
	nom_actor varchar (50) not null,
	ape_actor varchar (50) not null,
	constraint pk_id_actor primary key (id_actor)
)

create table Peliculas --Bien
(
	id_pelicula int identity (1,1),
	titulo varchar (100) not null,
	duracion int not null,
	fecha_estreno datetime,
	fecha_cierre datetime,
	id_idioma int not null,
	id_genero int not null,
	id_formato int not null,
	id_clasificacion int not null,
	constraint pk_id_pelicula primary key (id_pelicula),
	constraint fk_id_idioma foreign key (id_idioma) references Idiomas (id_idioma),
	constraint fk_id_formato foreign key (id_formato) references Formatos_Peliculas (id_formato),
	constraint fk_id_clasificacion foreign key (id_clasificacion) references Clasificacion_Peliculas (id_clasificacion),
	constraint fk_id_genero foreign key (id_genero) references Generos (id_genero)
)

create table Actores_Peliculas --Bien pero hay que agregarla a la normalización. LISTO
(
	--id_actor_pelicula int identity (1,1),
	id_actor int not null,
	id_pelicula int not null,
	--constraint pk_id_reparto_pelicula primary key (id_actor_pelicula),
	constraint pk_id_reparto_pelicula primary key (id_actor, id_pelicula),
	constraint fk_id_actor foreign key (id_actor) references Actores (id_actor),
	constraint fk_id_pelicula foreign key (id_pelicula) references Peliculas (id_pelicula)
)

create table Tipo_Salas --Bien
(
	id_tipo_sala int identity(1,1),
	descripcion varchar (10) not null,
	constraint pk_id_tipoSala primary key (id_tipo_sala)
)

create table Salas --No coincide con la normalización
(
	id_sala int identity(1,1),
	--sala varchar (10) not null, No está incluído en la normalización
	cant_butacas int not null,
	id_tipo_sala int not null,
	constraint pk_id_sala primary key (id_sala),
	constraint fk_id_tipo_sala foreign key (id_tipo_sala) references Tipo_Salas (id_tipo_sala)
)

create table Butacas --Hay que agregarlo a la normalización. LISTO.
(   
    id_butaca int identity (1,1),
	butaca varchar (50) not null, --Qué ponemos acá?
	id_sala int not null,
	constraint pk_id_butaca primary key (id_butaca),
	constraint fk_id_sala foreign key (id_sala) references Salas (id_sala)
)

create table Tipos_Doc --Bien
(
	id_tipo_doc int identity (1,1),
	tipoDoc varchar (30) not null,
	constraint pk_id_tipo_doc primary key (id_tipo_doc)
)

create table Clientes --Bien
(
    id_cliente int identity(1,1),
	nom_cliente varchar (50) not null,
	ape_cliente varchar (50) not null,
	id_tipo_doc int not null,
	nro_doc int not null,
	telefono varchar (50),
	email varchar (50),
	constraint pk_id_cliente primary key (id_cliente),
	constraint fk_id_tipo_doc foreign key (id_tipo_doc) references Tipos_Doc (id_tipo_doc)
)

create table Tipos_Reservas --Bien
(
    id_tipo_reserva int identity (1,1),
	descripcion_reserva varchar (50) not null,
	constraint pk_id_tipo_reserva primary key (id_tipo_reserva)
)

create table Tipos_Publico --Agregado. Bien.
(
	id_tipo_publico int,
	descripcion varchar(50)
	constraint pk_id_tipo_publico primary key (id_tipo_publico)
)

create table Promociones --No tiene el campo "Tipos_Publico" de la normalización. Tampoco existe esa tabla. LISTO
(
    id_promocion int identity (1,1),
	detalle_promocion varchar (100) not null,
	fecha_desde datetime,
	fecha_hasta datetime,
	hora_desde datetime,
	hora_hasta datetime,
	id_tipo_publico int,
	descuento int not null, --Campo agregado que no está en la normalización
	constraint pk_id_promocion primary key (id_promocion),
	constraint fk_id_tipo_publico foreign key (id_tipo_publico) references Tipos_Publico (id_tipo_publico)
)

create table Formas_Pago --Bien
(
    id_forma_pago int identity (1,1),
	descripcion varchar (50) not null,
	constraint pk_forma_pago primary key (id_forma_pago)
)

create table Barrios --Bien
(
	id_barrio int identity(1,1),
	barrio varchar (100) not null,
	constraint pk_id_barrio primary key (id_barrio),
)

create table Sucursales --Bien
(
	id_sucursal int identity (1,1),
	calle varchar (50) not null,
	nro_calle varchar (50) not null,
	id_barrio int not null,
	constraint pk_id_sucursal primary key (id_sucursal),
	constraint fk_id_barrio foreign key (id_barrio) references Barrios (id_barrio)
)

create table Vendedores --Bien
(
	id_vendedor int identity(1,1),
	nom_vendedor varchar (50) not null,
	ape_vendedor varchar (50) not null,
	id_tipo_doc int not null,
	nro_doc int not null,
	id_barrio int not null,
	telefono varchar (50) not null,
	email varchar (50),
	constraint pk_id_vendedor primary key (id_vendedor),
	constraint fk_id_barrio2 foreign key (id_barrio) references Barrios (id_barrio),
	constraint fk_id_tipo_doc2 foreign key (id_tipo_doc) references Tipos_Doc (id_tipo_doc)
)

create table Vendedores_Sucursales --No coincide con la normalización. LISTO
(
    --id_vendedor_sucursal int identity (1,1),
	id_vendedor int not null,
	id_sucursal int not null,
	constraint pk_vendedor_sucursal primary key (id_vendedor, id_sucursal),
	constraint fk_id_vendedor foreign key (id_vendedor) references Vendedores (id_vendedor),
	constraint fk_id_sucursal foreign key (id_sucursal) references Sucursales (id_sucursal)
)

create table Funciones --Falta el campo precio. LISTO.
(
    id_funcion int identity (1,1),
	fecha datetime,
	horario_funcion datetime,
	--horario_fin datetime, No coincide con la normalización
	id_sala int not null,
	id_pelicula int not null,
	precio money, --Agregado para que coincida con la normalización.
	constraint pk_id_funcion primary key (id_funcion),
	constraint fk_id_sala2 foreign key (id_sala) references Salas (id_sala),
	constraint fk_id_pelicula2 foreign key (id_pelicula) references Peliculas (id_pelicula)
)

create table Reservas --Bien
(
    id_reserva int identity (1,1),
	reserva varchar (50) not null,
	id_funcion int not null,
	id_butaca int not null,
	id_cliente int not null,
	id_tipo_reserva int not null,
	constraint pk_id_reserva primary key (id_reserva),
	constraint fk_id_funcion2 foreign key (id_funcion) references Funciones (id_funcion),
	constraint fk_id_butaca foreign key (id_butaca) references Butacas (id_butaca),
	constraint fk_id_cliente2 foreign key (id_cliente) references Clientes (id_cliente),
	constraint fk_id_tipo_reserva foreign key (id_tipo_reserva) references Tipos_Reservas (id_tipo_reserva)
)

create table Tickets --Bien
(
    id_ticket int identity (1,1),
	fecha datetime,
	hora datetime,
	id_cliente int not null,
	id_vendedor int not null,
	id_sucursal int not null,
	constraint pk_id_ticket primary key (id_ticket),
	constraint fk_id_cliente foreign key (id_cliente) references Clientes (id_cliente),
	constraint fk_id_vendedor2 foreign key (id_vendedor) references Vendedores (id_vendedor),
	constraint fk_id_sucursal2 foreign key (id_sucursal) references Sucursales (id_sucursal)
)

create table Detalle_Ventas --Modificado. LISTO
(
	id_detalle_venta int identity (1,1),
	precio_Subtotal money not null, --Modificado. No puede tener precio total si es un detalle. En todo caso sería subtotal.
	id_ticket int not null,
	id_funcion int not null,
	id_promocion int not null,
	id_forma_pago int not null,
	--Si incluímos la butaca como en la normalización, entonces falta ese campo?
	constraint pk_id_detalle_venta primary key (id_detalle_venta),
	constraint fk_id_ticket foreign key (id_ticket) references Tickets (id_ticket),
	constraint fk_id_funcion foreign key (id_funcion) references Funciones (id_funcion),
	constraint fk_id_promocion foreign key (id_promocion) references Promociones (id_promocion),
	constraint fk_id_forma_pago foreign key (id_forma_pago) references Formas_Pago (id_forma_pago)
)