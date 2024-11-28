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
-- Table structure for table `EmergencyContacts`
--

CREATE TABLE `EmergencyContacts` (
  `id` int NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `relationship` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `EmergencyContacts`
--

INSERT INTO `EmergencyContacts` (`id`, `firstName`, `lastName`, `relationship`, `email`, `phone`) VALUES
(1, 'Mary', 'Smith', 'Wife', 'mary.smith@email.com', '0412345678'),
(2, 'David', 'Clarke', 'Husband', 'david.clarke@email.com', '0423456789'),
(3, 'Michael', 'Johnson', 'Son', 'michael.j@email.com', '0434567890'),
(4, 'Emma', 'Wilson', 'Daughter', 'emma.wilson@email.com', '0445678901'),
(5, 'Jennifer', 'Park', 'Sister', 'jen.park@email.com', '0456789012'),
(6, 'Mary', 'Johnson', 'Daughter', 'mary.johnson@example.com', '0401123456'),
(7, 'James', 'Anderson', 'Son', 'james.anderson@example.com', '0402234567'),
(8, 'Emma', 'Taylor', 'Daughter', 'emma.taylor@example.com', '0403345678'),
(9, 'William', 'Clark', 'Son', 'william.clark@example.com', '0404456789'),
(10, 'Alice', 'Brown', 'Daughter', 'alice.brown@email.com', '0405567890'),
(11, 'Henry', 'Miller', 'Son', 'henry.miller@email.com', '0406678901'),
(12, 'Olivia', 'Williams', 'Niece', 'olivia.williams@email.com', '0407789012'),
(13, 'Ethan', 'Davis', 'Grandson', 'ethan.davis@email.com', '0408890123'),
(14, 'Charlotte', 'Moore', 'Daughter', 'charlotte.moore@email.com', '0409901234'),
(15, 'Lucas', 'Taylor', 'Son', 'lucas.taylor@email.com', '0410012345'),
(16, 'Amelia', 'Wilson', 'Daughter', 'amelia.wilson@email.com', '0411123456'),
(17, 'Mason', 'Anderson', 'Son', 'mason.anderson@email.com', '0412234567'),
(18, 'Sophia', 'Harris', 'Daughter', 'sophia.harris@email.com', '0413345678'),
(19, 'Liam', 'Clark', 'Son', 'liam.clark@email.com', '0414456789');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `EmergencyContacts`
--
ALTER TABLE `EmergencyContacts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `EmergencyContacts`
--
ALTER TABLE `EmergencyContacts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
