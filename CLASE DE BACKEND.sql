/*

DROP TABLE IF EXISTS PAGOS;
DROP TABLE IF EXISTS DEUDA;
DROP TABLE IF EXISTS BDPRODUCTO;
DROP TABLE IF EXISTS MONEDAS;
DROP TABLE IF EXISTS GESTIONES;
DROP TABLE IF EXISTS USUARIOS
DROP TABLE IF EXISTS CORREOS;
DROP TABLE IF EXISTS TELEFONOS;
DROP TABLE IF EXISTS RLABORAL;
DROP TABLE IF EXISTS PROPIEDAD;
DROP TABLE IF EXISTS CLIENTE;

*/
--DATOS PRINCIPALES DE LOS CLIENTES
CREATE TABLE CLIENTE(
CLIENTEID INT PRIMARY KEY IDENTITY(1,1),
DOCUMENTO NVARCHAR(8),
APELLIDOS_Y_NOMBRE NVARCHAR(MAX),
EDAD NVARCHAR(2),
DIRECCION NVARCHAR(MAX),
DISTRITO NVARCHAR(50)
)

--INSERTAMOS VALORES A LA TABLA
INSERT INTO CLIENTE (DOCUMENTO, APELLIDOS_Y_NOMBRE, EDAD, DIRECCION, DISTRITO)
VALUES
('00000001','ARTURO PE�A','23','AV COSTANERA 222','SAN MIGUEL'),
('00000002','JOSE BENIEZ','29','AV DANIEL VALVERDE 245','ATE'),
('00000003','JESUS FRANCO','25','AV ANTONIO GRAU 343','LOS OLIVOS'),
('00000004','PAMELA CASTILLO','43','AV LOS JASMINES 773','BRE�A'),
('00000005','ANDREINA VELASQUEZ','53','AV JOSE FELIPE 243','JESUS MARIA'),
('00000006','CRISTINA CONTRERAS','27','AV MIGUEL GRAU 221','LIMA'),
('00000007','SEBASTIAN RODRIGUEZ','23','JR TACNA 477','CALLAO'),
('00000008','YANIBEL VIERA','19','AV LOS ANGELES 1773','SURCO'),
('00000009','CAROLINA LOAIZA','64','AV ARENALES 2454','LINCE'),
('00000010','WILSON MORENO','25','AV LOS TULIPANES 234','MIRAFLORES')

SELECT * FROM CLIENTE

-- TABLA PARA ALMACENAR NUMERO DE LOS CLIENTES
CREATE TABLE TELEFONOS (
TELEFONOID INT PRIMARY KEY IDENTITY(1,1),
CLIENTEID INT,
CODIGO_DE_AREA NVARCHAR(5),
TIPO NVARCHAR(10),
NUMERO NVARCHAR(9),
CONSTRAINT FK_TELEFONOS_CLIENTE FOREIGN KEY (CLIENTEID) REFERENCES CLIENTE(CLIENTEID)
)

-- INSERTAR TELEFONOS DE CLIENTE
INSERT INTO TELEFONOS
VALUES
('1','0','CELULAR','999999001'),
('2','0','CELULAR','999999002'),
('3','0','CELULAR','999999003'),
('4','0','CELULAR','999999004'),
('5','0','CELULAR','999999005'),
('6','0','CELULAR','999999006'),
('7','0','CELULAR','999999007'),
('8','0','CELULAR','999999008'),
('9','0','CELULAR','999999009'),
('10','0','CELULAR','999999010')

SELECT * FROM TELEFONOS

-- TABLA PARA ALMACENAR CORREOS
CREATE TABLE CORREOS(
CORREOID INT PRIMARY KEY IDENTITY(1,1),
CLIENTEID INT,
TIPO NVARCHAR(100),
CORREO NVARCHAR(100),
CONSTRAINT FK_CORREOS_CLIENTE FOREIGN KEY (CLIENTEID) REFERENCES CLIENTE(CLIENTEID)
)

-- INSERTAR CORREOS DE CLIENTE
INSERT INTO CORREOS
VALUES
('1','PERSONAL','arturo@gmai.com'),
('2','OFICINA','joseo@gmai.com'),
('3','OFICINA','jesuso@gmai.com'),
('4','PERSONAL','pamelao@gmai.com'),
('5','OFICINA','andreinao@gmai.com'),
('6','OFICINA','cristinao@gmai.com'),
('7','PERSONAL','sebastiano@gmai.com'),
('8','OFICINA','yanibelo@gmai.com'),
('9','OFICINA','carolinao@gmai.com'),
('10','PERSONAL','wilsono@gmai.com')

