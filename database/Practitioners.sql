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
(1, 'Emma', 'Brown', 'emma.brown', '$2y$10$RFLQTMWSA6d6OTl6vcDVdeQuLBU.8cr.IfHNz4Elx1JEfoa.VHu7K'),
(2, 'Michael', 'Lee', 'michael.lee', '$2y$10$p1Dtxrx9zaH2UAIZx3sJsOctowyCs7a2Reng7TpUh5/NQgomLKb9y'),
(3, 'Sarah', 'Wilson', 'sarah.wilson', '$2y$10$WH8H40O5P5b.KbfIumnYveamQNnW0taMHtG/Ovp7923TGTCT.1niO'),
(4, 'James', 'Taylor', 'james.taylor', '$2y$10$aY1xnuMsd02elI4l8zDXaOQfKRVbdWBVXKQqMNUyIHPSVlj85QKqO'),
(5, 'Lisa', 'Anderson', 'lisa.anderson', '$2y$10$0ZDQleUpHPwFyx9nvcVIdOYy3IqDUua3QQjZKwDN3EZdvlt32m1x2'),
(6, 'David', 'Martinez', 'david.martinez', '$2y$10$8uL2pvqpNOWwKrsSgQwLJ.hs7Z4/L618ZCbYGps2SVFSQxqfwTjZm'),
(7, 'Paris', 'Briggs', 'paris.briggs', '$2y$10$ctUkm8xHh2ycKypCyXRgWOblihB3ol0ZElHvhowsKzvCDrN.YB2Xy'),
(8, 'Michelle', 'Smith', 'michelle.smith', '$2y$10$84TSjWXsGhfNbGMpJ2iHueciFno37hZ2sROtJxSO2vXAQY.31yIqG'),
(9, 'Laila', 'Nelson', 'laila.nelson', '$2y$10$EEeYAV1uxz7PFvHnPvQxPexZuwXDYddYg09xns9VUJW4tS6Twbf8i'),
(10, 'Aayushma', 'Lohani', 'aayushma.lohani', '$2y$10$73XFqzF02kqiCckucjUKweipNaYsu2UxG3Q3ks7WYxTLNYf1abTDm');

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
