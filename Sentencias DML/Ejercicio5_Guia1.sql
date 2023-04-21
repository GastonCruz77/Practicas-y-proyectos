CREATE DATABASE EJERCICIO5_GUIA1;

USE EJERCICIO5_GUIA1;

CREATE TABLE TIPOS_DOC(
id_tipo_doc int IDENTITY (1,1),
descripcion varchar(20),

CONSTRAINT pk_tipos_doc PRIMARY KEY (id_tipo_doc)
);

CREATE TABLE SOCIOS(
numero_socio int IDENTITY (1,1),
nombre varchar (15),
apellido varchar(15),
telefono int,
email varchar(30),
direccion varchar (50),
id_tipo_doc int,
numero_doc int,
fecha_nac datetime,

CONSTRAINT pk_socios PRIMARY KEY (numero_socio),
CONSTRAINT fk_socios_tipos_doc FOREIGN KEY (id_tipo_doc) REFERENCES tipos_doc (id_tipo_doc)
);

CREATE TABLE RECIBOS(
numero_recibo int IDENTITY (1,1),
fecha_recibo datetime,
numero_socio int,

CONSTRAINT pk_numero_recibo PRIMARY KEY (numero_recibo),
CONSTRAINT fk_recibos_socios FOREIGN KEY (numero_socio) REFERENCES socios (numero_socio)
);

CREATE TABLE PERIODOS(
codigo_mes int IDENTITY (1,1),
nombre_mes varchar(12),

CONSTRAINT pk_periodos PRIMARY KEY (codigo_mes)
);

CREATE TABLE TIPOS_ACT(
id_tipo_act int IDENTITY (1,1),
descripcion varchar(20),

CONSTRAINT pk_tipos_act PRIMARY KEY (id_tipo_act)
);

CREATE TABLE ACTIVIDADES(
codigo_act int IDENTITY (1,1),
nombre_act varchar(50),
descripcion varchar(100),
id_tipo_act int,
precio money,

CONSTRAINT pk_actividades PRIMARY KEY (codigo_act),
CONSTRAINT fk_actividades_tipos_act FOREIGN KEY (id_tipo_act) REFERENCES tipos_act (id_tipo_act)
);

CREATE TABLE DET_RECIBOS(
numero_detalle int IDENTITY (1,1),
numero_recibo int,
codigo_act int,
codigo_mes int,
monto money,

CONSTRAINT pk_det_recibos PRIMARY KEY (numero_detalle),
CONSTRAINT fk_det_recibos_recibos FOREIGN KEY (numero_recibo) REFERENCES recibos (numero_recibo),
CONSTRAINT fk_det_recibos_actividades FOREIGN KEY (codigo_act) REFERENCES actividades (codigo_act),
CONSTRAINT fk_det_recibos_periodos FOREIGN KEY (codigo_mes) REFERENCES periodos (codigo_mes)
);