SELECT * FROM CORREOS

-- TABLA PARA PRODCUTOS QUE MANEJA 
CREATE TABLE BDPRODUCTO (
BDPRODUCTOID INT PRIMARY KEY IDENTITY(1,1),
PRODUCTO NVARCHAR(20)
)

-- INSERTAR PRODUCTOS
INSERT INTO BDPRODUCTO(PRODUCTO)
VALUES
('TARJETA'),
('PRESTAMO'),
('CONVENIO'),
('VEHICULAR')

SELECT * FROM BDPRODUCTO

-- TABLA PARA LAS MONEDAS
CREATE TABLE MONEDAS (
MONEDAID INT PRIMARY KEY IDENTITY(1,1),
MONEDA NVARCHAR(3)
)

-- INSERTAR MONEDAS
INSERT INTO MONEDAS 
VALUES
('SOL'),
('USD')

-- TABLA PARA ALMACENAR DEUDA
CREATE TABLE DEUDA (
DEUDAID INT PRIMARY KEY IDENTITY(1,1),
CLIENTEID INT,
BDPRODUCTOID INT,
CUENTA NVARCHAR(30),
MONEDAID INT,
CAPITAL DECIMAL(10, 2),
INTERESES DECIMAL(10, 2),
TOTAL DECIMAL (10, 2),
CONSTRAINT FK_DEUDA_CLIENTE FOREIGN KEY (CLIENTEID) REFERENCES CLIENTE(CLIENTEID),
CONSTRAINT FK_DEUDA_BDPRODUCTOID FOREIGN KEY (BDPRODUCTOID) REFERENCES BDPRODUCTO(BDPRODUCTOID),
CONSTRAINT FK_DEUDA_MONEDA FOREIGN KEY (MONEDAID) REFERENCES MONEDAS(MONEDAID)
)

-- INSERTA DEUDAS DEL CLIENTE
INSERT INTO DEUDA
VALUES
(1,1,'4900000050339801',1,10800.87,3200.23,0),
(1,1,'4900000050339801',2,1800.87,300.23,0),
(2,2,'2231000001',1,639.90,172.09,0),
(3,3,'2232000002',2,58300.23,8239.88,0),
(3,4,'2233000003',1,2332.98,458.98,0),
(5,3,'2232000004',2,76389.23,2234.98,0),
(6,2,'2231000005',2,1983.98,837.23,0),
(7,4,'2233000006',1,6482.32,2343.23,0),
(8,1,'4900000050339802',1,33832.23,4674.34,0),
(9,3,'2232000007',1,102345.23,12345.31,0),
(10,2,'2231000008',1,862.23,234.02,0)

UPDATE DEUDA SET TOTAL = CAPITAL + INTERESES
SELECT * FROM DEUDA

-- TABLA PARA PAGOS DEL CLIENTE
CREATE TABLE PAGOS(
PAGOID INT PRIMARY KEY IDENTITY (1,1),
CLIENTEID INT,
DEUDAID INT,
FECHA_PAGO DATE,
IMPORTE DECIMAL(10,2),
TIPO_PAGO NVARCHAR(16),-- CANCELACION / FRACCIONAMIENTO / CANCEALCION
MEDIO_PAGO NVARCHAR(15), -- OFICIA - OTROS MEDIOS
ESTADO NVARCHAR(10) -- PENDIENTE / APLICADO
CONSTRAINT FK_PAGOS_CLIENTE FOREIGN KEY (CLIENTEID) REFERENCES CLIENTE(CLIENTEID),
CONSTRAINT FK_PAGOS_DEUDA FOREIGN KEY (DEUDAID) REFERENCES DEUDA(DEUDAID)
)

--SELECT * FROM PAGOS
--SELECT * FROM DEUDA WHERE DEUDAID = '1'
-- INSERTAR PAGOS DEL CLIENTE
INSERT INTO PAGOS
VALUES
(1,1,'07-09-2023',3800.33,'ABONO','OFICINA','PENDIENTE'), -- FORMATO FECHA 'MM-DD-YYYY'
(1,2,'07-09-2023',900,'FRACCIONAMIENTO','OFICINA','PENDIENTE'),
(2,3,'02-03-2023',23,'ABONO','OFICINA','PENDIENTE'),
(3,4,'08-09-2024',7893.3,'ABONO','OTROS MEDIOS','PENDIENTE'),
(4,5,'08-09-2024',132.23,'ABONO','OTROS MEDIOS','PENDIENTE'),
(5,6,'08-09-2024',20344.34,'ABONO','OFICINA','PENDIENTE'),
(6,7,'08-09-2024',677,'FRACCIONAMIENTO','OFICINA','PENDIENTE'),
(7,8,'08-09-2024',100,'ABONO','OTROS MEDIOS','PENDIENTE'),
(8,9,'08-09-2024',10000.33,'FRACCIONAMIENTO','OFICINA','PENDIENTE'),
(9,10,'08-09-2024',5679.45,'ABONO','OTROS MEDIOS','PENDIENTE'),
(10,11,'08-09-2024',46.34,'FRACCIONAMIENTO','OFICINA','PENDIENTE')

