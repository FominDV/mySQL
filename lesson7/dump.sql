-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: net_shop
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `photo_id` int NOT NULL,
  `user_id` int NOT NULL,
  `comment` varchar(225) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `photo_idx` (`photo_id`),
  KEY `user_comment_idx` (`user_id`),
  CONSTRAINT `photo` FOREIGN KEY (`photo_id`) REFERENCES `photo` (`id`),
  CONSTRAINT `user_comment` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,4,5,'good'),(2,5,5,'very'),(3,6,4,'lol'),(4,6,4,'kek'),(5,7,8,'bad'),(6,5,7,'fun'),(7,5,3,'wwwww'),(8,7,3,'33');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_for_comment`
--

DROP TABLE IF EXISTS `like_for_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `like_for_comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment_id` int NOT NULL,
  `user_id` int NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq` (`comment_id`,`user_id`),
  KEY `user_like_idx` (`user_id`),
  KEY `comment_idx` (`comment_id`) /*!80000 INVISIBLE */,
  CONSTRAINT `comment` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `user_like` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_for_comment`
--

LOCK TABLES `like_for_comment` WRITE;
/*!40000 ALTER TABLE `like_for_comment` DISABLE KEYS */;
INSERT INTO `like_for_comment` VALUES (1,1,3,1),(2,1,4,1),(3,1,5,1),(4,3,5,0),(5,3,4,1),(6,4,4,1),(7,5,5,1);
/*!40000 ALTER TABLE `like_for_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_for_photo`
--

DROP TABLE IF EXISTS `like_for_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `like_for_photo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `photo_id` int NOT NULL,
  `user_id` int NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user` (`user_id`,`photo_id`),
  KEY `photo_liked_idx` (`photo_id`),
  CONSTRAINT `photo_liked` FOREIGN KEY (`photo_id`) REFERENCES `photo` (`id`),
  CONSTRAINT `user_photo` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_for_photo`
--

LOCK TABLES `like_for_photo` WRITE;
/*!40000 ALTER TABLE `like_for_photo` DISABLE KEYS */;
INSERT INTO `like_for_photo` VALUES (1,7,3,1),(2,6,5,1),(3,4,3,1),(4,5,8,1),(5,4,5,1),(7,4,7,1),(10,4,8,0);
/*!40000 ALTER TABLE `like_for_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_for_user`
--

DROP TABLE IF EXISTS `like_for_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `like_for_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_liked_id` int NOT NULL,
  `user_id` int NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_likes` (`user_liked_id`,`user_id`),
  KEY `user_liked_id_fk_idx` (`user_liked_id`,`user_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_liked` FOREIGN KEY (`user_liked_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_for_user`
--

LOCK TABLES `like_for_user` WRITE;
/*!40000 ALTER TABLE `like_for_user` DISABLE KEYS */;
INSERT INTO `like_for_user` VALUES (5,3,3,0),(6,4,4,0),(7,5,5,0),(10,3,5,1),(12,5,3,1),(13,6,6,0),(14,7,7,0),(15,8,8,0),(16,3,4,1),(17,5,4,1),(18,5,6,1),(19,5,7,1),(20,5,8,1),(21,3,6,1),(22,3,7,1),(23,4,6,1),(24,4,7,1),(28,9,9,0),(29,7,4,1),(30,6,5,1),(31,7,5,1),(32,6,4,1),(33,8,4,1),(34,6,3,1),(35,7,3,1);
/*!40000 ALTER TABLE `like_for_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(45) DEFAULT 'not set',
  `cache` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cache_UNIQUE` (`cache`),
  KEY `user_idx` (`user_id`),
  CONSTRAINT `user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo`
--

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` VALUES (4,3,'sea','3435353535'),(5,3,'wall','3523523523523'),(6,8,'cook','25235325325'),(7,5,'car','wqweqwe2e');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'www'),(4,'peter'),(5,'ivan'),(6,'A'),(7,'B'),(8,'C'),(9,'yo');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `users_BEFORE_INSERT` AFTER INSERT ON `users` FOR EACH ROW BEGIN
set @id=NEW.id;
INSERT INTO net_shop.like_for_user (user_liked_id, user_id, enabled) VALUE (@id,@id,false);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-25  2:01:52
