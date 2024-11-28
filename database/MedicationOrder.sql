-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Nov 28, 2024 at 10:31 AM
-- Server version: 8.0.35
-- PHP Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `major_project_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `MedicationOrder`
--

CREATE TABLE `MedicationOrder` (
  `id` int NOT NULL,
  `patient` int DEFAULT NULL,
  `medication` int DEFAULT NULL,
  `dateOrdered` date DEFAULT NULL,
  `frequency` enum('1','2','3') DEFAULT NULL,
  `dosage` decimal(10,2) DEFAULT NULL,
  `prescribedBy` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `MedicationOrder`
--

INSERT INTO `MedicationOrder` (`id`, `patient`, `medication`, `dateOrdered`, `frequency`, `dosage`, `prescribedBy`) VALUES
(1, 1, 2, '2023-11-23', '2', 5.00, '4'),
(2, 1, 1, '2023-11-23', '1', 5.00, '6'),
(4, 2, 5, '2024-11-22', '1', 25.00, '4'),
(5, 3, 7, '2024-11-22', '3', 100.00, '6'),
(6, 4, 4, '2024-11-22', '1', 75.00, '2'),
(7, 5, 6, '2024-11-22', '2', 10.00, '1'),
(8, 6, 3, '2024-11-22', '3', 60.00, '5'),
(9, 7, 8, '2024-11-22', '1', 30.00, '3'),
(10, 8, 9, '2024-11-22', '2', 40.00, '6'),
(11, 9, 11, '2024-11-22', '1', 20.00, '4'),
(12, 10, 12, '2024-11-22', '3', 15.00, '5'),
(13, 11, 10, '2024-11-22', '2', 35.00, '2'),
(14, 12, 13, '2024-11-22', '3', 80.00, '1'),
(15, 13, 1, '2024-11-22', '2', 55.00, '6'),
(16, 14, 2, '2024-11-22', '1', 45.00, '3'),
(17, 15, 5, '2024-11-22', '3', 70.00, '4'),
(18, 16, 7, '2024-11-22', '2', 65.00, '5'),
(19, 17, 6, '2024-11-22', '1', 90.00, '2'),
(20, 18, 4, '2024-11-22', '3', 50.00, '1'),
(21, 19, 3, '2024-11-22', '2', 85.00, '6');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `MedicationOrder`
--
ALTER TABLE `MedicationOrder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient` (`patient`),
  ADD KEY `medication` (`medication`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `MedicationOrder`
--
ALTER TABLE `MedicationOrder`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `MedicationOrder`
--
ALTER TABLE `MedicationOrder`
  ADD CONSTRAINT `medicationorder_ibfk_1` FOREIGN KEY (`patient`) REFERENCES `Patients` (`id`),
  ADD CONSTRAINT `medicationorder_ibfk_2` FOREIGN KEY (`medication`) REFERENCES `Medications` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
