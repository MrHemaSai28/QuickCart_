-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: quickcart_db
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `street` varchar(255) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `landmark` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,1,'HEMA SAI','09676403580','SRIKALAHASTI','Andhra Pradesh','kotha kandriga, kanaparthi road,','517642','ganesh temple','2025-07-15 12:51:38'),(2,1,'HEMA','07780662485','banglore','Karnataka','15c main road, BTM layout','560076','udupi kitchen ','2025-07-15 13:24:05'),(3,1,'HEMA','7780662485','SRIKALAHASTI','Andhra Pradesh','srikalahasti','517641','shivayya temple','2025-07-15 13:54:42'),(4,4,'rani','9987658800','SRIKALAHASTI','Andhra Pradesh','kotha kandriga, kanaparthi road,','517641','temple','2025-07-15 14:12:39'),(5,1,'Mr.hema sai','9676403580','Srikalahasthi','Andhra Pradesh','SRIKALAHASTHI','517642','temple','2025-07-16 06:30:37');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,1,18999),(2,1,3,1,19999),(3,1,5,1,21999),(4,2,1,1,18999),(5,3,3,1,19999),(6,3,4,1,23999),(7,4,3,1,19999),(8,5,3,1,19999),(9,6,4,1,23999),(10,7,3,1,19999),(11,8,1,1,18999),(12,8,3,2,19999),(13,9,3,6,19999),(14,9,4,2,23999),(15,9,7,1,64990),(16,10,3,1,19999),(17,11,7,1,64990),(18,12,7,1,64990),(19,13,3,1,19999),(20,13,4,1,23999);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_logs`
--

DROP TABLE IF EXISTS `order_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `log_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_logs`
--