-- TABLA PARA USUARIOS
CREATE TABLE USUARIOS(
USUARIOID INT PRIMARY KEY IDENTITY(1,1),
NOMBRE_APELLIDO NVARCHAR(50),
USUARIO NVARCHAR(50),
ESTADO NVARCHAR(10) -- ACTIVO / INACTIVO
)

-- INSERTAR USUARIO
INSERT INTO USUARIOS
VALUES 
('ANOTONIO JUAREZ','AJUAREZ', 'ACTIVO'),
('RENATO GONZALES','RGONZALES', 'ACTIVO'),
('ANGEL OSORIO','AOSORIO', 'ACTIVO'),
('ARIANA JARA','AJARA', 'ACTIVO'),
('MARIA PEREZ','MPEREZ', 'ACTIVO')

SELECT * FROM USUARIOS

-- TABLA PARA GESTIONES
CREATE TABLE GESTIONES(
GESTIONESID INT PRIMARY KEY IDENTITY(1,1),
CLIENTEID INT,
FECHA_GESTION DATE,
USUARIOID INT, --VOLVER ESTO UN ID DE LA TABLA USUSARIOS
MOTIVO NVARCHAR(15), -- LLAMADA / CORREO / MENSAJE / WHATSAPP / VISITA
CONTACTO NVARCHAR(20), -- TITULAR / CODEUDADO / CONYUGE / FAMILIAR 
EFECTO NVARCHAR(50), -- CLIENTE PAGO / PAGO A CUENTA / PROMESA / SEGUIMIENTO / DIFICULTA DE PAGO / SIN COMPROMISO / SE DEJO INFORMACION
TELEFONOID INT, 
CORREOID INT, 
COMENTARIO NVARCHAR(MAX)
CONSTRAINT FK_GESTIONES_CLIENTE FOREIGN KEY (CLIENTEID) REFERENCES CLIENTE(CLIENTEID),
CONSTRAINT FK_GESTIONES_USUARIO FOREIGN KEY (USUARIOID) REFERENCES USUARIOS(USUARIOID),
CONSTRAINT FK_GESTIONES_TELEFONO FOREIGN KEY (TELEFONOID) REFERENCES TELEFONOS(TELEFONOID),
CONSTRAINT FK_GESTIONES_CORREO FOREIGN KEY (CORREOID) REFERENCES CORREOS(CORREOID)
)

-- INSERTAR GESTIONES
INSERT INTO GESTIONES
VALUES
(1,'12-08-2023',1,'LLAMADA','TITULAR','CLIENTE PAGO',1,1,'CLIENTE REALIZO EL PAGO'), -- FORMATO FECHA 'MM-DD-YYYY'
(2,'12-09-2023',2,'CORREO','CODEUDO','PAGO A CUENTA',2,2,'CODEUDO ABONA A LA DEUDA'),
(3,'12-10-2023',3,'MENSAJE','CONYUGE','PROMESA',3,3,'ESPOSA DEL TITULAR REALIZAR PAGO DE LA DEUDA'),
(4,'12-11-2023',4,'WHATSAPP','FAMILIAR','SE DEJO MENSAJE',4,4,'SE DEJA MENSAJE CON FAMILIAR DEL TT'),
(5,'12-12-2023',5,'VISITA','TITULAR','DIFICULTA DE PAGO',5,5,'CLIENTE NO CUENTA CON TRABAJO, NO PODRA ABONAR LA PROXIMA CUENTA EN LA FECHA'),
(6,'12-13-2023',1,'LLAMADA','CODEUDO','SIN COMPROMISO',6,6,'CLIENTE NO TIENE INTENSIONES DE PAGAR'),
(7,'12-14-2023',2,'CORREO','CONYUGE','SE DEJO MENSAJE',7,7,'SE DEJO MENSAJE CON EL CONYUGE DEL TITULAR'),
(8,'12-15-2023',3,'MENSAJE','FAMILIAR','SE DEJO MENSAJE',8,8,'SE DEJO MENSAJE CON MADRE DEL CLIENTE'),
(9,'12-16-2023',4,'WHATSAPP','TITULAR','SIN COMPROMISO',9,9,'CLIENTE BLOQUEA WSP NO TIENE INTENSION DE PAGO'),
(10,'12-17-2023',5,'VISITA','CODEUDO','SEGUIMIENTO',10,10,'SE VISITO A TITULAR A SU DOMICILIO, ATENDIO CODEUDO DE LA CUENTA INDICA QUE VERA LA MANERA DE CANCELAR TODO AL CONTADO')

