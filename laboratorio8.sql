CREATE DATABASE  IF NOT EXISTS `lahaces` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `lahaces`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: lahaces
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `ruc` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES (1,'Fiestas Bravas','12341234'),(2,'Corporación Rustica','43214321'),(3,'Mr Juerga','98549854'),(4,'Discotecas de Los Olivos','82388238');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `descripcion` varchar(400) DEFAULT NULL,
  `path_image` varchar(100) DEFAULT NULL,
  `id_local` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idevento_UNIQUE` (`id`),
  KEY `fk_evento_local1_idx` (`id_local`),
  CONSTRAINT `fk_evento_local1` FOREIGN KEY (`id_local`) REFERENCES `local` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (1,'2023-07-28 00:00:00','Fiestas Patrias','Esta es una prueba',NULL,1),(2,'2023-08-30 00:00:00','Fiesta de San Juan',NULL,NULL,1),(3,'2023-10-12 00:00:00','Festival de la Cerveza',NULL,NULL,2),(4,'2023-06-28 00:00:00','Fiesta de Color',NULL,NULL,3);
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `local`
--

DROP TABLE IF EXISTS `local`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `local` (
  `id` int NOT NULL AUTO_INCREMENT,
  `direccion` varchar(45) DEFAULT NULL,
  `latitud` varchar(45) DEFAULT NULL,
  `longitud` varchar(45) DEFAULT NULL,
  `idEmpresa` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_local_empresa1_idx` (`idEmpresa`),
  CONSTRAINT `fk_local_empresa1` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local`
--

LOCK TABLES `local` WRITE;
/*!40000 ALTER TABLE `local` DISABLE KEYS */;
INSERT INTO `local` VALUES (1,'Calle Los Geranios 1234',NULL,NULL,1),(2,'Av Peru 4902',NULL,NULL,2),(3,'Av Argentina 1230',NULL,NULL,3),(4,'Calle Santa Barbara 853',NULL,NULL,2),(5,'Jr Las Palmeras 921',NULL,NULL,2),(6,'Av Bolivia 4012',NULL,NULL,3);
/*!40000 ALTER TABLE `local` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idTipoTicket` int NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ticket_tipo_ticket_evento1_idx` (`idTipoTicket`),
  KEY `fk_ticket_usuario1_idx` (`idUsuario`),
  CONSTRAINT `fk_ticket_tipo_ticket_evento1` FOREIGN KEY (`idTipoTicket`) REFERENCES `tipo_ticket_evento` (`id`),
  CONSTRAINT `fk_ticket_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,1,3),(2,1,4),(3,2,1),(4,2,2),(5,2,5),(6,2,6),(7,2,8),(8,3,10),(9,3,9),(10,3,8),(11,4,1),(12,4,2),(13,4,3),(14,4,4),(15,4,5);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_ticket_evento`
--

DROP TABLE IF EXISTS `tipo_ticket_evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_ticket_evento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `precio` varchar(45) DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `idEvento` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tipo_ticket_evento_evento_idx` (`idEvento`),
  CONSTRAINT `fk_tipo_ticket_evento_evento` FOREIGN KEY (`idEvento`) REFERENCES `evento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_ticket_evento`
--

LOCK TABLES `tipo_ticket_evento` WRITE;
/*!40000 ALTER TABLE `tipo_ticket_evento` DISABLE KEYS */;
INSERT INTO `tipo_ticket_evento` VALUES (1,'30',50,1),(2,'50',10,1),(3,'20',100,2),(4,'40',50,3);
/*!40000 ALTER TABLE `tipo_ticket_evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idusuario` int NOT NULL,
  `dni` varchar(45) DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `nombres` varchar(45) DEFAULT NULL,
  `apellidos` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'23812912','jaime.castillo@gmail.com','Jaime','Castillo'),(2,'02093191','christhian.quispe@gmail.com','Christhian','Quispe'),(3,'21329112','henry.gamboa@gmail.com','Henry','Gamboa'),(4,'78923191','alejandro.galvan@gmail.com','Alejandro','Galvan'),(5,'31239201','alexandra.farfan@gmail.com','Alexandra','Farfan'),(6,'13209123','adriana.loayza@gmail.com','Adriana','Loayza'),(7,'87520113','paolo.guerrero@gmail.com','Paolo','Guerrero'),(8,'11231948','hugo.sotil@gmail.com','Hugo','Sotil'),(9,'88230194','silvana.garcia@gmail.com','Silvana','Garcia'),(10,'70913130','martiza.sanchez@gmail.com','Maritza','Sanchez');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-13 21:55:01
