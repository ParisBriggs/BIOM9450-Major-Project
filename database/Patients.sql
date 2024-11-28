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
-- Table structure for table `Patients`
--

CREATE TABLE `Patients` (
  `id` int NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `sex` enum('male','female') DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `notes` text,
  `emergencyContact` int DEFAULT NULL,
  `room` int DEFAULT NULL,
  `DOB` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Patients`
--

INSERT INTO `Patients` (`id`, `firstName`, `lastName`, `sex`, `photo`, `email`, `phone`, `notes`, `emergencyContact`, `room`, `DOB`) VALUES
(1, 'John', 'Smith', 'male', 'images/profile_image_1.jpg', 'john.smith@email.com', '0400123456', 'Has dementia and high blood pressure. Needs regular monitoring.', 1, 101, '1940-05-15'),
(2, 'Kelly', 'Clarke', 'female', 'images/profile_image_2.jpg', 'kelly.clarke@email.com', '0400234567', 'Type 2 diabetes. Regular glucose monitoring required.', 2, 102, '1955-08-22'),
(3, 'Sarah', 'Johnson', 'female', 'images/profile_image_3.jpg', 'sarah.johnson@email.com', '0400345678', 'Celiac disease and acid reflux. Strict dietary requirements.', 3, 103, '1965-12-10'),
(4, 'Toby', 'Wilson', 'male', 'images/profile_image_4.jpg', 'toby.wilson@email.com', '0400456789', 'Parkinsons disease. Requires assistance with daily activities.', 4, 104, '1950-03-17'),
(5, 'Alex', 'Park', 'male', 'images/profile_image_5.jpeg', 'alex.park@email.com', '0400567890', 'Osteoporosis. Weekly medication schedule.', 5, 105, '1947-06-05'),
(6, 'Emily', 'Brown', 'female', 'images/profile_image_6.jpg', 'emily.brown@example.com', '0401234567', 'Allergic to penicillin.', 6, 106, '1975-04-15'),
(7, 'James', 'Davis', 'male', 'images/profile_image_7.jpg', 'james.davis@example.com', '0402345678', 'Requires regular glucose monitoring.', 7, 107, '1962-10-20'),
(8, 'Sophia', 'Garcia', 'female', 'images/profile_image_8.jpg', 'sophia.garcia@example.com', '0403456789', 'Asthmatic. Needs inhaler readily available.', 8, 108, '1980-03-05'),
(9, 'Liam', 'Wilson', 'male', 'images/profile_image_9.jpg', 'liam.wilson@example.com', '0404567890', 'Recovering from recent surgery.', 9, 109, '1990-12-25'),
(10, 'Mia', 'Martinez', 'female', 'images/profile_image_10.jpg', 'mia.martinez@example.com', '0405678901', 'Diabetic. Needs insulin shots.', 10, 110, '1985-07-08'),
(11, 'Benjamin', 'Taylor', 'male', 'images/profile_image_11.jpg', 'benjamin.taylor@example.com', '0406789012', 'Arthritis. Needs mobility assistance.', 11, 111, '1948-11-19'),
(12, 'Charlotte', 'Anderson', 'female', 'images/profile_image_12.jpg', 'charlotte.anderson@example.com', '0407890123', 'Recovering from a stroke.', 12, 112, '1955-09-11'),
(13, 'Ethan', 'Thomas', 'male', 'images/profile_image_13.jpg', 'ethan.thomas@example.com', '0408901234', 'Chronic back pain. Requires physiotherapy.', 13, 113, '1972-06-29'),
(14, 'Olivia', 'Moore', 'female', 'images/profile_image_14.jpg', 'olivia.moore@example.com', '0411234567', 'High blood pressure.', 14, 114, '1967-01-14'),
(15, 'Noah', 'Jackson', 'male', 'images/profile_image_15.jpg', 'noah.jackson@example.com', '0412345678', 'Recovering from a hip replacement.', 15, 115, '1958-08-30'),
(16, 'Amelia', 'White', 'female', 'images/profile_image_16.jpg', 'amelia.white@example.com', '0413456789', 'Parkinson’s disease. Requires supervision.', 16, 116, '1939-05-21'),
(17, 'Lucas', 'Harris', 'male', 'images/profile_image_17.jpg', 'lucas.harris@example.com', '0414567890', 'Requires assistance with daily activities.', 17, 117, '1995-03-12'),
(18, 'Harper', 'Clark', 'female', 'images/profile_image_18.jpg', 'harper.clark@example.com', '0415678901', 'Dementia. Needs regular monitoring.', 18, 118, '1989-12-02'),
(19, 'Henry', 'Lewis', 'male', 'images/profile_image_19.jpg', 'henry.lewis@example.com', '0416789012', 'High cholesterol. Needs dietary adjustments.', 19, 119, '1976-09-18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Patients`
--
ALTER TABLE `Patients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emergencyContact` (`emergencyContact`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Patients`
--
ALTER TABLE `Patients`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Patients`
--
ALTER TABLE `Patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`emergencyContact`) REFERENCES `EmergencyContacts` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