/*
SELECT * FROM CLIENTE
LEFT JOIN GESTIONES
ON CLIENTE.CLIENTEID = GESTIONES.CLIENTEID
*/

-- TABLA PARA RESUMEN LABORAL
CREATE TABLE RLABORAL(
RLABORALID INT PRIMARY KEY IDENTITY(1,1),
CLIENTEID INT,
RUC NVARCHAR(11),
RAZON_SOCIAL NVARCHAR(150),
DIRECCION NVARCHAR(300),
DESCUENTO NVARCHAR(2), --  SI / NO
ESTADO NVARCHAR(8) -- ACTIVO / INACTIVO
CONSTRAINT FK_RLABORAL_CLIENTE FOREIGN KEY (CLIENTEID) REFERENCES CLIENTE(CLIENTEID)
)
-- INSERTAR RESUMEN LABORAL
INSERT INTO RLABORAL
VALUES
(1,'20000000001','BBVA','AV JAVIER PRADO 233','NO','ACTIVO'),
(2,'20000000002','BCP','AV COLONIAL 1200','NO','ACITVO'),
(3,'20000000003','ALICORP','AV ARGENTINA 2220','SI','ACTIVO'),
(4,'20000000004','PANDO','AV JAVIER PRADO 1120','NO','INACTIVO'),
(5,'20000000005','PANAERIA ARCOIRIS','AV LOS ALISOS 2356','NO','ACTIVO'),
(6,'20000000006','LINEA DE BUS LIMA','AV TACNA 2773','NO','INACTIVO'),
(7,'20000000007','MTC','JR JUNIN 923','NO','ACTIVO'),
(8,'20000000008','MIGRACIONES','AV ESPA�A 1323','NO','INACTIVO'),
(9,'20000000009','NOTARIA RODRIGUEZ','AV AVIACION 2283','NO','ACTIVO'),
(10,'20000000010','SYSTEM GROUP','AV REPUBLICA DE PANAMA 1223','SI','ACTIVO')

-- TABLA PARA REGISTRO DE CASA
CREATE TABLE PROPIEDAD(
PROPIEDADID INT PRIMARY KEY IDENTITY(1,1),
CLIENTEID INT,
PARTIDA NVARCHAR(20),
OFICINA NVARCHAR(50),
ZONA NVARCHAR(50),
DIRECCION NVARCHAR(200),
GARANTIA NVARCHAR(2) -- SI / NO
CONSTRAINT FK_PROPIEDAD_CLIENTE FOREIGN KEY (CLIENTEID) REFERENCES CLIENTE(CLIENTEID)
)
-- INSERTAR PARA REGISTRO DE CASA
INSERT INTO PROPIEDAD
VALUES 
(1,'1002001','LIMA','JESUS MARIA','','SI'),
(3,'1001009','LIMA','LINCE','','SI'),
(5,'1008009','LIMA','SAN MIGUEL','','NO'),
(8,'1003005','LIMA','BRE�A','','NO'),
(2,'1007004','LIMA','SAN ISIDRO','','NO')

-- TABLA PARA REGISTRO DE VEHICULOS 
CREATE TABLE VEHICULOS(
VEHICULOID INT PRIMARY KEY IDENTITY(1,1),
CLIENTEID INT,
PARTIDA NVARCHAR(20),
MARCA NVARCHAR(30),
MODELO NVARCHAR(30),
PLACA NVARCHAR(10),
GARANTIA NVARCHAR(2) -- SI / NO
CONSTRAINT FK_VEHICULOS_CLIENTE FOREIGN KEY (CLIENTEID) REFERENCES  CLIENTE(CLIENTEID)
)
-- INSERTAR PARA REGISTRO DE VEHICULOS
INSERT INTO VEHICULOS(
)

--
--