LOCK TABLES `order_logs` WRITE;
/*!40000 ALTER TABLE `order_logs` DISABLE KEYS */;
INSERT INTO `order_logs` VALUES (1,8,1,'Cancelled','Changed my mind','2025-07-15 17:57:30'),(2,8,1,'Cancelled','Changed my mind','2025-07-15 18:07:11'),(3,8,1,'Cancelled','Changed my mind','2025-07-15 18:14:49'),(4,2,1,'Cancelled','Ordered by mistake','2025-07-16 02:40:42'),(5,9,1,'Cancelled','Changed my mind','2025-07-16 06:51:31'),(6,12,1,'Cancelled','Changed my mind','2025-07-16 08:17:56');
/*!40000 ALTER TABLE `order_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_tracking`
--

DROP TABLE IF EXISTS `order_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_tracking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_tracking`
--

LOCK TABLES `order_tracking` WRITE;
/*!40000 ALTER TABLE `order_tracking` DISABLE KEYS */;
INSERT INTO `order_tracking` VALUES (1,1,'Order Placed','2025-07-15 12:18:12','2025-07-15 18:12:51'),(2,2,'Order Placed','2025-07-15 12:19:48','2025-07-15 18:12:51'),(3,3,'Order Placed','2025-07-15 12:51:38','2025-07-15 18:12:51'),(4,4,'Order Placed','2025-07-15 13:12:33','2025-07-15 18:12:51'),(5,5,'Order Placed','2025-07-15 13:24:05','2025-07-15 18:12:51'),(6,6,'Order Placed','2025-07-15 13:54:42','2025-07-15 18:12:51'),(7,7,'Order Placed','2025-07-15 14:12:50','2025-07-15 18:12:51'),(8,8,'Order Placed','2025-07-15 17:18:37','2025-07-15 18:12:51'),(9,8,'Placed','2025-07-15 17:18:37','2025-07-15 18:12:51'),(10,6,'Cancelled','2025-07-15 17:29:16','2025-07-15 18:12:51'),(11,5,'Cancelled','2025-07-15 17:29:21','2025-07-15 18:12:51'),(12,8,'Cancelled','2025-07-15 17:29:28','2025-07-15 18:12:51'),(13,8,'Cancelled','2025-07-15 17:29:30','2025-07-15 18:12:51'),(14,8,'Cancelled','2025-07-15 17:29:31','2025-07-15 18:12:51'),(15,8,'Cancelled','2025-07-15 17:29:32','2025-07-15 18:12:51'),(16,8,'Cancelled','2025-07-15 17:30:13','2025-07-15 18:12:51'),(17,8,'Pending','2025-07-15 17:30:15','2025-07-15 18:12:51'),(18,8,'Cancelled','2025-07-15 17:57:30','2025-07-15 18:12:51'),(19,8,'Cancelled','2025-07-15 18:07:11','2025-07-15 18:12:51'),(20,8,'Cancelled','2025-07-15 18:14:49','2025-07-15 18:14:49'),(21,2,'Cancelled','2025-07-16 02:40:42','2025-07-16 02:40:42'),(22,9,'Order Placed','2025-07-16 06:51:00','2025-07-16 06:51:00'),(23,9,'Placed','2025-07-16 06:51:00','2025-07-16 06:51:00'),(24,9,'Cancelled','2025-07-16 06:51:31','2025-07-16 06:51:31'),(25,10,'Order Placed','2025-07-16 07:03:28','2025-07-16 07:03:28'),(26,11,'Order Placed','2025-07-16 07:04:15','2025-07-16 07:04:15'),(27,12,'Order Placed','2025-07-16 07:07:31','2025-07-16 07:07:31'),(28,13,'Order Placed','2025-07-16 07:12:46','2025-07-16 07:12:46'),(29,12,'Cancelled','2025-07-16 08:17:56','2025-07-16 08:17:56');
/*!40000 ALTER TABLE `order_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `payment_type` varchar(50) DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'null, null, null, null, null - null',NULL,60997,'2025-07-15 12:18:12'),(2,1,'null, null, null, null, null - null',NULL,18999,'2025-07-15 12:19:48'),(3,1,'HEMA SAI, 09676403580, kotha kandriga, kanaparthi road,, ganesh temple, SRIKALAHASTI, Andhra Pradesh - 517642','COD',43998,'2025-07-15 12:51:38'),(4,1,'HEMA SAI, 09676403580, kotha kandriga, kanaparthi road,, ganesh temple, SRIKALAHASTI, Andhra Pradesh - 517642','COD',19999,'2025-07-15 13:12:33'),(5,1,'HEMA, 07780662485, 15c main road, BTM layout, udupi kitchen , banglore, Karnataka - 560076',NULL,19999,'2025-07-15 13:24:05'),(6,1,'HEMA, 7780662485, srikalahasti, shivayya temple, SRIKALAHASTI, Andhra Pradesh - 517641',NULL,23999,'2025-07-15 13:54:42'),(7,4,'rani, 9987658800, kotha kandriga, kanaparthi road,, temple, SRIKALAHASTI, Andhra Pradesh - 517641','UPI',19999,'2025-07-15 14:12:50'),(8,1,'HEMA SAI, 09676403580, kotha kandriga, kanaparthi road,, ganesh temple, SRIKALAHASTI, Andhra Pradesh - 517642','COD',58997,'2025-07-15 17:18:37'),(9,1,'HEMA, 07780662485, 15c main road, BTM layout, udupi kitchen , banglore, Karnataka - 560076','COD',232982,'2025-07-16 06:51:00'),(10,1,'Mr.hema sai, 9676403580, SRIKALAHASTHI, temple, Srikalahasthi, Andhra Pradesh - 517642','COD',19999,'2025-07-16 07:03:28'),(11,1,'HEMA, 7780662485, srikalahasti, shivayya temple, SRIKALAHASTI, Andhra Pradesh - 517641','Card',64990,'2025-07-16 07:04:14'),(12,1,'HEMA, 7780662485, srikalahasti, shivayya temple, SRIKALAHASTI, Andhra Pradesh - 517641','Card',64990,'2025-07-16 07:07:31'),(13,1,'HEMA SAI, 09676403580, kotha kandriga, kanaparthi road,, ganesh temple, SRIKALAHASTI, Andhra Pradesh - 517642','COD',43998,'2025-07-16 07:12:46');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `price` double DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Motorola G8 5G ','Exynos 1330 | 6000mAh battery | 5G ready',18999,'Mobile','images/motorolaG85g.jpeg'),(2,'Realme P3 5G','6 GB RAM | 128 GB ROM | Expandable Upto 2 TB 16.94 cm (6.67 inch) Full HD+ Display 50MP + 2MP | 16MP Front Camera 6000 mAh Battery 6 Gen 4 Processor 1 Year Manufacturer Warranty for Device and 6 Months Manufacturer Warranty for Inbox Accessories',15999,'Mobile','images/RealmeP35g.jpeg'),(3,'Samsung Galaxy A35 5G','A15 Bionic | Dual 12MP Camera | 5G',19999,'Mobile','images/samsungA35.jpeg'),(4,'vivo T4 5G','Helio G88 | 64MP AI Camera',23999,'Mobile','images/vivoT45g.jpeg'),(5,'Poco F7 5G','Dimensity 930 | Clean Android Experience',21999,'Mobile','images/pocoF75g.jpeg'),(7,'Apple iPhone 15','128 GB ROM 15.49 cm (6.1 inch) Super Retina XDR Display 48MP + 12MP | 12MP Front Camera A16 Bionic Chip, 6 Core Processor Processor 1 year warranty for phone and 1 year warranty for in Box Accessories.',64990,'Mobile','images/AppleiPhone15.jpeg'),(8,'vivo T4 Ultra 5G','12 GB RAM | 256 GB ROM 16.94 cm (6.67 inch) Full HD+ AMOLED Display 50MP + 8MP + 50MP Periscope | 32MP Front Camera 5500 mAh Battery Dimensity 9300+ Processor',39999,'Mobile','images/vivoT4Ultra5G.jpeg'),(9,'Samsung Galaxy S24','8 GB RAM | 128 GB ROM 17.02 cm (6.7 inch) Full HD+ Display 50MP + 12MP | 10MP Front Camera 4700 mAh Battery Exynos 2400e Processor 1 Year Manufacturer Warranty for Device and 6 Months for In-Box Accessories',35999,'Mobile','images/SamsungGalaxyS24.jpeg'),(10,'Infinix Hot 50 5G','4 GB RAM | 128 GB ROM | Expandable Upto 1 TB 17.02 cm (6.7 inch) HD+ Display 48MP + Depth Sensor | 8MP Front Camera 5000 mAh Lithium-ion Polymer Battery Dimensity 6300 Processor 1 Year Warranty on Handset and 6 Months Warranty on Accessories',9499,'Mobile','images/InfinixHot505G.jpeg'),(11,'OPPO A3x ','4 GB RAM | 64 GB ROM | Expandable Upto 1 TB 16.94 cm (6.67 inch) HD+ Display 8MP Rear Camera | 5MP Front Camera 5100 mAh Battery 6s 4G Gen1 Processor',8999,'Mobile','images/OPPOA3x.jpeg'),(12,'OPPO F27 Pro+','8 GB RAM | 128 GB ROM 17.02 cm (6.7 inch) Full HD+ Display 64MP + 2MP | 8MP Front Camera 5000 mAh Battery Dimensity 7050 Processor',18749,'Mobile','images/OPPOF27Pro+.jpeg'),(13,'Apple iPhone 16','256 GB ROM 15.49 cm (6.1 inch) Super Retina XDR Display 48MP + 12MP | 12MP Front Camera A18 Chip, 6 Core Processor Processor',81999,'Mobile','images/AppleiPhone16.jpeg'),(14,'realme C71','6 GB RAM | 128 GB ROM | Expandable Upto 2 TB 17.14 cm (6.75 inch) HD+ Display 13MP Rear Camera | 5MP Front Camera 6300 mAh Battery UMS9230E Processor',8699,'Mobile','images/realmeC71.jpeg');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('admin','customer') DEFAULT 'customer',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'hemasai','Hemu767@gmail.com','1234','customer'),(4,'Rani','rani123@gmail.com','4321','customer'),(5,'sandhya','sandhya723@gmail.com','2323','admin'),(6,'meghana','maggi123@gamil.com','1122','admin');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-16 13:53:56
