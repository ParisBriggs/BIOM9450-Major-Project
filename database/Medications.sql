-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Nov 28, 2024 at 10:32 AM
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
-- Table structure for table `Medications`
--

CREATE TABLE `Medications` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `routeAdmin` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Medications`
--

INSERT INTO `Medications` (`id`, `name`, `routeAdmin`) VALUES
(1, 'Donepezil', 'oral'),
(2, 'Lisinopril', 'oral'),
(3, 'Repaglinide', 'oral'),
(4, 'Insulin', 'injection'),
(5, 'Sitagliptin', 'oral'),
(6, 'Calcium Carbonate', 'oral'),
(7, 'Levodopa-Carbidopa', 'infusion'),
(8, 'Pramipexole', 'oral'),
(9, 'Eldepryl', 'oral'),
(10, 'Alendronate', 'oral'),
(11, 'Risedronate', 'oral'),
(12, 'Vitamin D', 'oral'),
(13, 'Calcium', 'oral');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Medications`
--
ALTER TABLE `Medications`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Medications`
--
ALTER TABLE `Medications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
