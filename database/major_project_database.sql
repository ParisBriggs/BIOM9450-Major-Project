-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Nov 28, 2024 at 08:25 AM
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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePatient` (IN `patientID` INTEGER)   BEGIN
    -- First get the emergency contact ID
    DECLARE contactID INTEGER;
    
    -- Get emergency contact ID before deleting patient
    SELECT emergencyContact INTO contactID FROM Patients WHERE id = patientID;
    
    -- Delete the patient
    DELETE FROM Patients WHERE id = patientID;
    
    -- Delete the emergency contact if it exists
    IF contactID IS NOT NULL THEN
        DELETE FROM EmergencyContacts WHERE id = contactID;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllPatientInfoByFullName` (IN `firstName` VARCHAR(255), IN `lastName` VARCHAR(255))   BEGIN
    SELECT 
        p.id AS patientID,
        p.photo AS photoUrl,
        p.firstName AS patientFirstName,
        p.lastName AS patientLastName,
        p.sex,
        p.email AS patientEmail,
        p.phone AS patientPhone,
        p.room,
        p.notes,
        ec.firstName AS emergencyContactFirstName,
        ec.lastName AS emergencyContactLastName,
        ec.relationship,
        ec.email AS emergencyContactEmail,
        ec.phone AS emergencyContactPhone
    FROM 
        Patients p
        LEFT JOIN EmergencyContacts ec ON p.emergencyContact = ec.id
    WHERE 
        p.firstName LIKE firstName AND p.lastName LIKE lastName;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllPatientInfoByRoom` (IN `room` INTEGER)   BEGIN
    SELECT 
        p.id AS patientID,
        p.photo AS photoUrl,
        p.firstName AS patientFirstName,
        p.lastName AS patientLastName,
        p.sex,
        p.email AS patientEmail,
        p.phone AS patientPhone,
        p.room,
        p.notes,
        ec.firstName AS emergencyContactFirstName,
        ec.lastName AS emergencyContactLastName,
        ec.relationship,
        ec.email AS emergencyContactEmail,
        ec.phone AS emergencyContactPhone
    FROM 
        Patients p
        LEFT JOIN EmergencyContacts ec ON p.emergencyContact = ec.id
    WHERE 
        p.room = room;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBasicPatientByFullName` (IN `searchName` VARCHAR(255))   BEGIN
    SELECT 
        p.id AS patientID,
        CONCAT(p.firstName, ' ', p.lastName) AS fullName,
        p.photo AS photoUrl,
        p.room
    FROM 
        Patients p
    WHERE 
        LOWER(CONCAT(p.firstName, ' ', p.lastName)) LIKE LOWER(CONCAT('%', searchName, '%'));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBasicPatientByRoomNum` (IN `room` INTEGER)   BEGIN
    SELECT 
        p.id AS patientID,
        CONCAT(p.firstName, ' ', p.lastName) AS fullName,
        p.photo AS photoUrl,
        p.room
    FROM 
        Patients p
    WHERE 
        p.room = room;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetBasicPatients` ()   BEGIN
    SELECT 
        p.id AS patientID,
        CONCAT(p.firstName, ' ', p.lastName) AS fullName,
        p.photo AS photoUrl,
        p.room
    FROM 
        Patients p
    ORDER BY 
        p.room;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientDiets` (IN `patientId` INTEGER)   BEGIN
    SELECT DISTINCT
        d.name AS dietName,
        d.food AS food,
        d.excercise AS excercise,
        d.beauty AS beauty,
        do.frequency AS timesPerDay
    FROM 
        DietOrder do
        JOIN DietRegimes d ON do.dietRegime = d.id
    WHERE 
        do.patient = patientId
        AND do.dateOrdered = (
            -- Get the most recent order for each medication
            SELECT MAX(do2.dateOrdered)
            FROM DietOrder do2
            WHERE do2.patient = patientId
            AND do2.dietRegime = do.dietRegime
        )
    ORDER BY 
        d.name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientMedications` (IN `patientId` INTEGER)   BEGIN
    SELECT DISTINCT
        m.name AS medicationName,
        mo.dosage AS dosage,
        m.routeAdmin AS administrationRoute,
        mo.frequency AS timesPerDay
    FROM 
        MedicationOrder mo
        JOIN Medications m ON mo.medication = m.id
    WHERE 
        mo.patient = patientId
        AND mo.dateOrdered = (
            -- Get the most recent order for each medication
            SELECT MAX(mo2.dateOrdered)
            FROM MedicationOrder mo2
            WHERE mo2.patient = patientId
            AND mo2.medication = mo.medication
        )
    ORDER BY 
        m.name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertPatientWithContact` (IN `ec_firstName` VARCHAR(255), IN `ec_lastName` VARCHAR(255), IN `ec_relationship` VARCHAR(255), IN `ec_email` VARCHAR(255), IN `ec_phone` VARCHAR(10), IN `p_firstName` VARCHAR(255), IN `p_lastName` VARCHAR(255), IN `p_sex` ENUM('male','female'), IN `p_photo` VARCHAR(255), IN `p_email` VARCHAR(255), IN `p_phone` VARCHAR(10), IN `p_notes` TEXT, IN `p_room` INTEGER)   BEGIN
    DECLARE new_contact_id INT;
    
    -- Insert Emergency Contact
    INSERT INTO EmergencyContacts (
        firstName,
        lastName,
        relationship,
        email,
        phone
    ) VALUES (
        ec_firstName,
        ec_lastName,
        ec_relationship,
        ec_email,
        ec_phone
    );
    
    SET new_contact_id = LAST_INSERT_ID();
    
    -- Insert Patient
    INSERT INTO Patients (
        firstName,
        lastName,
        sex,
        photo,
        email,
        phone,
        notes,
        emergencyContact,
        room
    ) VALUES (
        p_firstName,
        p_lastName,
        p_sex,
        p_photo,
        p_email,
        p_phone,
        p_notes,
        new_contact_id,
        p_room
    );
END$$

DELIMITER ;

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
-- Indexes for table `DietOrder`
--
ALTER TABLE `DietOrder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient` (`patient`),
  ADD KEY `dietRegime` (`dietRegime`);

--
-- Indexes for table `DietRegimes`
--
ALTER TABLE `DietRegimes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `DietRound`
--
ALTER TABLE `DietRound`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orderId` (`orderId`),
  ADD KEY `practitioner` (`practitioner`);

--
-- Indexes for table `EmergencyContacts`
--
ALTER TABLE `EmergencyContacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `MedicationOrder`
--
ALTER TABLE `MedicationOrder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient` (`patient`),
  ADD KEY `medication` (`medication`);

