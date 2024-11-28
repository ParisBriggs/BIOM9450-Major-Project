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
-- Table structure for table `DietRound`
--

CREATE TABLE `DietRound` (
  `id` int NOT NULL,
  `orderId` int DEFAULT NULL,
  `practitioner` int DEFAULT NULL,
  `roundTime` enum('morning','afternoon','evening') DEFAULT NULL,
  `roundDate` date NOT NULL,
  `status` enum('given','refused','fasting','no stock','ceased') DEFAULT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `DietRound`
--

INSERT INTO `DietRound` (`id`, `orderId`, `practitioner`, `roundTime`, `roundDate`, `status`, `notes`) VALUES
(1, 1, 1, 'morning', '2024-11-28', 'given', 'Fresh fruit and unsalted oatmeal served. Patient ate well.'),
(189, 1, 2, 'morning', '2024-11-21', 'given', 'Patient consumed oatmeal and fruits.'),
(190, 3, 4, 'afternoon', '2024-11-21', 'given', 'Grilled chicken and salad served. Patient ate half.'),
(191, 5, 1, 'evening', '2024-11-21', 'refused', 'Vegetable soup refused. Patient cited dislike for spinach.'),
(192, 2, 5, 'morning', '2024-11-22', 'fasting', 'Patient on fasting for blood test.'),
(193, 4, 3, 'afternoon', '2024-11-22', 'given', 'Steamed fish and broccoli served. Patient ate fully.'),
(194, 6, 2, 'evening', '2024-11-22', 'no stock', 'Low sodium bread was unavailable.'),
(195, 3, 6, 'morning', '2024-11-23', 'given', 'Egg white omelette with whole-grain toast consumed.'),
(196, 5, 1, 'afternoon', '2024-11-23', 'given', 'Grilled salmon with quinoa served. Patient finished the meal.'),
(197, 1, 4, 'evening', '2024-11-23', 'no stock', 'Dietary plan adjusted by doctor. No meal provided.'),
(198, 2, 3, 'morning', '2024-11-24', 'given', 'Smoothie bowl with chia seeds consumed.'),
(199, 4, 2, 'afternoon', '2024-11-24', 'refused', 'Patient refused lentil soup, requested alternative.'),
(200, 5, 5, 'evening', '2024-11-24', 'given', 'Brown rice and roasted vegetables consumed.'),
(201, 1, 1, 'morning', '2024-11-25', 'given', 'Greek yogurt with mixed berries finished.'),
(202, 3, 4, 'afternoon', '2024-11-25', 'no stock', 'Patient requested gluten-free bread, unavailable.'),
(203, 2, 6, 'evening', '2024-11-25', 'given', 'Chicken stew with sweet potatoes served and consumed.'),
(204, 4, 2, 'morning', '2024-11-26', 'given', 'Avocado toast with poached eggs eaten fully.'),
(205, 5, 3, 'afternoon', '2024-11-26', 'fasting', 'Scheduled fasting. Patient hydrated well.'),
(206, 6, 1, 'evening', '2024-11-26', 'given', 'Vegetarian lasagna served and eaten fully.'),
(207, 2, 4, 'morning', '2024-11-27', 'given', 'Banana pancakes with a drizzle of honey consumed.'),
(208, 3, 5, 'afternoon', '2024-11-27', 'refused', 'Patient refused tofu stir-fry due to taste.'),
(209, 1, 6, 'evening', '2024-11-27', 'given', 'Baked cod with mashed potatoes consumed.'),
(210, 5, 2, 'morning', '2024-11-28', 'given', 'Spinach and mushroom omelette consumed.'),
(211, 6, 3, 'afternoon', '2024-11-28', 'given', 'Turkey sandwich with side salad eaten fully.'),
(212, 4, 1, 'evening', '2024-11-28', 'no stock', 'Low glycemic dessert unavailable.'),
(213, 1, 2, 'morning', '2024-11-21', 'given', 'Patient consumed oatmeal and fruits.'),
(214, 3, 4, 'morning', '2024-11-21', 'given', 'Smoothie bowl with nuts consumed.'),
(215, 5, 1, 'afternoon', '2024-11-21', 'refused', 'Grilled chicken refused, patient requested vegetarian option.'),
(216, 6, 3, 'afternoon', '2024-11-21', 'given', 'Salad with vinaigrette dressing consumed.'),
(217, 2, 5, 'evening', '2024-11-21', 'given', 'Vegetable curry with rice consumed.'),
(218, 4, 6, 'evening', '2024-11-21', 'refused', 'Vegetable soup refused, patient cited taste preference.'),
(219, 1, 5, 'morning', '2024-11-22', 'fasting', 'Patient on fasting for blood test.'),
(220, 3, 2, 'morning', '2024-11-22', 'given', 'Avocado toast consumed.'),
(221, 5, 4, 'afternoon', '2024-11-22', 'given', 'Steamed fish and broccoli served and consumed.'),
(222, 6, 1, 'afternoon', '2024-11-22', 'no stock', 'Requested gluten-free bread unavailable.'),
(223, 2, 3, 'evening', '2024-11-22', 'given', 'Vegetarian lasagna consumed.'),
(224, 4, 6, 'evening', '2024-11-22', 'refused', 'Lentil soup refused due to patient dislike.'),
(225, 2, 6, 'morning', '2024-11-23', 'given', 'Egg white omelette with toast consumed.'),
(226, 4, 3, 'morning', '2024-11-23', 'given', 'Banana smoothie with chia seeds consumed.'),
(227, 6, 1, 'afternoon', '2024-11-23', 'given', 'Quinoa salad with grilled salmon consumed.'),
(228, 5, 2, 'afternoon', '2024-11-23', 'no stock', 'Requested low-sodium crackers unavailable.'),
(229, 1, 4, 'evening', '2024-11-23', 'given', 'Vegetable stew consumed.'),
(230, 3, 5, 'evening', '2024-11-23', 'refused', 'Patient refused dessert citing fullness.'),
(231, 1, 1, 'morning', '2024-11-24', 'given', 'Greek yogurt with berries consumed.'),
(232, 2, 3, 'morning', '2024-11-24', 'refused', 'Whole-grain pancakes refused.'),
(233, 4, 2, 'afternoon', '2024-11-24', 'given', 'Grilled chicken with brown rice consumed.'),
(234, 5, 6, 'afternoon', '2024-11-24', 'no stock', 'Low-sodium soy sauce unavailable.'),
(235, 3, 4, 'evening', '2024-11-24', 'given', 'Vegetable stir-fry served and consumed.'),
(236, 6, 5, 'evening', '2024-11-24', 'refused', 'Patient refused evening soup.'),
(237, 2, 2, 'morning', '2024-11-25', 'given', 'Scrambled eggs with toast consumed.'),
(238, 3, 5, 'morning', '2024-11-25', 'given', 'Smoothie bowl consumed.'),
(239, 5, 4, 'afternoon', '2024-11-25', 'refused', 'Patient refused grilled fish.'),
(240, 6, 1, 'afternoon', '2024-11-25', 'given', 'Baked chicken breast consumed.'),
(241, 4, 6, 'evening', '2024-11-25', 'no stock', 'Requested gluten-free pasta unavailable.'),
(242, 1, 3, 'evening', '2024-11-25', 'given', 'Vegetarian lasagna consumed.'),
(243, 1, 4, 'morning', '2024-11-26', 'given', 'Whole-grain cereal with milk consumed.'),
(244, 2, 3, 'morning', '2024-11-26', 'given', 'Smoothie with almond butter consumed.'),
(245, 4, 6, 'afternoon', '2024-11-26', 'given', 'Chicken soup with vegetables consumed.'),
(246, 5, 2, 'afternoon', '2024-11-26', 'fasting', 'Patient scheduled for procedure.'),
(247, 3, 1, 'evening', '2024-11-26', 'given', 'Vegetable curry consumed.'),
(248, 6, 5, 'evening', '2024-11-26', 'refused', 'Lentil soup refused citing taste.'),
(249, 1, 6, 'morning', '2024-11-27', 'given', 'Oatmeal with bananas consumed.'),
(250, 2, 4, 'morning', '2024-11-27', 'refused', 'Breakfast refused citing lack of appetite.'),
(251, 3, 1, 'afternoon', '2024-11-27', 'given', 'Grilled chicken with salad consumed.'),
(252, 5, 2, 'afternoon', '2024-11-27', 'given', 'Quinoa bowl consumed fully.'),
(253, 6, 3, 'evening', '2024-11-27', 'no stock', 'Requested gluten-free bread unavailable.'),
(254, 4, 5, 'evening', '2024-11-27', 'given', 'Brown rice with vegetables consumed.'),
(255, 2, 2, 'morning', '2024-11-28', 'given', 'Spinach omelette consumed.'),
(256, 3, 3, 'morning', '2024-11-28', 'given', 'Greek yogurt and granola consumed.'),
(257, 4, 6, 'afternoon', '2024-11-28', 'given', 'Grilled turkey sandwich consumed.'),
(258, 5, 1, 'afternoon', '2024-11-28', 'no stock', 'Low-calorie drink unavailable.'),
(259, 6, 5, 'evening', '2024-11-28', 'refused', 'Vegetable soup refused citing taste.'),
(260, 1, 4, 'evening', '2024-11-28', 'given', 'Baked salmon with quinoa consumed.'),
(304, 1, 2, 'morning', '2024-11-21', 'given', 'Patient consumed oatmeal and fruits.'),
(305, 3, 4, 'morning', '2024-11-21', 'given', 'Scrambled eggs and toast served. Fully consumed.'),
(306, 4, 5, 'afternoon', '2024-11-21', 'given', 'Grilled chicken and salad served. Fully eaten.'),
(307, 2, 3, 'afternoon', '2024-11-21', 'refused', 'Vegetable wrap was declined.'),
(308, 5, 1, 'evening', '2024-11-21', 'refused', 'Vegetable soup refused. Patient cited dislike for spinach.'),
(309, 6, 6, 'evening', '2024-11-21', 'given', 'Low sodium pasta with tomato sauce eaten.'),
(310, 2, 5, 'morning', '2024-11-22', 'fasting', 'Patient on fasting for blood test.'),
(311, 3, 2, 'morning', '2024-11-22', 'given', 'Cereal with skimmed milk consumed.'),
(312, 4, 3, 'afternoon', '2024-11-22', 'given', 'Steamed fish and broccoli served. Fully eaten.'),
(313, 6, 4, 'afternoon', '2024-11-22', 'given', 'Chicken stir-fry with brown rice served and finished.'),
(314, 5, 1, 'evening', '2024-11-22', 'no stock', 'Low sodium bread unavailable.'),
(315, 1, 6, 'evening', '2024-11-22', 'given', 'Vegetable stew eaten.'),
(316, 3, 6, 'morning', '2024-11-23', 'given', 'Egg white omelette with whole-grain toast consumed.'),
(317, 1, 2, 'morning', '2024-11-23', 'refused', 'Patient skipped breakfast due to nausea.'),
(318, 5, 1, 'afternoon', '2024-11-23', 'given', 'Grilled salmon with quinoa served. Finished meal.'),
(319, 4, 3, 'afternoon', '2024-11-23', 'given', 'Vegetable curry with rice served. Fully consumed.'),
(320, 2, 5, 'evening', '2024-11-23', 'no stock', 'Dietary plan adjusted by doctor. No meal provided.'),
(321, 6, 4, 'evening', '2024-11-23', 'given', 'Vegetarian lasagna eaten fully.'),
(322, 2, 3, 'morning', '2024-11-24', 'given', 'Yogurt and granola served. Finished fully.'),
(323, 4, 5, 'morning', '2024-11-24', 'refused', 'Scrambled eggs were refused due to allergy.'),
(324, 5, 1, 'afternoon', '2024-11-24', 'given', 'Chicken sandwich served. Fully consumed.'),
(325, 3, 6, 'afternoon', '2024-11-24', 'given', 'Vegetable pizza served and eaten.'),
(326, 6, 2, 'evening', '2024-11-24', 'given', 'Beef stew with mashed potatoes eaten.'),
(327, 1, 4, 'evening', '2024-11-24', 'refused', 'Fish casserole declined due to lack of appetite.'),
(328, 1, 3, 'morning', '2024-11-25', 'given', 'Smoothie bowl with mixed fruits eaten.'),
(329, 2, 4, 'morning', '2024-11-25', 'given', 'Pancakes with syrup served and finished.'),
(330, 3, 5, 'afternoon', '2024-11-25', 'given', 'Grilled turkey with vegetables served. Finished fully.'),
(331, 4, 6, 'afternoon', '2024-11-25', 'given', 'Vegetarian chili with cornbread eaten.'),
(332, 5, 1, 'evening', '2024-11-25', 'given', 'Spaghetti with meatballs served and eaten.'),
(333, 6, 2, 'evening', '2024-11-25', 'no stock', 'Low-sodium crackers unavailable.'),
(334, 4, 3, 'morning', '2024-11-26', 'given', 'Boiled eggs and avocado toast eaten.'),
(335, 2, 5, 'morning', '2024-11-26', 'refused', 'Breakfast bar refused due to lack of appetite.'),
(336, 1, 6, 'afternoon', '2024-11-26', 'given', 'Grilled tuna and green salad served. Fully eaten.'),
(337, 5, 1, 'afternoon', '2024-11-26', 'given', 'Chicken noodle soup eaten fully.'),
(338, 3, 4, 'evening', '2024-11-26', 'refused', 'Vegetarian stir-fry refused.'),
(339, 6, 2, 'evening', '2024-11-26', 'given', 'Beef burger with whole-grain bun consumed.'),
(340, 5, 1, 'morning', '2024-11-27', 'given', 'Oatmeal with honey consumed.'),
(341, 4, 2, 'morning', '2024-11-27', 'given', 'Greek yogurt with mixed nuts served and eaten.'),
(342, 3, 6, 'afternoon', '2024-11-27', 'given', 'Lentil soup with garlic bread fully eaten.'),
(343, 1, 5, 'afternoon', '2024-11-27', 'refused', 'Salad wrap refused due to dislike for lettuce.'),
(344, 2, 3, 'evening', '2024-11-27', 'given', 'Chicken curry with naan bread served. Fully eaten.'),
(345, 6, 4, 'evening', '2024-11-27', 'fasting', 'Patient fasting for medical procedure.'),
(346, 2, 5, 'evening', '2024-11-27', 'given', 'Vegetable lasagna served. Finished fully.'),
(347, 1, 2, 'morning', '2024-11-21', 'given', 'Patient consumed oatmeal and fruits.'),
(348, 3, 4, 'morning', '2024-11-21', 'given', 'Scrambled eggs and toast served. Fully consumed.'),
(349, 7, 5, 'morning', '2024-11-21', 'refused', 'Yogurt with granola refused.'),
(350, 4, 3, 'afternoon', '2024-11-21', 'given', 'Grilled chicken and salad served. Fully eaten.'),
(351, 2, 1, 'afternoon', '2024-11-21', 'refused', 'Vegetable wrap was declined.'),
(352, 5, 6, 'evening', '2024-11-21', 'given', 'Low sodium pasta with tomato sauce eaten.'),
(353, 9, 2, 'evening', '2024-11-21', 'given', 'Vegetable curry with rice consumed.'),
(354, 6, 3, 'evening', '2024-11-21', 'no stock', 'Soup not available due to stock shortage.'),
(355, 2, 5, 'morning', '2024-11-22', 'fasting', 'Patient on fasting for blood test.'),
(356, 3, 2, 'morning', '2024-11-22', 'given', 'Cereal with skimmed milk consumed.'),
(357, 8, 4, 'morning', '2024-11-22', 'given', 'Fruit salad and toast served. Fully eaten.'),
(358, 4, 3, 'afternoon', '2024-11-22', 'given', 'Steamed fish and broccoli served. Fully eaten.'),
(359, 6, 6, 'afternoon', '2024-11-22', 'refused', 'Chicken stir-fry with brown rice declined.'),
(360, 10, 1, 'evening', '2024-11-22', 'given', 'Vegetable soup with bread consumed.'),
(361, 11, 5, 'evening', '2024-11-22', 'refused', 'Dietary adjustment by practitioner. Meal skipped.'),
(362, 12, 3, 'evening', '2024-11-22', 'no stock', 'Fruit yogurt unavailable.'),
(363, 3, 6, 'morning', '2024-11-23', 'given', 'Egg white omelette with whole-grain toast consumed.'),
(364, 7, 4, 'morning', '2024-11-23', 'fasting', 'Patient fasting for glucose test.'),
(365, 5, 2, 'morning', '2024-11-23', 'refused', 'Porridge refused due to texture complaints.'),
(366, 2, 1, 'afternoon', '2024-11-23', 'given', 'Grilled salmon with quinoa served. Patient finished meal.'),
(367, 4, 3, 'afternoon', '2024-11-23', 'given', 'Vegetable stir-fry with tofu consumed.'),
(368, 6, 5, 'evening', '2024-11-23', 'no stock', 'Dietary plan adjusted by doctor. No meal provided.'),
(369, 9, 2, 'evening', '2024-11-23', 'given', 'Whole-grain spaghetti with lentil bolognese eaten.'),
(370, 10, 6, 'evening', '2024-11-23', 'refused', 'Soup refused due to sodium content.'),
(371, 1, 4, 'morning', '2024-11-24', 'given', 'Pancakes with syrup consumed.'),
(372, 2, 5, 'morning', '2024-11-24', 'given', 'Scrambled eggs with vegetables served. Fully eaten.'),
(373, 3, 3, 'morning', '2024-11-24', 'refused', 'Oatmeal with nuts declined.'),
(374, 4, 6, 'afternoon', '2024-11-24', 'given', 'Grilled chicken and steamed vegetables eaten.'),
(375, 5, 2, 'afternoon', '2024-11-24', 'refused', 'Vegetable stew declined.'),
(376, 6, 1, 'evening', '2024-11-24', 'given', 'Vegetable soup and whole-grain bread consumed.'),
(377, 7, 3, 'evening', '2024-11-24', 'no stock', 'Brown rice unavailable.'),
(378, 8, 5, 'evening', '2024-11-24', 'refused', 'Dietary change advised. No meal provided.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `DietRound`
--
ALTER TABLE `DietRound`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orderId` (`orderId`),
  ADD KEY `practitioner` (`practitioner`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `DietRound`
--
ALTER TABLE `DietRound`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=379;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `DietRound`
--
ALTER TABLE `DietRound`
  ADD CONSTRAINT `dietround_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `DietOrder` (`id`),
  ADD CONSTRAINT `dietround_ibfk_2` FOREIGN KEY (`practitioner`) REFERENCES `Practitioners` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
