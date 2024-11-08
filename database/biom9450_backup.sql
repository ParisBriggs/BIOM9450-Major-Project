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
  `frequency` enum('1','2','3') DEFAULT NULL,
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
INSERT INTO `DietOrder` VALUES (1,1,1,'2023-11-23','3'),(2,2,2,'2023-11-23','3'),(3,3,3,'2023-11-23','3'),(4,4,4,'2023-11-23','3'),(5,5,5,'2023-11-23','3');
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
INSERT INTO `DietRegimes` VALUES (1,'Low Sodium Diet','Avoid: processed foods, canned foods, salty snacks, cured meats. \n  Include: fresh fruits and vegetables, lean meats, unsalted nuts, \n  low-sodium dairy products. Limit sodium intake to 2000mg per day.','Regular moderate exercise to help regulate blood pressure','Monitor for fluid retention'),(2,'Low Glycemic Index Diet','Avoid: sugary foods, refined carbs, processed snacks.\n  Include: whole grains, legumes, non-starchy vegetables, \n  lean proteins, healthy fats. Choose foods with GI < 55.\n  Monitor carbohydrate portions. Include protein with each meal.','Regular post-meal walking to help manage blood sugar','Monitor for signs of hypo/hyperglycemia'),(3,'Gluten-Free Diet','Avoid: wheat, rye, barley, and any derivatives.\n  Include: rice, corn, quinoa, gluten-free oats,\n  fresh fruits and vegetables, meat, fish, eggs, \n  dairy products, legumes, nuts and seeds.\n  Check all processed foods for gluten-containing ingredients.','Regular exercise as tolerated','Monitor for cross-contamination reactions'),(4,'High Protein Diet','Include: lean meats, fish, eggs, dairy, legumes,\n  nuts and seeds. Focus on complete proteins.\n  Balance with appropriate carbohydrates and healthy fats.\n  Protein intake adjusted based on body weight and activity.\n  Avoid: excessive processed meats.','Strength training and mobility exercises','Monitor protein intake and kidney function'),(5,'High Calcium Diet','Include: dairy products, fortified plant milks,\n  leafy green vegetables, fish with bones,\n  calcium-fortified foods. Combine with vitamin D rich foods.\n  Avoid: excessive caffeine and salt which can affect calcium absorption.','Weight-bearing exercises to support bone health','Monitor bone density and calcium levels');
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
  `roundTime` enum('morning','afternoon','evening') DEFAULT NULL,
  `status` enum('given','refused','fasting','no stock','ceased') DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `orderId` (`orderId`),
  KEY `practitioner` (`practitioner`),
  CONSTRAINT `dietround_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `DietOrder` (`id`),
  CONSTRAINT `dietround_ibfk_2` FOREIGN KEY (`practitioner`) REFERENCES `Practitioners` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DietRound`
--