--
-- Indexes for table `MedicationRound`
--
ALTER TABLE `MedicationRound`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orderId` (`orderId`),
  ADD KEY `practitioner` (`practitioner`);

--
-- Indexes for table `Medications`
--
ALTER TABLE `Medications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Patients`
--
ALTER TABLE `Patients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emergencyContact` (`emergencyContact`);

--
-- Indexes for table `Practitioners`
--
ALTER TABLE `Practitioners`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `DietOrder`
--
ALTER TABLE `DietOrder`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `DietRegimes`
--
ALTER TABLE `DietRegimes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `DietRound`
--
ALTER TABLE `DietRound`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=379;

--
-- AUTO_INCREMENT for table `EmergencyContacts`
--
ALTER TABLE `EmergencyContacts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `MedicationOrder`
--
ALTER TABLE `MedicationOrder`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `MedicationRound`
--
ALTER TABLE `MedicationRound`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=269;

--
-- AUTO_INCREMENT for table `Medications`
--
ALTER TABLE `Medications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `Patients`
--
ALTER TABLE `Patients`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `Practitioners`
--
ALTER TABLE `Practitioners`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `DietOrder`
--
ALTER TABLE `DietOrder`
  ADD CONSTRAINT `dietorder_ibfk_1` FOREIGN KEY (`patient`) REFERENCES `Patients` (`id`),
  ADD CONSTRAINT `dietorder_ibfk_2` FOREIGN KEY (`dietRegime`) REFERENCES `DietRegimes` (`id`);

--
-- Constraints for table `DietRound`
--
ALTER TABLE `DietRound`
  ADD CONSTRAINT `dietround_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `DietOrder` (`id`),
  ADD CONSTRAINT `dietround_ibfk_2` FOREIGN KEY (`practitioner`) REFERENCES `Practitioners` (`id`);

--
-- Constraints for table `MedicationOrder`
--
ALTER TABLE `MedicationOrder`
  ADD CONSTRAINT `medicationorder_ibfk_1` FOREIGN KEY (`patient`) REFERENCES `Patients` (`id`),
  ADD CONSTRAINT `medicationorder_ibfk_2` FOREIGN KEY (`medication`) REFERENCES `Medications` (`id`);

--
-- Constraints for table `MedicationRound`
--
ALTER TABLE `MedicationRound`
  ADD CONSTRAINT `medicationround_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `MedicationOrder` (`id`),
  ADD CONSTRAINT `medicationround_ibfk_2` FOREIGN KEY (`practitioner`) REFERENCES `Practitioners` (`id`);

--
-- Constraints for table `Patients`
--
ALTER TABLE `Patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`emergencyContact`) REFERENCES `EmergencyContacts` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
