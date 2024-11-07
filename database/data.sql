USE biom9450;

-- Emergency Contacts first (no foreign key dependencies)
INSERT INTO EmergencyContacts (firstName, lastName, relationship, email, phone) VALUES
('Mary', 'Smith', 'Wife', 'mary.smith@email.com', '0412345678'),
('David', 'Clarke', 'Husband', 'david.clarke@email.com', '0423456789'),
('Michael', 'Johnson', 'Son', 'michael.j@email.com', '0434567890'),
('Emma', 'Wilson', 'Daughter', 'emma.wilson@email.com', '0445678901'),
('Jennifer', 'Park', 'Sister', 'jen.park@email.com', '0456789012');

-- Patients with complete information
INSERT INTO Patients (firstName, lastName, sex, email, phone, notes, emergencyContact, room) VALUES
('John', 'Smith', 'male', 'john.smith@email.com', '0400123456', 'Has dementia and high blood pressure. Needs regular monitoring.', 1, 101),
('Kelly', 'Clarke', 'female', 'kelly.clarke@email.com', '0400234567', 'Type 2 diabetes. Regular glucose monitoring required.', 2, 102),
('Sarah', 'Johnson', 'female', 'sarah.johnson@email.com', '0400345678', 'Celiac disease and acid reflux. Strict dietary requirements.', 3, 103),
('Toby', 'Wilson', 'male', 'toby.wilson@email.com', '0400456789', 'Parkinsons disease. Requires assistance with daily activities.', 4, 104),
('Alex', 'Park', 'male', 'alex.park@email.com', '0400567890', 'Osteoporosis. Weekly medication schedule.', 5, 105);

-- Practitioners
INSERT INTO Practitioners (firstName, lastName, userName, password) VALUES
('Emma', 'Brown', 'emma.brown', 'password123'),
('Michael', 'Lee', 'michael.lee', 'password456'),
('Sarah', 'Wilson', 'sarah.wilson', 'password789'),
('James', 'Taylor', 'james.taylor', 'password101'),
('Lisa', 'Anderson', 'lisa.anderson', 'password102'),
('David', 'Martinez', 'david.martinez', 'password103');

-- Medications
INSERT INTO Medications (name, routeAdmin) VALUES
('Donepezil', 'oral'),
('Lisinopril', 'oral'),
('Repaglinide', 'oral'),
('Insulin', 'injection'),
('Sitagliptin', 'oral'),
('Calcium Carbonate', 'oral'),
('Levodopa-Carbidopa', 'infusion'),
('Pramipexole', 'oral'),
('Eldepryl', 'oral'),
('Alendronate', 'oral'),
('Risedronate', 'oral'),
('Vitamin D', 'oral'),
('Calcium', 'oral');

-- Diet Regimes
INSERT INTO DietRegimes (name, food, excercise, beauty) VALUES
('John Smith Diet', 'Low sodium, fiber-rich foods, low caffeine, ensure enough hydration. No caffeine, low salt, moderate fat.', 'Regular walking as tolerated, seated exercises', 'Regular grooming assistance needed'),
('Kelly Clarke Diet', 'Low glycemic index foods, high fiber, balanced macronutrients. Afternoon sweet snack allowed.', 'Light exercise after meals, daily walking', 'Independent, no assistance needed'),
('Sarah Johnson Diet', 'Gluten-free, low-acid, low-fat, and high fiber food. Celiac-friendly meals.', 'Regular walking, gentle stretching', 'Independent, no assistance needed'),
('Toby Wilson Diet', 'Nutrient-dense foods for brain health, high fiber, protein adjusted to Levodopa levels', 'Assisted mobility exercises, physical therapy', 'Requires daily grooming assistance'),
('Alex Park Diet', 'High in calcium, vitamin D, magnesium, and protein-rich food. Glass of milk morning and evening', 'Weight-bearing exercises, balance training', 'Independent with safety monitoring');

