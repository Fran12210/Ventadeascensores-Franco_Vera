CREATE DATABASE  IF NOT EXISTS `empreasc` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `empreasc`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: empreasc
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ascensor`
--

DROP TABLE IF EXISTS `ascensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ascensor` (
  `id_asc` int NOT NULL AUTO_INCREMENT,
  `cod_modelo` varchar(10) NOT NULL,
  PRIMARY KEY (`id_asc`),
  KEY `cod_modelo` (`cod_modelo`),
  CONSTRAINT `ascensor_ibfk_1` FOREIGN KEY (`cod_modelo`) REFERENCES `modelo_ascensor` (`cod_modelo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ascensor`
--

LOCK TABLES `ascensor` WRITE;
/*!40000 ALTER TABLE `ascensor` DISABLE KEYS */;
INSERT INTO `ascensor` VALUES (4,'HYU300'),(5,'HYU300'),(1,'OTIS100'),(2,'OTIS100'),(3,'SCH200');
/*!40000 ALTER TABLE `ascensor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `ubicacion` varchar(200) NOT NULL,
  `mail` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Edificio Central','Av. Corrientes 1200, CABA','central@mail.com'),(2,'Torre Norte','Av. Santa Fe 3400, CABA','torre@mail.com'),(3,'Oficinas Belgrano','Av. Cabildo 2100, CABA','belgrano@mail.com');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_venta` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NOT NULL,
  `id_asc` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  UNIQUE KEY `id_venta` (`id_venta`,`id_asc`),
  KEY `id_asc` (`id_asc`),
  CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `venta` (`id_venta`),
  CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`id_asc`) REFERENCES `ascensor` (`id_asc`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
INSERT INTO `detalle_venta` VALUES (1,1,1,50000.00),(2,2,3,75000.00),(3,3,4,90000.00),(4,1,2,10000.00),(6,1,3,15000.00),(8,2,2,15000.00);
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_actualizar_monto_venta` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
    UPDATE venta
    SET monto_total = (
        SELECT SUM(precio_unitario)
        FROM detalle_venta
        WHERE id_venta = NEW.id_venta
    )
    WHERE id_venta = NEW.id_venta;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `mail` varchar(100) NOT NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (1,'Carlos','Lopez','clopez@empresa.com'),(2,'Maria','Gomez','mgomez@empresa.com');
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instalacion`
--

DROP TABLE IF EXISTS `instalacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instalacion` (
  `id_inst` int NOT NULL AUTO_INCREMENT,
  `fecha_inst` date NOT NULL,
  `id_asc` int NOT NULL,
  `id_tecnico` int NOT NULL,
  `ubicacion_snapshot` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_inst`),
  KEY `id_asc` (`id_asc`),
  KEY `id_tecnico` (`id_tecnico`),
  CONSTRAINT `instalacion_ibfk_1` FOREIGN KEY (`id_asc`) REFERENCES `ascensor` (`id_asc`),
  CONSTRAINT `instalacion_ibfk_2` FOREIGN KEY (`id_tecnico`) REFERENCES `tecnico` (`n_tec`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instalacion`
--

LOCK TABLES `instalacion` WRITE;
/*!40000 ALTER TABLE `instalacion` DISABLE KEYS */;
INSERT INTO `instalacion` VALUES (1,'2026-01-20',1,1,'Av. Corrientes 1200, CABA'),(2,'2026-02-25',3,2,'Av. Santa Fe 3400, CABA'),(3,'2026-03-28',4,3,'Av. Cabildo 2100, CABA'),(4,'2026-06-10',1,1,'Av. Corrientes 1200, CABA'),(5,'2026-06-20',1,1,'Av. Corrientes 1200, CABA');
/*!40000 ALTER TABLE `instalacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_instalacion` BEFORE INSERT ON `instalacion` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `mantenimiento`
--

DROP TABLE IF EXISTS `mantenimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mantenimiento` (
  `id_mant` int NOT NULL AUTO_INCREMENT,
  `fecha_mant` date NOT NULL,
  `id_asc` int NOT NULL,
  `id_tecnico` int NOT NULL,
  `detalles` varchar(200) DEFAULT NULL,
  `ubicacion_snapshot` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_mant`),
  KEY `id_asc` (`id_asc`),
  KEY `id_tecnico` (`id_tecnico`),
  CONSTRAINT `mantenimiento_ibfk_1` FOREIGN KEY (`id_asc`) REFERENCES `ascensor` (`id_asc`),
  CONSTRAINT `mantenimiento_ibfk_2` FOREIGN KEY (`id_tecnico`) REFERENCES `tecnico` (`n_tec`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mantenimiento`
--

LOCK TABLES `mantenimiento` WRITE;
/*!40000 ALTER TABLE `mantenimiento` DISABLE KEYS */;
INSERT INTO `mantenimiento` VALUES (1,'2026-04-10',1,1,'Revisión general','Av. Corrientes 1200, CABA'),(2,'2026-04-20',1,2,'Lubricación de cables','Av. Corrientes 1200, CABA'),(3,'2026-05-05',3,2,'Cambio de sensor de puerta','Av. Santa Fe 3400, CABA'),(4,'2026-05-15',4,3,'Revisión de motor','Av. Cabildo 2100, CABA'),(5,'2026-06-15',1,2,'Revisión mensual','Av. Corrientes 1200, CABA'),(6,'2026-06-25',2,3,'Chequeo general',NULL),(7,'2026-06-25',1,1,'Chequeo general',NULL),(8,'2026-06-25',1,1,'Chequeo general','Av. Corrientes 1200, CABA');
/*!40000 ALTER TABLE `mantenimiento` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_mantenimiento` BEFORE INSERT ON `mantenimiento` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `modelo_ascensor`
--

DROP TABLE IF EXISTS `modelo_ascensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modelo_ascensor` (
  `cod_modelo` varchar(10) NOT NULL,
  `especificacion` varchar(200) NOT NULL,
  PRIMARY KEY (`cod_modelo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modelo_ascensor`
--

LOCK TABLES `modelo_ascensor` WRITE;
/*!40000 ALTER TABLE `modelo_ascensor` DISABLE KEYS */;
INSERT INTO `modelo_ascensor` VALUES ('HYU300','Ascensor 20 pisos 12 personas'),('OTIS100','Ascensor 10 pisos 8 personas'),('SCH200','Ascensor 15 pisos 10 personas');
/*!40000 ALTER TABLE `modelo_ascensor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tecnico`
--

DROP TABLE IF EXISTS `tecnico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tecnico` (
  `n_tec` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`n_tec`),
  UNIQUE KEY `telefono` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tecnico`
--

LOCK TABLES `tecnico` WRITE;
/*!40000 ALTER TABLE `tecnico` DISABLE KEYS */;
INSERT INTO `tecnico` VALUES (1,'Juan','Perez','1134567890'),(2,'Luis','Martinez','1145678901'),(3,'Diego','Suarez','1156789012');
/*!40000 ALTER TABLE `tecnico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `fecha_venta` date NOT NULL,
  `id_cliente` int NOT NULL,
  `id_empleado` int NOT NULL,
  `monto_total` decimal(10,2) NOT NULL,
  `ubicacion_snapshot` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_empleado` (`id_empleado`),
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` VALUES (1,'2026-01-10',1,1,75000.00,NULL),(2,'2026-02-15',2,2,90000.00,NULL),(3,'2026-03-20',3,1,90000.00,NULL);
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_clientes_mayor_gasto`
--

DROP TABLE IF EXISTS `vista_clientes_mayor_gasto`;
/*!50001 DROP VIEW IF EXISTS `vista_clientes_mayor_gasto`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_clientes_mayor_gasto` AS SELECT 
 1 AS `nombre`,
 1 AS `total_gastado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_mantenimientos_recientes`
--

DROP TABLE IF EXISTS `vista_mantenimientos_recientes`;
/*!50001 DROP VIEW IF EXISTS `vista_mantenimientos_recientes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_mantenimientos_recientes` AS SELECT 
 1 AS `id_mant`,
 1 AS `fecha_mant`,
 1 AS `id_asc`,
 1 AS `cod_modelo`,
 1 AS `tecnico`,
 1 AS `apellido_tecnico`,
 1 AS `detalles`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_ventas_completas`
--

DROP TABLE IF EXISTS `vista_ventas_completas`;
/*!50001 DROP VIEW IF EXISTS `vista_ventas_completas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_ventas_completas` AS SELECT 
 1 AS `id_venta`,
 1 AS `fecha_venta`,
 1 AS `cliente`,
 1 AS `empleado`,
 1 AS `apellido_empleado`,
 1 AS `id_asc`,
 1 AS `cod_modelo`,
 1 AS `precio_unitario`,
 1 AS `monto_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'empreasc'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_cantidad_mantenimientos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_cantidad_mantenimientos`(p_id_asc INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM mantenimiento
    WHERE id_asc = p_id_asc;

    RETURN total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_total_gastado_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_total_gastado_cliente`(p_id_cliente INT) RETURNS decimal(10,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT IFNULL(SUM(monto_total), 0)
    INTO total
    FROM venta
    WHERE id_cliente = p_id_cliente;

    RETURN total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pr_registrar_instalacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_registrar_instalacion`(
    IN p_fecha_inst DATE,
    IN p_id_asc INT,
    IN p_id_tecnico INT,
    IN p_ubicacion_snapshot VARCHAR(200)
)
BEGIN
    INSERT INTO instalacion (fecha_inst, id_asc, id_tecnico, ubicacion_snapshot)
    VALUES (p_fecha_inst, p_id_asc, p_id_tecnico, p_ubicacion_snapshot);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pr_registrar_mantenimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_registrar_mantenimiento`(
    IN p_fecha_mant DATE,
    IN p_id_asc INT,
    IN p_id_tecnico INT,
    IN p_detalles VARCHAR(200),
    IN p_ubicacion_snapshot VARCHAR(200)
)
BEGIN
    INSERT INTO mantenimiento (fecha_mant, id_asc, id_tecnico, detalles, ubicacion_snapshot)
    VALUES (p_fecha_mant, p_id_asc, p_id_tecnico, p_detalles, p_ubicacion_snapshot);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vista_clientes_mayor_gasto`
--

/*!50001 DROP VIEW IF EXISTS `vista_clientes_mayor_gasto`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_clientes_mayor_gasto` AS select `c`.`nombre` AS `nombre`,sum(`v`.`monto_total`) AS `total_gastado` from (`cliente` `c` join `venta` `v` on((`c`.`id_cliente` = `v`.`id_cliente`))) group by `c`.`nombre` having (`total_gastado` > 60000) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_mantenimientos_recientes`
--

/*!50001 DROP VIEW IF EXISTS `vista_mantenimientos_recientes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_mantenimientos_recientes` AS select `mt`.`id_mant` AS `id_mant`,`mt`.`fecha_mant` AS `fecha_mant`,`a`.`id_asc` AS `id_asc`,`mo`.`cod_modelo` AS `cod_modelo`,`t`.`nombre` AS `tecnico`,`t`.`apellido` AS `apellido_tecnico`,`mt`.`detalles` AS `detalles` from (((`mantenimiento` `mt` join `ascensor` `a` on((`mt`.`id_asc` = `a`.`id_asc`))) join `modelo_ascensor` `mo` on((`a`.`cod_modelo` = `mo`.`cod_modelo`))) join `tecnico` `t` on((`mt`.`id_tecnico` = `t`.`n_tec`))) where (`mt`.`fecha_mant` >= (curdate() - interval 1 year)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_ventas_completas`
--

/*!50001 DROP VIEW IF EXISTS `vista_ventas_completas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_ventas_completas` AS select `v`.`id_venta` AS `id_venta`,`v`.`fecha_venta` AS `fecha_venta`,`c`.`nombre` AS `cliente`,`e`.`nombre` AS `empleado`,`e`.`apellido` AS `apellido_empleado`,`a`.`id_asc` AS `id_asc`,`m`.`cod_modelo` AS `cod_modelo`,`dv`.`precio_unitario` AS `precio_unitario`,`v`.`monto_total` AS `monto_total` from (((((`venta` `v` join `cliente` `c` on((`v`.`id_cliente` = `c`.`id_cliente`))) join `empleado` `e` on((`v`.`id_empleado` = `e`.`id_empleado`))) join `detalle_venta` `dv` on((`v`.`id_venta` = `dv`.`id_venta`))) join `ascensor` `a` on((`dv`.`id_asc` = `a`.`id_asc`))) join `modelo_ascensor` `m` on((`a`.`cod_modelo` = `m`.`cod_modelo`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-17 16:09:39