LOCK TABLES `DietRound` WRITE;
/*!40000 ALTER TABLE `DietRound` DISABLE KEYS */;
INSERT INTO `DietRound` VALUES (1,1,1,'morning','given','Fresh fruit and unsalted oatmeal served. Patient ate well.'),(2,1,2,'afternoon','given','Fresh salad with grilled chicken, no salt added. Reminded about no salt at table.'),(3,1,1,'evening','refused','Complained about lack of salt. Offered herbs for flavoring instead.'),(4,2,3,'morning','given','Whole grain toast with eggs and avocado. Blood sugar within range.'),(5,2,2,'afternoon','given','Quinoa salad with chickpeas. Portion size appropriate.'),(6,2,4,'evening','fasting','Fasting for morning blood work. Water provided.'),(7,3,1,'morning','given','Gluten-free cereal with fresh fruit. Checked for cross-contamination.'),(8,3,2,'afternoon','given','Rice with grilled fish and vegetables. All ingredients verified gluten-free.'),(9,3,3,'evening','given','Gluten-free pasta with lean protein. Patient enjoyed meal.'),(10,4,4,'morning','given','High protein breakfast with eggs and Greek yogurt. Needed assistance with feeding.'),(11,4,1,'afternoon','given','Lean chicken with quinoa. Protein portion adjusted per Levodopa schedule.'),(12,4,2,'evening','refused','Fatigue affecting appetite. Will monitor protein intake tomorrow.'),(13,5,3,'morning','given','Calcium-fortified oatmeal with milk. Vitamin D supplement given.'),(14,5,4,'afternoon','given','Yogurt parfait and leafy green salad with almonds.'),(15,5,1,'evening','no stock','Calcium-fortified bread unavailable. Substituted with yogurt-based dish.');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EmergencyContacts`
--

LOCK TABLES `EmergencyContacts` WRITE;
/*!40000 ALTER TABLE `EmergencyContacts` DISABLE KEYS */;
INSERT INTO `EmergencyContacts` VALUES (1,'Mary','Smith','Wife','mary.smith@email.com','0412345678'),(2,'David','Clarke','Husband','david.clarke@email.com','0423456789'),(3,'Michael','Johnson','Son','michael.j@email.com','0434567890'),(4,'Emma','Wilson','Daughter','emma.wilson@email.com','0445678901'),(5,'Jennifer','Park','Sister','jen.park@email.com','0456789012'),(6,'Mary','Smith','Wife','mary.smith@email.com','0412345678'),(7,'David','Clarke','Husband','david.clarke@email.com','0423456789'),(8,'Michael','Johnson','Son','michael.j@email.com','0434567890'),(9,'Emma','Wilson','Daughter','emma.wilson@email.com','0445678901'),(10,'Jennifer','Park','Sister','jen.park@email.com','0456789012');
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
  `frequency` enum('1','2','3') DEFAULT NULL,
  `dosage` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `patient` (`patient`),
  KEY `medication` (`medication`),
  CONSTRAINT `medicationorder_ibfk_1` FOREIGN KEY (`patient`) REFERENCES `Patients` (`id`),
  CONSTRAINT `medicationorder_ibfk_2` FOREIGN KEY (`medication`) REFERENCES `Medications` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MedicationOrder`
--

LOCK TABLES `MedicationOrder` WRITE;
/*!40000 ALTER TABLE `MedicationOrder` DISABLE KEYS */;
INSERT INTO `MedicationOrder` VALUES (1,1,2,'2023-11-23','2',5.00),(2,1,1,'2023-11-23','1',5.00),(3,2,3,'2023-11-23','3',2.00),(4,2,4,'2023-11-23','3',NULL),(5,2,5,'2023-11-23','1',25.00),(6,3,6,'2023-11-23','2',640.00),(7,4,7,'2023-11-23','3',0.13),(8,4,8,'2023-11-23','3',0.13),(9,4,9,'2023-11-23','2',5.00),(10,5,10,'2023-11-23','1',35.00),(11,5,11,'2023-11-23','1',5.00),(12,5,12,'2023-11-23','1',600.00);
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
  `roundTime` enum('morning','afternoon','evening') DEFAULT NULL,
  `status` enum('given','refused','fasting','no stock','ceased') DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `orderId` (`orderId`),
  KEY `practitioner` (`practitioner`),
  CONSTRAINT `medicationround_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `MedicationOrder` (`id`),
  CONSTRAINT `medicationround_ibfk_2` FOREIGN KEY (`practitioner`) REFERENCES `Practitioners` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MedicationRound`
--