-- Medication Orders for past week (23-29 Nov), current week (30 Nov-7 Dec), and future week (8-14 Dec)
INSERT INTO MedicationOrder (patient, medication, dateOrdered, dateDue, dosage) VALUES
-- John Smith (showing full pattern)
-- Past week (23-29 Nov)
(1, 2, '2023-11-23', '2023-11-23', 5.0),  -- Morning Lisinopril
(1, 1, '2023-11-23', '2023-11-23', 5.0),  -- Evening Donepezil
(1, 2, '2023-11-24', '2023-11-24', 5.0),
(1, 1, '2023-11-24', '2023-11-24', 5.0),
(1, 2, '2023-11-25', '2023-11-25', 5.0),
(1, 1, '2023-11-25', '2023-11-25', 5.0),
(1, 2, '2023-11-26', '2023-11-26', 5.0),
(1, 1, '2023-11-26', '2023-11-26', 5.0),
(1, 2, '2023-11-27', '2023-11-27', 5.0),
(1, 1, '2023-11-27', '2023-11-27', 5.0),
(1, 2, '2023-11-28', '2023-11-28', 5.0),
(1, 1, '2023-11-28', '2023-11-28', 5.0),
(1, 2, '2023-11-29', '2023-11-29', 5.0),
(1, 1, '2023-11-29', '2023-11-29', 5.0),

-- Kelly Clarke (showing one day pattern - repeat for other days)
(2, 3, '2023-11-23', '2023-11-23', 2.0),  -- Morning Repaglinide
(2, 4, '2023-11-23', '2023-11-23', NULL), -- Morning Insulin (variable dosage)
(2, 5, '2023-11-23', '2023-11-23', 25.0), -- Evening Sitagliptin

-- Sarah Johnson (showing one day - variable depending on symptoms)
(3, 6, '2023-11-23', '2023-11-23', 640.0), -- Calcium Carbonate as needed

-- Toby Wilson (one day pattern)
(4, 7, '2023-11-23', '2023-11-23', 0.125), -- Levodopa-Carbidopa
(4, 8, '2023-11-23', '2023-11-23', 0.125), -- Pramipexole
(4, 9, '2023-11-23', '2023-11-23', 5.0),   -- Eldepryl

-- Alex Park (one day pattern)
(5, 10, '2023-11-23', '2023-11-23', 35.0), -- Weekly Alendronate
(5, 11, '2023-11-23', '2023-11-23', 5.0),  -- Daily Risedronate
(5, 12, '2023-11-23', '2023-11-23', 600.0); -- Daily Vitamin D

-- Add varied status Medication Rounds
INSERT INTO MedicationRound (orderId, practitioner, status, notes) VALUES
(1, 1, 'given', 'Taken with water'),
(2, 1, 'refused', 'Patient initially refused, taken after discussion'),
(3, 2, 'given', 'Taken with breakfast'),
(4, 2, 'no stock', 'Pharmacy notified, will deliver tomorrow'),
(5, 3, 'given', 'Taken as scheduled'),
(6, 3, 'fasting', 'NPO for morning procedure'),
(7, 4, 'ceased', 'Discontinued per doctor orders'),
(8, 1, 'given', 'Administered with lunch'),
(9, 2, 'given', 'Given at bedtime'),
(10, 3, 'refused', 'Patient sleeping, will try later');

-- Diet Orders for three weeks
INSERT INTO DietOrder (patient, dietRegime, dateOrdered, dateDue) VALUES
(1, 1, '2023-11-23', '2023-11-23'),
(2, 2, '2023-11-23', '2023-11-23'),
(3, 3, '2023-11-23', '2023-11-23'),
(4, 4, '2023-11-23', '2023-11-23'),
(5, 5, '2023-11-23', '2023-11-23');

-- Diet Rounds with varied statuses
INSERT INTO DietRound (orderId, practitioner, status, notes) VALUES
(1, 1, 'given', 'Ate full portion'),
(1, 2, 'refused', 'Not hungry, offered alternative'),
(2, 3, 'given', 'Ate well, enjoyed meal'),
(2, 4, 'fasting', 'Fasting for blood work'),
(3, 1, 'given', 'Ate half portion'),
(3, 2, 'given', 'Special request for extra vegetables accommodated'),
(4, 3, 'given', 'Required assistance with feeding'),
(4, 4, 'refused', 'Not feeling well, will monitor'),
(5, 1, 'given', 'Completed full meal'),
(5, 2, 'no stock', 'Special dietary items not available, substitute provided');