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
-- Table structure for table `Practitioners`
--

CREATE TABLE `Practitioners` (
  `id` int NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Practitioners`
--

INSERT INTO `Practitioners` (`id`, `firstName`, `lastName`, `userName`, `password`) VALUES
(1, 'Emma', 'Brown', 'emma.brown', 'password123'),
(2, 'Michael', 'Lee', 'michael.lee', 'password456'),
(3, 'Sarah', 'Wilson', 'sarah.wilson', 'password789'),
(4, 'James', 'Taylor', 'james.taylor', 'password101'),
(5, 'Lisa', 'Anderson', 'lisa.anderson', 'password102'),
(6, 'David', 'Martinez', 'david.martinez', 'password103');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Practitioners`
--
ALTER TABLE `Practitioners`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Practitioners`
--
ALTER TABLE `Practitioners`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
