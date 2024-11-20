-- data.sql
USE biom9450;

-- Wards first
INSERT INTO Wards (wardName, numRooms) VALUES
('A', 15),
('B', 15),
('C', 15);

-- Then Rooms
INSERT INTO Rooms (ward, RoomNum, available) VALUES
-- Ward A
(1, 101, true), (1, 102, true), (1, 103, true), (1, 104, true), (1, 105, true),
(1, 106, true), (1, 107, true), (1, 108, true), (1, 109, true), (1, 110, true),
(1, 111, true), (1, 112, true), (1, 113, true), (1, 114, true), (1, 115, true),
-- Ward B
(2, 201, true), (2, 202, true), (2, 203, true), (2, 204, true), (2, 205, true),
(2, 206, true), (2, 207, true), (2, 208, true), (2, 209, true), (2, 210, true),
(2, 211, true), (2, 212, true), (2, 213, true), (2, 214, true), (2, 215, true),
-- Ward C
(3, 301, true), (3, 302, true), (3, 303, true), (3, 304, true), (3, 305, true),
(3, 306, true), (3, 307, true), (3, 308, true), (3, 309, true), (3, 310, true),
(3, 311, true), (3, 312, true), (3, 313, true), (3, 314, true), (3, 315, true);

-- Insert General GPs
INSERT INTO GeneralGPs (firstName, lastName, practiceName, phone, email, address) VALUES
('Robert', 'Williams', 'Citywide Medical Practice', '0298765432', 'r.williams@citymed.com', '123 Medical Lane, Sydney NSW 2000'),
('Sarah', 'Chen', 'Eastside Family Practice', '0291234567', 's.chen@eastmed.com', '45 Health Street, Bondi NSW 2026'),
('James', 'Thompson', 'Northern Medical Center', '0294567890', 'j.thompson@northmed.com', '78 Care Road, Chatswood NSW 2067'),
('Maria', 'Rodriguez', 'Westside Healthcare', '0297654321', 'm.rodriguez@westmed.com', '90 Wellness Ave, Parramatta NSW 2150'),
('David', 'Kumar', 'Southern Family Clinic', '0293456789', 'd.kumar@southmed.com', '34 Doctor Street, Hurstville NSW 2220');

-- Insert Food Allergies
INSERT INTO FoodAllergies (name) VALUES
('Peanuts'),
('Shellfish'),
('Dairy'),
('Eggs'),
('Gluten'),
('Soy'),
('Tree Nuts'),
('Fish');

-- Emergency Contacts
INSERT INTO EmergencyContacts (firstName, lastName, relationship, email, phone) VALUES
('Mary', 'Smith', 'Wife', 'mary.smith@email.com', '0412345678'),
('David', 'Clarke', 'Husband', 'david.clarke@email.com', '0423456789'),
('Michael', 'Johnson', 'Son', 'michael.j@email.com', '0434567890'),
('Emma', 'Wilson', 'Daughter', 'emma.wilson@email.com', '0445678901'),
('Jennifer', 'Park', 'Sister', 'jen.park@email.com', '0456789012');

-- Patients with complete information
INSERT INTO Patients (firstName, lastName, sex, email, phone, notes, emergencyContact, room, photo, dob, bloodType, generalGP) VALUES
('John', 'Smith', 'male', 'john.smith@email.com', '0400123456', 'Has dementia and high blood pressure. Needs regular monitoring.', 1, 1, 'images/profile_image_1.jpg', '1950-05-15', 'O+', 1),
('Kelly', 'Clarke', 'female', 'kelly.clarke@email.com', '0400234567', 'Type 2 diabetes. Regular glucose monitoring required.', 2, 2, 'images/profile_image_2.jpg', '1965-08-22', 'A+', 2),
('Sarah', 'Johnson', 'female', 'sarah.johnson@email.com', '0400345678', 'Celiac disease and acid reflux. Strict dietary requirements.', 3, 3, 'images/profile_image_3.jpg', '1972-03-10', 'B-', 3),
('Toby', 'Wilson', 'male', 'toby.wilson@email.com', '0400456789', 'Parkinsons disease. Requires assistance with daily activities.', 4, 4, 'images/profile_image_6.jpg', '1945-11-30', 'AB+', 4),
('Alex', 'Park', 'male', 'alex.park@email.com', '0400567890', 'Osteoporosis. Weekly medication schedule.', 5, 5, 'images/profile_image_5.jpeg', '1958-07-25', 'A-', 5);

