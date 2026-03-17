USE empreasc;


-- VISTAS


DROP VIEW IF EXISTS vista_ventas_completas;
DROP VIEW IF EXISTS vista_mantenimientos_recientes;
DROP VIEW IF EXISTS vista_clientes_mayor_gasto;



CREATE VIEW vista_ventas_completas AS
SELECT
    v.id_venta,
    v.fecha_venta,
    c.nombre AS cliente,
    e.nombre AS empleado,
    e.apellido AS apellido_empleado,
    a.id_asc,
    m.cod_modelo,
    dv.precio_unitario,
    v.monto_total
FROM venta v
JOIN cliente c ON v.id_cliente = c.id_cliente
JOIN empleado e ON v.id_empleado = e.id_empleado
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
JOIN ascensor a ON dv.id_asc = a.id_asc
JOIN modelo_ascensor m ON a.cod_modelo = m.cod_modelo;


CREATE VIEW vista_mantenimientos_recientes AS
SELECT
mt.id_mant,
mt.fecha_mant,
a.id_asc,
mo.cod_modelo,
t.nombre AS tecnico,
t.apellido AS apellido_tecnico,
mt.detalles
FROM mantenimiento mt
JOIN ascensor a ON mt.id_asc = a.id_asc
JOIN modelo_ascensor mo ON a.cod_modelo = mo.cod_modelo
JOIN tecnico t ON mt.id_tecnico = t.n_tec
WHERE mt.fecha_mant >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);


CREATE VIEW vista_clientes_mayor_gasto AS
SELECT
c.nombre,
SUM(v.monto_total) AS total_gastado
FROM cliente c
JOIN venta v ON c.id_cliente = v.id_cliente
GROUP BY c.nombre
HAVING total_gastado > 60000;


-- FUNCIONES


DROP FUNCTION IF EXISTS fn_cantidad_mantenimientos;
DROP FUNCTION IF EXISTS fn_total_gastado_cliente;

DELIMITER $$

CREATE FUNCTION fn_cantidad_mantenimientos(p_id_asc INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM mantenimiento
    WHERE id_asc = p_id_asc;

    RETURN total;
END $$

CREATE FUNCTION fn_total_gastado_cliente(p_id_cliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT IFNULL(SUM(monto_total), 0)
    INTO total
    FROM venta
    WHERE id_cliente = p_id_cliente;

    RETURN total;
END $$

DELIMITER ;


-- PROCEDIMIENTOS


DROP PROCEDURE IF EXISTS pr_registrar_instalacion;
DROP PROCEDURE IF EXISTS pr_registrar_mantenimiento;

DELIMITER $$

CREATE PROCEDURE pr_registrar_instalacion(
    IN p_fecha_inst DATE,
    IN p_id_asc INT,
    IN p_id_tecnico INT,
    IN p_ubicacion_snapshot VARCHAR(200)
)
BEGIN
    INSERT INTO instalacion (fecha_inst, id_asc, id_tecnico, ubicacion_snapshot)
    VALUES (p_fecha_inst, p_id_asc, p_id_tecnico, p_ubicacion_snapshot);
END $$

CREATE PROCEDURE pr_registrar_mantenimiento(
    IN p_fecha_mant DATE,
    IN p_id_asc INT,
    IN p_id_tecnico INT,
    IN p_detalles VARCHAR(200),
    IN p_ubicacion_snapshot VARCHAR(200)
)
BEGIN
    INSERT INTO mantenimiento (fecha_mant, id_asc, id_tecnico, detalles, ubicacion_snapshot)
    VALUES (p_fecha_mant, p_id_asc, p_id_tecnico, p_detalles, p_ubicacion_snapshot);
END $$

DELIMITER ;


-- TRIGGERS


DROP TRIGGER IF EXISTS trg_instalacion;
DROP TRIGGER IF EXISTS trg_mantenimiento;
DROP TRIGGER IF EXISTS trg_actualizar_monto_venta;


DELIMITER $$

CREATE TRIGGER trg_instalacion
BEFORE INSERT ON instalacion
FOR EACH ROW
BEGIN
    DECLARE v_ubicacion VARCHAR(200);

    IF NEW.ubicacion_snapshot IS NULL OR NEW.ubicacion_snapshot = '' THEN
        
        SELECT c.ubicacion
        INTO v_ubicacion
        FROM cliente c
        JOIN venta v ON c.id_cliente = v.id_cliente
        JOIN detalle_venta dv ON v.id_venta = dv.id_venta
        WHERE dv.id_asc = NEW.id_asc
        LIMIT 1;

        SET NEW.ubicacion_snapshot = v_ubicacion;

    END IF;
END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER trg_mantenimiento
BEFORE INSERT ON mantenimiento
FOR EACH ROW
BEGIN
    DECLARE v_ubicacion VARCHAR(200);

    IF NEW.ubicacion_snapshot IS NULL OR NEW.ubicacion_snapshot = '' THEN
        SELECT c.ubicacion
        INTO v_ubicacion
        FROM cliente c
        JOIN venta v ON c.id_cliente = v.id_cliente
        JOIN detalle_venta dv ON v.id_venta = dv.id_venta
        WHERE dv.id_asc = NEW.id_asc
        LIMIT 1;

        SET NEW.ubicacion_snapshot = v_ubicacion;
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_actualizar_monto_venta
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
    UPDATE venta
    SET monto_total = (
        SELECT SUM(precio_unitario)
        FROM detalle_venta
        WHERE id_venta = NEW.id_venta
    )
    WHERE id_venta = NEW.id_venta;
END $$

DELIMITER ;