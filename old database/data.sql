USE biom9450;

-- Emergency Contacts first (no foreign key dependencies)
INSERT INTO EmergencyContacts (firstName, lastName, relationship, email, phone) VALUES
('Mary', 'Smith', 'Wife', 'mary.smith@email.com', '0412345678'),
('David', 'Clarke', 'Husband', 'david.clarke@email.com', '0423456789'),
('Michael', 'Johnson', 'Son', 'michael.j@email.com', '0434567890'),
('Emma', 'Wilson', 'Daughter', 'emma.wilson@email.com', '0445678901'),
('Jennifer', 'Park', 'Sister', 'jen.park@email.com', '0456789012');

-- Patients with complete information
INSERT INTO Patients (firstName, lastName, sex, email, phone, notes, emergencyContact, room, photo) VALUES
('John', 'Smith', 'male', 'john.smith@email.com', '0400123456', 'Has dementia and high blood pressure. Needs regular monitoring.', 1, 101, 'images/profile_image_1.jpg'),
('Kelly', 'Clarke', 'female', 'kelly.clarke@email.com', '0400234567', 'Type 2 diabetes. Regular glucose monitoring required.', 2, 102, 'images/profile_image_2.jpg'),
('Sarah', 'Johnson', 'female', 'sarah.johnson@email.com', '0400345678', 'Celiac disease and acid reflux. Strict dietary requirements.', 3, 103, 'images/profile_image_3.jpg'),
('Toby', 'Wilson', 'male', 'toby.wilson@email.com', '0400456789', 'Parkinsons disease. Requires assistance with daily activities.', 4, 104, 'images/profile_image_6.jpg'),
('Alex', 'Park', 'male', 'alex.park@email.com', '0400567890', 'Osteoporosis. Weekly medication schedule.', 5, 105, 'images/profile_image_5.jpeg');

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
('Low Sodium Diet', 
 'Avoid: processed foods, canned foods, salty snacks, cured meats. 
  Include: fresh fruits and vegetables, lean meats, unsalted nuts, 
  low-sodium dairy products. Limit sodium intake to 2000mg per day.', 
 'Regular moderate exercise to help regulate blood pressure', 
 'Monitor for fluid retention'),

('Low Glycemic Index Diet', 
 'Avoid: sugary foods, refined carbs, processed snacks.
  Include: whole grains, legumes, non-starchy vegetables, 
  lean proteins, healthy fats. Choose foods with GI < 55.
  Monitor carbohydrate portions. Include protein with each meal.',
 'Regular post-meal walking to help manage blood sugar', 
 'Monitor for signs of hypo/hyperglycemia'),

('Gluten-Free Diet', 
 'Avoid: wheat, rye, barley, and any derivatives.
  Include: rice, corn, quinoa, gluten-free oats,
  fresh fruits and vegetables, meat, fish, eggs, 
  dairy products, legumes, nuts and seeds.
  Check all processed foods for gluten-containing ingredients.',
 'Regular exercise as tolerated', 
 'Monitor for cross-contamination reactions'),

('High Protein Diet', 
 'Include: lean meats, fish, eggs, dairy, legumes,
  nuts and seeds. Focus on complete proteins.
  Balance with appropriate carbohydrates and healthy fats.
  Protein intake adjusted based on body weight and activity.
  Avoid: excessive processed meats.',
 'Strength training and mobility exercises', 
 'Monitor protein intake and kidney function'),

('High Calcium Diet', 
 'Include: dairy products, fortified plant milks,
  leafy green vegetables, fish with bones,
  calcium-fortified foods. Combine with vitamin D rich foods.
  Avoid: excessive caffeine and salt which can affect calcium absorption.',
 'Weight-bearing exercises to support bone health', 
 'Monitor bone density and calcium levels');

-- Medication Orders for past week (23-29 Nov), current week (30 Nov-7 Dec), and future week (8-14 Dec)
INSERT INTO MedicationOrder (patient, medication, dateOrdered, frequency, dosage) VALUES
-- John Smith
(1, 2, '2023-11-23', '2', 5.0),  -- Lisinopril twice daily
(1, 1, '2023-11-23', '1', 5.0),  -- Donepezil once daily (evening)

-- Kelly Clarke
(2, 3, '2023-11-23', '3', 2.0),  -- Repaglinide three times daily (with meals)
(2, 4, '2023-11-23', '3', NULL), -- Insulin three times daily (variable dosage)
(2, 5, '2023-11-23', '1', 25.0), -- Sitagliptin once daily

-- Sarah Johnson
(3, 6, '2023-11-23', '2', 640.0), -- Calcium Carbonate twice daily

-- Toby Wilson
(4, 7, '2023-11-23', '3', 0.125), -- Levodopa-Carbidopa three times daily
(4, 8, '2023-11-23', '3', 0.125), -- Pramipexole three times daily
(4, 9, '2023-11-23', '2', 5.0),   -- Eldepryl twice daily