LOCK TABLES `MedicationRound` WRITE;
/*!40000 ALTER TABLE `MedicationRound` DISABLE KEYS */;
INSERT INTO `MedicationRound` VALUES (1,1,1,'morning','given','Taken with water'),(2,1,1,'evening','given','Taken with dinner'),(3,2,1,'evening','refused','Patient initially refused, taken after discussion'),(4,3,2,'morning','given','Taken with breakfast'),(5,3,2,'afternoon','given','Taken with lunch'),(6,3,2,'evening','given','Taken with dinner'),(7,4,2,'morning','no stock','Pharmacy notified, will deliver tomorrow'),(8,5,3,'evening','given','Taken as scheduled'),(9,6,3,'morning','fasting','NPO for morning procedure'),(10,6,3,'evening','given','Taken after dinner'),(11,7,4,'morning','given','Given with breakfast'),(12,7,4,'afternoon','given','Given with lunch'),(13,7,4,'evening','ceased','Discontinued per doctor orders'),(14,10,1,'morning','given','Taken with breakfast');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Medications`
--

LOCK TABLES `Medications` WRITE;
/*!40000 ALTER TABLE `Medications` DISABLE KEYS */;
INSERT INTO `Medications` VALUES (1,'Donepezil','oral'),(2,'Lisinopril','oral'),(3,'Repaglinide','oral'),(4,'Insulin','injection'),(5,'Sitagliptin','oral'),(6,'Calcium Carbonate','oral'),(7,'Levodopa-Carbidopa','infusion'),(8,'Pramipexole','oral'),(9,'Eldepryl','oral'),(10,'Alendronate','oral'),(11,'Risedronate','oral'),(12,'Vitamin D','oral'),(13,'Calcium','oral'),(14,'Donepezil','oral'),(15,'Lisinopril','oral'),(16,'Repaglinide','oral'),(17,'Insulin','injection'),(18,'Sitagliptin','oral'),(19,'Calcium Carbonate','oral'),(20,'Levodopa-Carbidopa','infusion'),(21,'Pramipexole','oral'),(22,'Eldepryl','oral'),(23,'Alendronate','oral'),(24,'Risedronate','oral'),(25,'Vitamin D','oral'),(26,'Calcium','oral');
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
  `photo` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `notes` text,
  `emergencyContact` int DEFAULT NULL,
  `room` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `emergencyContact` (`emergencyContact`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`emergencyContact`) REFERENCES `EmergencyContacts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patients`
--

LOCK TABLES `Patients` WRITE;
/*!40000 ALTER TABLE `Patients` DISABLE KEYS */;
INSERT INTO `Patients` VALUES (1,'John','Smith','male','images/profile_image_1.jpg','john.smith@email.com','0400123456','Has dementia and high blood pressure. Needs regular monitoring.',1,101),(2,'Kelly','Clarke','female','images/profile_image_2.jpg','kelly.clarke@email.com','0400234567','Type 2 diabetes. Regular glucose monitoring required.',2,102),(3,'Sarah','Johnson','female','images/profile_image_3.jpg','sarah.johnson@email.com','0400345678','Celiac disease and acid reflux. Strict dietary requirements.',3,103),(4,'Toby','Wilson','male','images/profile_image_6.jpg','toby.wilson@email.com','0400456789','Parkinsons disease. Requires assistance with daily activities.',4,104),(5,'Alex','Park','male','images/profile_image_5.jpeg','alex.park@email.com','0400567890','Osteoporosis. Weekly medication schedule.',5,105),(6,'John','Smith','male','images/profile_image_1.jpg','john.smith@email.com','0400123456','Has dementia and high blood pressure. Needs regular monitoring.',1,101),(7,'Kelly','Clarke','female','images/profile_image_2.jpg','kelly.clarke@email.com','0400234567','Type 2 diabetes. Regular glucose monitoring required.',2,102),(8,'Sarah','Johnson','female','images/profile_image_3.jpg','sarah.johnson@email.com','0400345678','Celiac disease and acid reflux. Strict dietary requirements.',3,103),(9,'Toby','Wilson','male','images/profile_image_6.jpg','toby.wilson@email.com','0400456789','Parkinsons disease. Requires assistance with daily activities.',4,104),(10,'Alex','Park','male','images/profile_image_5.jpeg','alex.park@email.com','0400567890','Osteoporosis. Weekly medication schedule.',5,105);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Practitioners`
--

LOCK TABLES `Practitioners` WRITE;
/*!40000 ALTER TABLE `Practitioners` DISABLE KEYS */;
INSERT INTO `Practitioners` VALUES (1,'Emma','Brown','emma.brown','password123'),(2,'Michael','Lee','michael.lee','password456'),(3,'Sarah','Wilson','sarah.wilson','password789'),(4,'James','Taylor','james.taylor','password101'),(5,'Lisa','Anderson','lisa.anderson','password102'),(6,'David','Martinez','david.martinez','password103'),(7,'Emma','Brown','emma.brown','password123'),(8,'Michael','Lee','michael.lee','password456'),(9,'Sarah','Wilson','sarah.wilson','password789'),(10,'James','Taylor','james.taylor','password101'),(11,'Lisa','Anderson','lisa.anderson','password102'),(12,'David','Martinez','david.martinez','password103');
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

-- Dump completed on 2024-11-07 20:27:48
