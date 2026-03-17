USE empreasc;

-- CLIENTES

INSERT INTO cliente (nombre, ubicacion, mail) VALUES
('Edificio Central', 'Av. Corrientes 1200, CABA', 'central@mail.com'),
('Torre Norte', 'Av. Santa Fe 3400, CABA', 'torre@mail.com'),
('Oficinas Belgrano', 'Av. Cabildo 2100, CABA', 'belgrano@mail.com');


-- EMPLEADOS

INSERT INTO empleado (nombre, apellido, mail) VALUES
('Carlos', 'Lopez', 'clopez@empresa.com'),
('Maria', 'Gomez', 'mgomez@empresa.com');


-- TECNICOS

INSERT INTO tecnico (nombre, apellido, telefono) VALUES
('Juan', 'Perez', '1134567890'),
('Luis', 'Martinez', '1145678901'),
('Diego', 'Suarez', '1156789012');


-- MODELOS DE ASCENSOR

INSERT INTO modelo_ascensor (cod_modelo, especificacion) VALUES
('OTIS100', 'Ascensor 10 pisos 8 personas'),
('SCH200', 'Ascensor 15 pisos 10 personas'),
('HYU300', 'Ascensor 20 pisos 12 personas');


-- ASCENSORES (UNIDADES)

INSERT INTO ascensor (cod_modelo) VALUES
('OTIS100'),
('OTIS100'),
('SCH200'),
('HYU300'),
('HYU300');


-- VENTAS

INSERT INTO venta (fecha_venta, id_cliente, id_empleado, monto_total) VALUES
('2026-01-10', 1, 1, 50000.00),
('2026-02-15', 2, 2, 75000.00),
('2026-03-20', 3, 1, 90000.00);


-- DETALLE DE VENTA

INSERT INTO detalle_venta (id_venta, id_asc, precio_unitario) VALUES
(1, 1, 50000.00),
(2, 3, 75000.00),
(3, 4, 90000.00);


-- INSTALACIONES

INSERT INTO instalacion (fecha_inst, id_asc, id_tecnico, ubicacion_snapshot) VALUES
('2026-01-20', 1, 1, 'Av. Corrientes 1200, CABA'),
('2026-02-25', 3, 2, 'Av. Santa Fe 3400, CABA'),
('2026-03-28', 4, 3, 'Av. Cabildo 2100, CABA');


-- MANTENIMIENTOS

INSERT INTO mantenimiento (fecha_mant, id_asc, id_tecnico, detalles, ubicacion_snapshot) VALUES
('2026-04-10', 1, 1, 'Revisión general', 'Av. Corrientes 1200, CABA'),
('2026-04-20', 1, 2, 'Lubricación de cables', 'Av. Corrientes 1200, CABA'),
('2026-05-05', 3, 2, 'Cambio de sensor de puerta', 'Av. Santa Fe 3400, CABA'),
('2026-05-15', 4, 3, 'Revisión de motor', 'Av. Cabildo 2100, CABA');