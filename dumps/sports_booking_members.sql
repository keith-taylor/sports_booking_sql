-- MySQL dump 10.13  Distrib 8.0.30, for macos12 (x86_64)
--
-- Host: localhost    Database: sports_booking
-- ------------------------------------------------------
-- Server version	8.0.30-0ubuntu0.22.04.1

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
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `member_id` varchar(21) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `member_since` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_due` decimal(6,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES ('afeil','feil1988<3','Abdul.Feil@hotmail.com','2017-04-15 11:10:13',0.00),('amely_18','loseweightin18','Amely.Bauch91@yahoo.com','2018-02-06 16:48:43',0.00),('bbahringer','iambeau17','Beaulah_Bahringer@yahoo.com','2017-12-28 05:36:50',0.00),('little31','whocares31','Anthony_Little31@gmail.com','2017-06-01 20:12:11',10.00),('macejkovic73','jadajeda12','Jada.Macejkovic73@gmail.com','2017-05-30 16:30:22',0.00),('marvin1','if0909mar','Marvin_Schulist@gmail.com','2017-09-09 01:30:49',10.00),('nitzsche77','bret77@#','Bret_Nitzsche77@gmail.com','2018-01-09 17:36:49',0.00),('noah51','18Oct1976#51','Noah51@gmail.com','2017-12-16 22:59:46',0.00),('oreillys','reallycool#1','Martine_OReilly@yahoo.com','2017-10-12 04:39:20',0.00),('wyattgreat','wyatt111','Wyatt_Wisozk2@gmail.com','2017-07-18 15:28:35',0.00);
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-06 19:34:03
