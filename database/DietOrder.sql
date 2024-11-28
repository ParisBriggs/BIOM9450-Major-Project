-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Nov 28, 2024 at 08:24 AM
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
-- Table structure for table `DietOrder`
--

CREATE TABLE `DietOrder` (
  `id` int NOT NULL,
  `patient` int DEFAULT NULL,
  `dietRegime` int DEFAULT NULL,
  `dateOrdered` date DEFAULT NULL,
  `frequency` enum('1','2','3') DEFAULT NULL,
  `prescribedBy` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `DietOrder`
--

INSERT INTO `DietOrder` (`id`, `patient`, `dietRegime`, `dateOrdered`, `frequency`, `prescribedBy`) VALUES
(1, 1, 1, '2023-11-23', '3', '2'),
(2, 2, 2, '2023-11-23', '3', '5'),
(3, 3, 3, '2023-11-23', '3', '1'),
(4, 4, 4, '2023-11-23', '3', '6'),
(5, 5, 5, '2023-11-23', '3', '3'),
(6, 1, 2, '2024-11-01', '1', '3'),
(7, 3, 1, '2024-11-03', '1', '4'),
(8, 4, 5, '2024-11-04', '1', '5'),
(9, 6, 3, '2024-11-06', '3', '3'),
(10, 7, 3, '2024-11-07', '3', '1'),
(11, 8, 5, '2024-11-08', '1', '3'),
(12, 9, 2, '2024-11-09', '1', '1'),
(13, 10, 5, '2024-11-10', '1', '4'),
(14, 11, 5, '2024-11-11', '3', '6'),
(15, 12, 4, '2024-11-12', '1', '3'),
(16, 13, 2, '2024-11-13', '2', '4'),
(17, 14, 4, '2024-11-14', '1', '4'),
(18, 15, 4, '2024-11-15', '3', '3'),
(19, 16, 3, '2024-11-16', '3', '2'),
(20, 17, 5, '2024-11-17', '1', '1'),
(21, 18, 2, '2024-11-18', '1', '5'),
(22, 19, 2, '2024-11-19', '1', '5'),
(23, 19, 3, '2024-11-20', '3', '6');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `DietOrder`
--
ALTER TABLE `DietOrder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient` (`patient`),
  ADD KEY `dietRegime` (`dietRegime`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `DietOrder`
--
ALTER TABLE `DietOrder`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `DietOrder`
--
ALTER TABLE `DietOrder`
  ADD CONSTRAINT `dietorder_ibfk_1` FOREIGN KEY (`patient`) REFERENCES `Patients` (`id`),
  ADD CONSTRAINT `dietorder_ibfk_2` FOREIGN KEY (`dietRegime`) REFERENCES `DietRegimes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
