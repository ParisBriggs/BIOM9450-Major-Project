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
-- Table structure for table `DietRegimes`
--

CREATE TABLE `DietRegimes` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `food` text NOT NULL,
  `exercise` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `beauty` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `DietRegimes`
--

INSERT INTO `DietRegimes` (`id`, `name`, `food`, `exercise`, `beauty`) VALUES
(1, 'Low Sodium Diet', 'Avoid: processed foods, canned foods, salty snacks, cured meats. \n  Include: fresh fruits and vegetables, lean meats, unsalted nuts, \n  low-sodium dairy products. Limit sodium intake to 2000mg per day.', 'Regular moderate exercise to help regulate blood pressure', 'Monitor for fluid retention'),
(2, 'Low Glycemic Index Diet', 'Avoid: sugary foods, refined carbs, processed snacks.\n  Include: whole grains, legumes, non-starchy vegetables, \n  lean proteins, healthy fats. Choose foods with GI < 55.\n  Monitor carbohydrate portions. Include protein with each meal.', 'Regular post-meal walking to help manage blood sugar', 'Monitor for signs of hypo/hyperglycemia'),
(3, 'Gluten-Free Diet', 'Avoid: wheat, rye, barley, and any derivatives.\n  Include: rice, corn, quinoa, gluten-free oats,\n  fresh fruits and vegetables, meat, fish, eggs, \n  dairy products, legumes, nuts and seeds.\n  Check all processed foods for gluten-containing ingredients.', 'Regular exercise as tolerated', 'Monitor for cross-contamination reactions'),
(4, 'High Protein Diet', 'Include: lean meats, fish, eggs, dairy, legumes,\n  nuts and seeds. Focus on complete proteins.\n  Balance with appropriate carbohydrates and healthy fats.\n  Protein intake adjusted based on body weight and activity.\n  Avoid: excessive processed meats.', 'Strength training and mobility exercises', 'Monitor protein intake and kidney function'),
(5, 'High Calcium Diet', 'Include: dairy products, fortified plant milks,\n  leafy green vegetables, fish with bones,\n  calcium-fortified foods. Combine with vitamin D rich foods.\n  Avoid: excessive caffeine and salt which can affect calcium absorption.', 'Weight-bearing exercises to support bone health', 'Monitor bone density and calcium levels');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `DietRegimes`
--
ALTER TABLE `DietRegimes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `DietRegimes`
--
ALTER TABLE `DietRegimes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
