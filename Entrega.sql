CREATE DATABASE IF NOT EXISTS empreasc;
USE empreasc;

CREATE TABLE IF NOT EXISTS cliente (
  id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  ubicacion VARCHAR(200) NOT NULL,
  mail VARCHAR(100) UNIQUE
);

CREATE TABLE IF NOT EXISTS empleado (
  id_empleado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  mail VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS tecnico (
  n_tec INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  telefono VARCHAR(20) UNIQUE
);

CREATE TABLE IF NOT EXISTS modelo_ascensor (
  cod_modelo VARCHAR(10) NOT NULL PRIMARY KEY,
  especificacion VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS ascensor (
  id_asc INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cod_modelo VARCHAR(10) NOT NULL,
  FOREIGN KEY (cod_modelo) REFERENCES modelo_ascensor (cod_modelo)
);

CREATE TABLE IF NOT EXISTS venta (
  id_venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fecha_venta DATE NOT NULL,
  id_cliente INT NOT NULL,
  id_empleado INT NOT NULL,
  monto_total DECIMAL(10,2) NOT NULL,
  ubicacion_snapshot VARCHAR(200),
  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
  FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado)
);

CREATE TABLE IF NOT EXISTS detalle_venta (
  id_detalle INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  id_venta INT NOT NULL,
  id_asc INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  UNIQUE (id_venta, id_asc),
  FOREIGN KEY (id_venta) REFERENCES venta (id_venta),
  FOREIGN KEY (id_asc) REFERENCES ascensor (id_asc)
);

CREATE TABLE IF NOT EXISTS instalacion (
  id_inst INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fecha_inst DATE NOT NULL,
  id_asc INT NOT NULL,
  id_tecnico INT NOT NULL,
  ubicacion_snapshot VARCHAR(200),
  FOREIGN KEY (id_asc) REFERENCES ascensor (id_asc),
  FOREIGN KEY (id_tecnico) REFERENCES tecnico (n_tec)
);

CREATE TABLE IF NOT EXISTS mantenimiento (
  id_mant INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fecha_mant DATE NOT NULL,
  id_asc INT NOT NULL,
  id_tecnico INT NOT NULL,
  detalles VARCHAR(200),
  ubicacion_snapshot VARCHAR(200),
  FOREIGN KEY (id_asc) REFERENCES ascensor (id_asc),
  FOREIGN KEY (id_tecnico) REFERENCES tecnico (n_tec)
);