-- Alex Park
(5, 10, '2023-11-23', '1', 35.0), -- Weekly Alendronate once daily
(5, 11, '2023-11-23', '1', 5.0),  -- Risedronate once daily
(5, 12, '2023-11-23', '1', 600.0); -- Vitamin D once daily

-- Updated Medication Rounds with roundTime
INSERT INTO MedicationRound (orderId, practitioner, roundTime, status, notes) VALUES
-- John Smith's rounds
(1, 1, 'morning', 'given', 'Taken with water'),
(1, 1, 'evening', 'given', 'Taken with dinner'),
(2, 1, 'evening', 'refused', 'Patient initially refused, taken after discussion'),

-- Kelly Clarke's rounds
(3, 2, 'morning', 'given', 'Taken with breakfast'),
(3, 2, 'afternoon', 'given', 'Taken with lunch'),
(3, 2, 'evening', 'given', 'Taken with dinner'),
(4, 2, 'morning', 'no stock', 'Pharmacy notified, will deliver tomorrow'),
(5, 3, 'evening', 'given', 'Taken as scheduled'),

-- Sarah Johnson's rounds
(6, 3, 'morning', 'fasting', 'NPO for morning procedure'),
(6, 3, 'evening', 'given', 'Taken after dinner'),

-- Toby Wilson's rounds
(7, 4, 'morning', 'given', 'Given with breakfast'),
(7, 4, 'afternoon', 'given', 'Given with lunch'),
(7, 4, 'evening', 'ceased', 'Discontinued per doctor orders'),

-- Alex Park's rounds
(10, 1, 'morning', 'given', 'Taken with breakfast');

-- Diet Orders - matched to patient conditions
INSERT INTO DietOrder (patient, dietRegime, dateOrdered, frequency) VALUES
-- John Smith (has dementia + high blood pressure)
(1, 1, '2023-11-23', '3'),  -- Low Sodium Diet, 3 meals per day

-- Kelly Clarke (Type 2 diabetes)
(2, 2, '2023-11-23', '3'),  -- Low Glycemic Index Diet, 3 meals per day

-- Sarah Johnson (Celiac disease and acid reflux)
(3, 3, '2023-11-23', '3'),  -- Gluten-Free Diet, 3 meals per day

-- Toby Wilson (Parkinson's Disease)
(4, 4, '2023-11-23', '3'),  -- High Protein Diet, 3 meals per day

-- Alex Park (Osteoporosis)
(5, 5, '2023-11-23', '3');  -- High Calcium Diet, 3 meals per day

-- Diet Rounds with specific notes related to diet types
INSERT INTO DietRound (orderId, practitioner, roundTime, status, notes) VALUES
-- John Smith - Low Sodium Diet rounds
(1, 1, 'morning', 'given', 'Fresh fruit and unsalted oatmeal served. Patient ate well.'),
(1, 2, 'afternoon', 'given', 'Fresh salad with grilled chicken, no salt added. Reminded about no salt at table.'),
(1, 1, 'evening', 'refused', 'Complained about lack of salt. Offered herbs for flavoring instead.'),

-- Kelly Clarke - Low GI Diet rounds
(2, 3, 'morning', 'given', 'Whole grain toast with eggs and avocado. Blood sugar within range.'),
(2, 2, 'afternoon', 'given', 'Quinoa salad with chickpeas. Portion size appropriate.'),
(2, 4, 'evening', 'fasting', 'Fasting for morning blood work. Water provided.'),

-- Sarah Johnson - Gluten-Free Diet rounds
(3, 1, 'morning', 'given', 'Gluten-free cereal with fresh fruit. Checked for cross-contamination.'),
(3, 2, 'afternoon', 'given', 'Rice with grilled fish and vegetables. All ingredients verified gluten-free.'),
(3, 3, 'evening', 'given', 'Gluten-free pasta with lean protein. Patient enjoyed meal.'),

-- Toby Wilson - High Protein Diet rounds
(4, 4, 'morning', 'given', 'High protein breakfast with eggs and Greek yogurt. Needed assistance with feeding.'),
(4, 1, 'afternoon', 'given', 'Lean chicken with quinoa. Protein portion adjusted per Levodopa schedule.'),
(4, 2, 'evening', 'refused', 'Fatigue affecting appetite. Will monitor protein intake tomorrow.'),

-- Alex Park - High Calcium Diet rounds
(5, 3, 'morning', 'given', 'Calcium-fortified oatmeal with milk. Vitamin D supplement given.'),
(5, 4, 'afternoon', 'given', 'Yogurt parfait and leafy green salad with almonds.'),
(5, 1, 'evening', 'no stock', 'Calcium-fortified bread unavailable. Substituted with yogurt-based dish.');