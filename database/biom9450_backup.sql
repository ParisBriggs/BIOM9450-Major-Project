-- MySQL dump 10.13  Distrib 9.1.0, for macos14 (arm64)
--
-- Host: localhost    Database: biom9450
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `DietOrder`
--

DROP TABLE IF EXISTS `DietOrder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DietOrder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `patient` int DEFAULT NULL,
  `dietRegime` int DEFAULT NULL,
  `dateOrdered` date DEFAULT NULL,
  `dateDue` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient` (`patient`),
  KEY `dietRegime` (`dietRegime`),
  CONSTRAINT `dietorder_ibfk_1` FOREIGN KEY (`patient`) REFERENCES `Patients` (`id`),
  CONSTRAINT `dietorder_ibfk_2` FOREIGN KEY (`dietRegime`) REFERENCES `DietRegimes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DietOrder`
--

LOCK TABLES `DietOrder` WRITE;
/*!40000 ALTER TABLE `DietOrder` DISABLE KEYS */;
INSERT INTO `DietOrder` VALUES (1,1,1,'2023-11-23','2023-11-23'),(2,2,2,'2023-11-23','2023-11-23'),(3,3,3,'2023-11-23','2023-11-23'),(4,4,4,'2023-11-23','2023-11-23'),(5,5,5,'2023-11-23','2023-11-23');
/*!40000 ALTER TABLE `DietOrder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DietRegimes`
--

DROP TABLE IF EXISTS `DietRegimes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DietRegimes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `food` text NOT NULL,
  `excercise` text NOT NULL,
  `beauty` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DietRegimes`
--

LOCK TABLES `DietRegimes` WRITE;
/*!40000 ALTER TABLE `DietRegimes` DISABLE KEYS */;
INSERT INTO `DietRegimes` VALUES (1,'John Smith Diet','Low sodium, fiber-rich foods, low caffeine, ensure enough hydration. No caffeine, low salt, moderate fat.','Regular walking as tolerated, seated exercises','Regular grooming assistance needed'),(2,'Kelly Clarke Diet','Low glycemic index foods, high fiber, balanced macronutrients. Afternoon sweet snack allowed.','Light exercise after meals, daily walking','Independent, no assistance needed'),(3,'Sarah Johnson Diet','Gluten-free, low-acid, low-fat, and high fiber food. Celiac-friendly meals.','Regular walking, gentle stretching','Independent, no assistance needed'),(4,'Toby Wilson Diet','Nutrient-dense foods for brain health, high fiber, protein adjusted to Levodopa levels','Assisted mobility exercises, physical therapy','Requires daily grooming assistance'),(5,'Alex Park Diet','High in calcium, vitamin D, magnesium, and protein-rich food. Glass of milk morning and evening','Weight-bearing exercises, balance training','Independent with safety monitoring');
/*!40000 ALTER TABLE `DietRegimes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DietRound`
--

DROP TABLE IF EXISTS `DietRound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DietRound` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderId` int DEFAULT NULL,
  `practitioner` int DEFAULT NULL,
  `status` enum('given','refused','fasting','no stock','ceased') DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `orderId` (`orderId`),
  KEY `practitioner` (`practitioner`),
  CONSTRAINT `dietround_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `DietOrder` (`id`),
  CONSTRAINT `dietround_ibfk_2` FOREIGN KEY (`practitioner`) REFERENCES `Practitioners` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DietRound`
--

LOCK TABLES `DietRound` WRITE;
/*!40000 ALTER TABLE `DietRound` DISABLE KEYS */;
INSERT INTO `DietRound` VALUES (1,1,1,'given','Ate full portion'),(2,1,2,'refused','Not hungry, offered alternative'),(3,2,3,'given','Ate well, enjoyed meal'),(4,2,4,'fasting','Fasting for blood work'),(5,3,1,'given','Ate half portion'),(6,3,2,'given','Special request for extra vegetables accommodated'),(7,4,3,'given','Required assistance with feeding'),(8,4,4,'refused','Not feeling well, will monitor'),(9,5,1,'given','Completed full meal'),(10,5,2,'no stock','Special dietary items not available, substitute provided');
/*!40000 ALTER TABLE `DietRound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EmergencyContacts`
--

DROP TABLE IF EXISTS `EmergencyContacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EmergencyContacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `relationship` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EmergencyContacts`
--

LOCK TABLES `EmergencyContacts` WRITE;
/*!40000 ALTER TABLE `EmergencyContacts` DISABLE KEYS */;
INSERT INTO `EmergencyContacts` VALUES (1,'Mary','Smith','Wife','mary.smith@email.com','0412345678'),(2,'David','Clarke','Husband','david.clarke@email.com','0423456789'),(3,'Michael','Johnson','Son','michael.j@email.com','0434567890'),(4,'Emma','Wilson','Daughter','emma.wilson@email.com','0445678901'),(5,'Jennifer','Park','Sister','jen.park@email.com','0456789012');
/*!40000 ALTER TABLE `EmergencyContacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MedicationOrder`
--

DROP TABLE IF EXISTS `MedicationOrder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MedicationOrder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `patient` int DEFAULT NULL,
  `medication` int DEFAULT NULL,
  `dateOrdered` date DEFAULT NULL,
  `dateDue` date DEFAULT NULL,
  `dosage` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient` (`patient`),
  KEY `medication` (`medication`),
  CONSTRAINT `medicationorder_ibfk_1` FOREIGN KEY (`patient`) REFERENCES `Patients` (`id`),
  CONSTRAINT `medicationorder_ibfk_2` FOREIGN KEY (`medication`) REFERENCES `Medications` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MedicationOrder`
--

LOCK TABLES `MedicationOrder` WRITE;
/*!40000 ALTER TABLE `MedicationOrder` DISABLE KEYS */;
INSERT INTO `MedicationOrder` VALUES (1,1,2,'2023-11-23','2023-11-23',5.00),(2,1,1,'2023-11-23','2023-11-23',5.00),(3,1,2,'2023-11-24','2023-11-24',5.00),(4,1,1,'2023-11-24','2023-11-24',5.00),(5,1,2,'2023-11-25','2023-11-25',5.00),(6,1,1,'2023-11-25','2023-11-25',5.00),(7,1,2,'2023-11-26','2023-11-26',5.00),(8,1,1,'2023-11-26','2023-11-26',5.00),(9,1,2,'2023-11-27','2023-11-27',5.00),(10,1,1,'2023-11-27','2023-11-27',5.00),(11,1,2,'2023-11-28','2023-11-28',5.00),(12,1,1,'2023-11-28','2023-11-28',5.00),(13,1,2,'2023-11-29','2023-11-29',5.00),(14,1,1,'2023-11-29','2023-11-29',5.00),(15,2,3,'2023-11-23','2023-11-23',2.00),(16,2,4,'2023-11-23','2023-11-23',NULL),(17,2,5,'2023-11-23','2023-11-23',25.00),(18,3,6,'2023-11-23','2023-11-23',640.00),(19,4,7,'2023-11-23','2023-11-23',0.13),(20,4,8,'2023-11-23','2023-11-23',0.13),(21,4,9,'2023-11-23','2023-11-23',5.00),(22,5,10,'2023-11-23','2023-11-23',35.00),(23,5,11,'2023-11-23','2023-11-23',5.00),(24,5,12,'2023-11-23','2023-11-23',600.00);
/*!40000 ALTER TABLE `MedicationOrder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MedicationRound`
--

DROP TABLE IF EXISTS `MedicationRound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MedicationRound` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderId` int DEFAULT NULL,
  `practitioner` int DEFAULT NULL,
  `status` enum('given','refused','fasting','no stock','ceased') DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `orderId` (`orderId`),
  KEY `practitioner` (`practitioner`),
  CONSTRAINT `medicationround_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `MedicationOrder` (`id`),
  CONSTRAINT `medicationround_ibfk_2` FOREIGN KEY (`practitioner`) REFERENCES `Practitioners` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MedicationRound`
--

LOCK TABLES `MedicationRound` WRITE;
/*!40000 ALTER TABLE `MedicationRound` DISABLE KEYS */;
INSERT INTO `MedicationRound` VALUES (1,1,1,'given','Taken with water'),(2,2,1,'refused','Patient initially refused, taken after discussion'),(3,3,2,'given','Taken with breakfast'),(4,4,2,'no stock','Pharmacy notified, will deliver tomorrow'),(5,5,3,'given','Taken as scheduled'),(6,6,3,'fasting','NPO for morning procedure'),(7,7,4,'ceased','Discontinued per doctor orders'),(8,8,1,'given','Administered with lunch'),(9,9,2,'given','Given at bedtime'),(10,10,3,'refused','Patient sleeping, will try later');
/*!40000 ALTER TABLE `MedicationRound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Medications`
--

DROP TABLE IF EXISTS `Medications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Medications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `routeAdmin` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Medications`
--

LOCK TABLES `Medications` WRITE;
/*!40000 ALTER TABLE `Medications` DISABLE KEYS */;
INSERT INTO `Medications` VALUES (1,'Donepezil','oral'),(2,'Lisinopril','oral'),(3,'Repaglinide','oral'),(4,'Insulin','injection'),(5,'Sitagliptin','oral'),(6,'Calcium Carbonate','oral'),(7,'Levodopa-Carbidopa','infusion'),(8,'Pramipexole','oral'),(9,'Eldepryl','oral'),(10,'Alendronate','oral'),(11,'Risedronate','oral'),(12,'Vitamin D','oral'),(13,'Calcium','oral');
/*!40000 ALTER TABLE `Medications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patients`
--

DROP TABLE IF EXISTS `Patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `sex` enum('male','female') DEFAULT NULL,
  `photo` mediumblob,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `notes` text,
  `emergencyContact` int DEFAULT NULL,
  `room` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `emergencyContact` (`emergencyContact`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`emergencyContact`) REFERENCES `EmergencyContacts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patients`
--

LOCK TABLES `Patients` WRITE;
/*!40000 ALTER TABLE `Patients` DISABLE KEYS */;
INSERT INTO `Patients` VALUES (1,'John','Smith','male',NULL,'john.smith@email.com','0400123456','Has dementia and high blood pressure. Needs regular monitoring.',1,101),(2,'Kelly','Clarke','female',NULL,'kelly.clarke@email.com','0400234567','Type 2 diabetes. Regular glucose monitoring required.',2,102),(3,'Sarah','Johnson','female',NULL,'sarah.johnson@email.com','0400345678','Celiac disease and acid reflux. Strict dietary requirements.',3,103),(4,'Toby','Wilson','male',NULL,'toby.wilson@email.com','0400456789','Parkinsons disease. Requires assistance with daily activities.',4,104),(5,'Alex','Park','male',NULL,'alex.park@email.com','0400567890','Osteoporosis. Weekly medication schedule.',5,105);
/*!40000 ALTER TABLE `Patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Practitioners`
--

DROP TABLE IF EXISTS `Practitioners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Practitioners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Practitioners`
--

LOCK TABLES `Practitioners` WRITE;
/*!40000 ALTER TABLE `Practitioners` DISABLE KEYS */;
INSERT INTO `Practitioners` VALUES (1,'Emma','Brown','emma.brown','password123'),(2,'Michael','Lee','michael.lee','password456'),(3,'Sarah','Wilson','sarah.wilson','password789'),(4,'James','Taylor','james.taylor','password101'),(5,'Lisa','Anderson','lisa.anderson','password102'),(6,'David','Martinez','david.martinez','password103');
/*!40000 ALTER TABLE `Practitioners` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-07 16:13:34