-- Link Patients with their Food Allergies
INSERT INTO PatientAllergies (patient_id, allergy_id) VALUES
(1, 1),  -- John Smith is allergic to peanuts
(2, 3),  -- Kelly Clarke is allergic to dairy
(3, 5),  -- Sarah Johnson is allergic to gluten
(4, 2),  -- Toby Wilson is allergic to shellfish
(5, 6);  -- Alex Park is allergic to soy

-- Practitioners
INSERT INTO Practitioners (firstName, lastName, userName, position, ward, password) VALUES
('Emma', 'Brown', 'emma.brown', 'Nurse', 1, 'password123'),
('Michael', 'Lee', 'michael.lee', 'Doctor', 1, 'password456'),
('Sarah', 'Wilson', 'sarah.wilson', 'Nurse', 2, 'password789'),
('James', 'Taylor', 'james.taylor', 'Doctor', 2, 'password101'),
('Lisa', 'Anderson', 'lisa.anderson', 'Nurse', 3, 'password102'),
('David', 'Martinez', 'david.martinez', 'Doctor', 3, 'password103');

-- Medications
INSERT INTO Medications (name, routeAdmin, requirements) VALUES
('Donepezil', 'oral', 'after food'),
('Lisinopril', 'oral', 'before food'),
('Repaglinide', 'oral', 'with food'),
('Insulin', 'injection', 'with food'),
('Sitagliptin', 'oral', 'before food'),
('Calcium Carbonate', 'oral', 'with food'),
('Levodopa-Carbidopa', 'infusion', 'before food'),
('Pramipexole', 'oral', 'with food'),
('Eldepryl', 'oral', 'after food'),
('Alendronate', 'oral', 'before food'),
('Risedronate', 'oral', 'before food'),
('Vitamin D', 'oral', 'with food'),
('Calcium', 'oral', 'with food');


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

-- Medication Orders
INSERT INTO MedicationOrder (patient, medication, dateOrdered, frequency, dosage, orderedBy) VALUES
-- John Smith
(1, 2, '2023-11-23', '2', 5.0, 2),  -- Lisinopril twice daily
(1, 1, '2023-11-23', '1', 5.0, 2),  -- Donepezil once daily

-- Kelly Clarke
(2, 3, '2023-11-23', '3', 2.0, 4),  -- Repaglinide three times daily
(2, 4, '2023-11-23', '3', NULL, 4), -- Insulin three times daily
(2, 5, '2023-11-23', '1', 25.0, 4), -- Sitagliptin once daily

-- Sarah Johnson
(3, 6, '2023-11-23', '2', 640.0, 6), -- Calcium Carbonate twice daily

-- Toby Wilson
(4, 7, '2023-11-23', '3', 0.125, 2), -- Levodopa-Carbidopa three times daily
(4, 8, '2023-11-23', '3', 0.125, 2), -- Pramipexole three times daily
(4, 9, '2023-11-23', '2', 5.0, 2),   -- Eldepryl twice daily

-- Alex Park
(5, 10, '2023-11-23', '1', 35.0, 4), -- Weekly Alendronate once daily
(5, 11, '2023-11-23', '1', 5.0, 4),  -- Risedronate once daily
(5, 12, '2023-11-23', '1', 600.0, 4); -- Vitamin D once daily

-- Medication Rounds
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

-- Diet Orders
INSERT INTO DietOrder (patient, dietRegime, dateOrdered, frequency, orderedBy) VALUES
-- John Smith (has dementia + high blood pressure)
(1, 1, '2023-11-23', '3', 2),  -- Low Sodium Diet, 3 meals per day

-- Kelly Clarke (Type 2 diabetes)
(2, 2, '2023-11-23', '3', 4),  -- Low Glycemic Index Diet, 3 meals per day

-- Sarah Johnson (Celiac disease and acid reflux)
(3, 3, '2023-11-23', '3', 6),  -- Gluten-Free Diet, 3 meals per day

-- Toby Wilson (Parkinson's Disease)
(4, 4, '2023-11-23', '3', 2),  -- High Protein Diet, 3 meals per day

-- Alex Park (Osteoporosis)
(5, 5, '2023-11-23', '3', 4);  -- High Calcium Diet, 3 meals per day

-- Diet Rounds
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