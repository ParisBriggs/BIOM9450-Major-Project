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
-- Table structure for table `MedicationRound`
--

CREATE TABLE `MedicationRound` (
  `id` int NOT NULL,
  `orderId` int DEFAULT NULL,
  `practitioner` int DEFAULT NULL,
  `roundTime` enum('morning','afternoon','evening') DEFAULT NULL,
  `status` enum('given','refused','fasting','no stock','ceased') DEFAULT NULL,
  `notes` text,
  `roundDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `MedicationRound`
--

INSERT INTO `MedicationRound` (`id`, `orderId`, `practitioner`, `roundTime`, `status`, `notes`, `roundDate`) VALUES
(1, 1, 1, 'morning', 'given', 'Taken with water', '2024-11-20'),
(196, 1, 2, 'morning', 'given', 'Medication administered as per schedule.', '2024-11-21'),
(197, 2, 3, 'afternoon', 'refused', 'Patient declined medication due to nausea.', '2024-11-21'),
(198, 19, 1, 'evening', 'given', 'Medication taken with water. No issues reported.', '2024-11-21'),
(199, 4, 4, 'morning', 'fasting', 'Patient fasting for procedure. Medication deferred.', '2024-11-21'),
(200, 5, 5, 'afternoon', 'no stock', 'Medication unavailable in stock. Pharmacy notified.', '2024-11-21'),
(201, 6, 6, 'evening', 'given', 'Medication administered. Patient responded well.', '2024-11-21'),
(202, 7, 2, 'morning', 'given', 'Patient took medication with juice. No complaints.', '2024-11-22'),
(203, 8, 3, 'afternoon', 'refused', 'Medication refused citing dizziness.', '2024-11-22'),
(204, 9, 1, 'evening', 'given', 'Administered at bedside. Patient compliant.', '2024-11-22'),
(205, 10, 4, 'morning', 'fasting', 'Deferred due to fasting for lab tests.', '2024-11-22'),
(206, 11, 5, 'afternoon', 'no stock', 'Backordered medication not yet delivered.', '2024-11-22'),
(207, 12, 6, 'evening', 'given', 'Successfully given. Patient thanked nurse.', '2024-11-22'),
(208, 13, 2, 'morning', 'given', 'Patient took medication with water. Observed for side effects.', '2024-11-23'),
(209, 14, 3, 'afternoon', 'refused', 'Medication declined due to reported headache.', '2024-11-23'),
(210, 15, 1, 'evening', 'given', 'Taken on time. Patient stable.', '2024-11-23'),
(211, 16, 4, 'morning', 'fasting', 'Postponed for fasting. Advised patient.', '2024-11-23'),
(212, 17, 5, 'afternoon', 'no stock', 'Shortage of medication reported to administration.', '2024-11-23'),
(213, 18, 6, 'evening', 'given', 'Administered at scheduled time. Patient showed no adverse effects.', '2024-11-23'),
(214, 1, 2, 'morning', 'given', 'Medication administered on time.', '2024-11-24'),
(215, 2, 3, 'afternoon', 'refused', 'Patient declined medication. Reason unclear.', '2024-11-24'),
(216, 19, 1, 'evening', 'given', 'Patient compliant. No issues observed.', '2024-11-24'),
(217, 4, 4, 'morning', 'fasting', 'Medication skipped for scheduled fasting.', '2024-11-24'),
(218, 5, 5, 'afternoon', 'no stock', 'Pharmacy notified of ongoing shortage.', '2024-11-24'),
(219, 6, 6, 'evening', 'given', 'Medication administered. Patient stable.', '2024-11-24'),
(220, 7, 2, 'morning', 'given', 'Administered with no complications.', '2024-11-25'),
(221, 8, 3, 'afternoon', 'refused', 'Patient expressed reluctance to take medication.', '2024-11-25'),
(222, 9, 1, 'evening', 'given', 'Successfully taken by patient.', '2024-11-25'),
(223, 10, 4, 'morning', 'fasting', 'Deferred for fasting protocol.', '2024-11-25'),
(224, 11, 5, 'afternoon', 'no stock', 'Medication backorder reported.', '2024-11-25'),
(225, 12, 6, 'evening', 'given', 'Patient stable after administration.', '2024-11-25'),
(226, 4, 4, 'morning', 'given', 'Medication administered without issues.', '2024-11-26'),
(227, 5, 1, 'morning', 'no stock', 'Medication out of stock, replacement pending.', '2024-11-26'),
(228, 7, 6, 'afternoon', 'given', 'Patient took medication with lunch. No side effects reported.', '2024-11-26'),
(229, 9, 3, 'afternoon', 'refused', 'Patient refused due to nausea. Noted for follow-up.', '2024-11-26'),
(230, 11, 2, 'evening', 'given', 'Administered before dinner. No complications.', '2024-11-26'),
(231, 13, 5, 'evening', 'fasting', 'Patient fasting for overnight tests.', '2024-11-26'),
(232, 2, 4, 'morning', 'given', 'Medication given with water. Patient stable.', '2024-11-27'),
(233, 4, 6, 'morning', 'refused', 'Patient refused due to prior side effects.', '2024-11-27'),
(234, 6, 2, 'afternoon', 'no stock', 'Medication unavailable. Pharmacy notified.', '2024-11-27'),
(235, 8, 3, 'afternoon', 'given', 'Administered with juice. Patient in good condition.', '2024-11-27'),
(236, 10, 1, 'evening', 'given', 'Night dose completed. Monitoring patient overnight.', '2024-11-27'),
(237, 12, 5, 'evening', 'fasting', 'Fasting for next-day procedures. No dose given.', '2024-11-27'),
(238, 1, 2, 'morning', 'given', 'Morning dose administered successfully. No adverse reactions.', '2024-11-26'),
(239, 2, 5, 'afternoon', 'given', 'Patient took medication after lunch. Observing good response.', '2024-11-26'),
(240, 4, 3, 'evening', 'no stock', 'Medication not available. Pharmacy notified.', '2024-11-26'),
(241, 6, 1, 'morning', 'refused', 'Patient refused due to dizziness. Will attempt later.', '2024-11-26'),
(242, 8, 4, 'afternoon', 'given', 'Administered successfully with meal.', '2024-11-26'),
(243, 9, 6, 'evening', 'fasting', 'Fasting for upcoming surgery. Medication skipped.', '2024-11-26'),
(244, 10, 5, 'morning', 'given', 'Medication given. Patient reported improvement.', '2024-11-26'),
(245, 12, 2, 'afternoon', 'refused', 'Patient declined. Noted for follow-up.', '2024-11-26'),
(246, 13, 3, 'evening', 'given', 'Administered successfully. No issues reported.', '2024-11-26'),
(247, 14, 6, 'morning', 'given', 'Morning dose completed.', '2024-11-26'),
(248, 15, 1, 'afternoon', 'given', 'Patient compliant. Dose taken with water.', '2024-11-26'),
(249, 16, 4, 'evening', 'given', 'Night dose administered without issues.', '2024-11-26'),
(250, 17, 2, 'morning', 'fasting', 'Skipped due to fasting for tests.', '2024-11-26'),
(251, 18, 3, 'afternoon', 'refused', 'Patient reported discomfort and refused medication.', '2024-11-26'),
(252, 19, 5, 'evening', 'given', 'Medication administered as prescribed.', '2024-11-26'),
(253, 1, 2, 'morning', 'given', 'Morning dose completed. Patient stable.', '2024-11-27'),
(254, 2, 4, 'afternoon', 'given', 'Administered after lunch. Patient reports feeling better.', '2024-11-27'),
(255, 5, 6, 'evening', 'refused', 'Patient declined due to prior nausea.', '2024-11-27'),
(256, 7, 1, 'morning', 'fasting', 'Medication skipped due to fasting.', '2024-11-27'),
(257, 8, 5, 'afternoon', 'no stock', 'Medication unavailable. Pharmacy will restock.', '2024-11-27'),
(258, 9, 3, 'evening', 'given', 'Dose administered successfully. No side effects reported.', '2024-11-27'),
(259, 10, 2, 'morning', 'given', 'Morning medication given with water.', '2024-11-27'),
(260, 11, 4, 'afternoon', 'given', 'Afternoon dose completed. No issues noted.', '2024-11-27'),
(261, 12, 6, 'evening', 'refused', 'Patient refused due to headache. Noted for follow-up.', '2024-11-27'),
(262, 13, 1, 'morning', 'given', 'Administered successfully. Patient stable.', '2024-11-27'),
(263, 14, 5, 'afternoon', 'given', 'Afternoon dose completed without issues.', '2024-11-27'),
(264, 15, 3, 'evening', 'no stock', 'Medication unavailable for evening dose.', '2024-11-27'),
(265, 16, 2, 'morning', 'given', 'Morning dose administered as per schedule.', '2024-11-27'),
(266, 17, 4, 'afternoon', 'fasting', 'Skipped dose due to patient fasting.', '2024-11-27'),
(267, 18, 6, 'evening', 'given', 'Administered successfully before bed.', '2024-11-27'),
(268, 19, 1, 'morning', 'given', 'Patient compliant. Dose completed with no issues.', '2024-11-27');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `MedicationRound`
--
ALTER TABLE `MedicationRound`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orderId` (`orderId`),
  ADD KEY `practitioner` (`practitioner`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `MedicationRound`
--
ALTER TABLE `MedicationRound`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=269;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `MedicationRound`
--
ALTER TABLE `MedicationRound`
  ADD CONSTRAINT `medicationround_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `MedicationOrder` (`id`),
  ADD CONSTRAINT `medicationround_ibfk_2` FOREIGN KEY (`practitioner`) REFERENCES `Practitioners` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
