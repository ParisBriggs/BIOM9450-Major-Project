USE biom9450;

DELIMITER //

--                                          Patient Record Page                                                --

-- get list of patients including photo, name and room
DROP PROCEDURE IF EXISTS GetBasicPatients //

CREATE PROCEDURE GetBasicPatients()
BEGIN
    SELECT 
        p.id AS patientID,
        CONCAT(p.firstName, ' ', p.lastName) AS fullName,
        p.photo AS photoUrl,
        p.room
    FROM 
        Patients p
    GROUP BY 
        p.id
    ORDER BY 
        p.room;
END //

DROP PROCEDURE IF EXISTS GetBasicPatientById //
CREATE PROCEDURE GetBasicPatientById(IN id INTEGER)
BEGIN
    SELECT 
        p.id AS patientID,
        CONCAT(p.firstName, ' ', p.lastName) AS fullName,
        p.photo AS photoUrl,
        p.room
    FROM 
        Patients p
    WHERE 
        p.id = id
    GROUP BY 
        p.id;
END //

-- gets room, photo and name of patient searched for
DROP PROCEDURE IF EXISTS GetBasicPatientByFullName //
CREATE PROCEDURE GetBasicPatientByFullName(IN searchName VARCHAR(255))
BEGIN
    SELECT 
        p.id AS patientID,
        CONCAT(p.firstName, ' ', p.lastName) AS fullName,
        p.photo AS photoUrl,
        p.room
    FROM 
        Patients p
    WHERE 
        LOWER(CONCAT(p.firstName, ' ', p.lastName)) LIKE LOWER(CONCAT('%', searchName, '%'))
    GROUP BY 
        p.id;
END //

-- gets room, photo and name of patient searched for
DROP PROCEDURE IF EXISTS GetBasicPatientByRoomNum //
CREATE PROCEDURE GetBasicPatientByRoomNum(IN room INTEGER)
BEGIN
    SELECT 
        p.id AS patientID,
        CONCAT(p.firstName, ' ', p.lastName) AS fullName,
        p.photo AS photoUrl,
        p.room
    FROM 
        Patients p
    WHERE 
        p.room = room
    GROUP BY 
        p.id;
END //

-- get basic patient and emergency contact info for a specific patient
DROP PROCEDURE IF EXISTS GetAllPatientInfoByFullName //

CREATE PROCEDURE GetAllPatientInfoByFullName(IN firstName VARCHAR(255), IN lastName VARCHAR(255))
BEGIN
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
        p.dob,
        p.bloodType,
        ec.firstName AS emergencyContactFirstName,
        ec.lastName AS emergencyContactLastName,
        ec.relationship,
        ec.email AS emergencyContactEmail,
        ec.phone AS emergencyContactPhone,
        gp.firstName AS gpFirstName,
        gp.lastName AS gpLastName,
        gp.practiceName AS gpPracticeName,
        gp.phone AS gpPhone,
        gp.email AS gpEmail,
        gp.address AS gpAddress,
        GROUP_CONCAT(fa.name) AS foodAllergies
    FROM 
        Patients p
        LEFT JOIN EmergencyContacts ec ON p.emergencyContact = ec.id
        LEFT JOIN GeneralGPs gp ON p.generalGP = gp.id
        LEFT JOIN PatientAllergies pa ON p.id = pa.patient_id
        LEFT JOIN FoodAllergies fa ON pa.allergy_id = fa.id
    WHERE 
        p.firstName LIKE firstName AND p.lastName LIKE lastName
    GROUP BY 
        p.id;
END //

-- get basic patient and emergency contact info for a specific room
DROP PROCEDURE IF EXISTS GetAllPatientInfoByRoom //

CREATE PROCEDURE GetAllPatientInfoByRoom(IN room INTEGER)
BEGIN
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
        p.dob,
        p.bloodType,
        ec.firstName AS emergencyContactFirstName,
        ec.lastName AS emergencyContactLastName,
        ec.relationship,
        ec.email AS emergencyContactEmail,
        ec.phone AS emergencyContactPhone,
        gp.firstName AS gpFirstName,
        gp.lastName AS gpLastName,
        gp.practiceName AS gpPracticeName,
        gp.phone AS gpPhone,
        gp.email AS gpEmail,
        gp.address AS gpAddress,
        GROUP_CONCAT(fa.name) AS foodAllergies
    FROM 
        Patients p
        LEFT JOIN EmergencyContacts ec ON p.emergencyContact = ec.id
        LEFT JOIN GeneralGPs gp ON p.generalGP = gp.id
        LEFT JOIN PatientAllergies pa ON p.id = pa.patient_id
        LEFT JOIN FoodAllergies fa ON pa.allergy_id = fa.id
    WHERE 
        p.room = room
    GROUP BY 
        p.id;
END //

-- get all of a patients medications given their id
DROP PROCEDURE IF EXISTS GetPatientMedications //

CREATE PROCEDURE GetPatientMedications(IN patientId INTEGER)
BEGIN
    SELECT DISTINCT
        m.name AS medicationName,
        mo.dosage AS dosage,
        m.routeAdmin AS administrationRoute,
        m.requirements AS requirements,
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
END //

-- get all of a patients diet regimes
DROP PROCEDURE IF EXISTS GetPatientDiets //

CREATE PROCEDURE GetPatientDiets(IN patientId INTEGER)
BEGIN
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
            -- Get the most recent order for each diet regime
            SELECT MAX(do2.dateOrdered)
            FROM DietOrder do2
            WHERE do2.patient = patientId
            AND do2.dietRegime = do.dietRegime
        )
    ORDER BY 
        d.name;
END //

--                                        Insert Patient Record Page                                           --

DROP PROCEDURE IF EXISTS InsertPatientWithContact //

CREATE PROCEDURE InsertPatientWithContact(
    -- Emergency Contact Details
    IN ec_firstName VARCHAR(255),
    IN ec_lastName VARCHAR(255),
    IN ec_relationship VARCHAR(255),
    IN ec_email VARCHAR(255),
    IN ec_phone VARCHAR(10),
    -- GP Details
    IN gp_firstName VARCHAR(255),
    IN gp_lastName VARCHAR(255),
    IN gp_practiceName VARCHAR(255),
    IN gp_phone VARCHAR(20),
    IN gp_email VARCHAR(255),
    IN gp_address TEXT,
    -- Patient Details
    IN p_firstName VARCHAR(255),
    IN p_lastName VARCHAR(255),
    IN p_sex ENUM('male', 'female'),
    IN p_photo VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_phone VARCHAR(10),
    IN p_notes TEXT,
    IN p_room INTEGER,
    IN p_dob DATE,
    IN p_bloodType ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'),
    -- Food Allergies (comma-separated list of allergy IDs)
    IN p_allergies VARCHAR(255)
)
BEGIN
    DECLARE new_contact_id INT;
    DECLARE new_gp_id INT;
    DECLARE new_patient_id INT;
    DECLARE allergy_id VARCHAR(10);
    DECLARE str_length INT;
    DECLARE start_pos INT;
    DECLARE comma_pos INT;
    
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
    
    -- Insert General GP
    INSERT INTO GeneralGPs (
        firstName,
        lastName,
        practiceName,
        phone,
        email,
        address
    ) VALUES (
        gp_firstName,
        gp_lastName,
        gp_practiceName,
        gp_phone,
        gp_email,
        gp_address
    );
    
    SET new_gp_id = LAST_INSERT_ID();
    
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
        room,
        dob,
        bloodType,
        generalGP
    ) VALUES (
        p_firstName,
        p_lastName,
        p_sex,
        p_photo,
        p_email,
        p_phone,
        p_notes,
        new_contact_id,
        p_room,
        p_dob,
        p_bloodType,
        new_gp_id
    );
    
    SET new_patient_id = LAST_INSERT_ID();
    
    -- Handle food allergies (parsing comma-separated list)
    SET str_length = LENGTH(p_allergies);
    SET start_pos = 1;
    
    WHILE start_pos <= str_length DO
        SET comma_pos = LOCATE(',', p_allergies, start_pos);
        IF comma_pos = 0 THEN
            SET allergy_id = SUBSTR(p_allergies, start_pos);
            SET start_pos = str_length + 1;
        ELSE
            SET allergy_id = SUBSTR(p_allergies, start_pos, comma_pos - start_pos);
            SET start_pos = comma_pos + 1;
        END IF;
        
        IF allergy_id IS NOT NULL AND LENGTH(TRIM(allergy_id)) > 0 THEN
            INSERT INTO PatientAllergies (patient_id, allergy_id)
            VALUES (new_patient_id, TRIM(allergy_id));
        END IF;
    END WHILE;
END //

--                                        Other util queries                                           --

-- remove patient with id
DROP PROCEDURE IF EXISTS DeletePatient //

CREATE PROCEDURE DeletePatient(IN patientID INTEGER)
BEGIN
    -- First get the emergency contact ID
    DECLARE contactID INTEGER;
    
    -- Delete any food allergy associations
    DELETE FROM PatientAllergies WHERE patient_id = patientID;
    
    -- Get emergency contact ID before deleting patient
    SELECT emergencyContact INTO contactID FROM Patients WHERE id = patientID;
    
    -- Delete the patient
    DELETE FROM Patients WHERE id = patientID;
    
    -- Delete the emergency contact if it exists
    IF contactID IS NOT NULL THEN
        DELETE FROM EmergencyContacts WHERE id = contactID;
    END IF;
END //

-- Get all food allergies
DROP PROCEDURE IF EXISTS GetAllFoodAllergies //

CREATE PROCEDURE GetAllFoodAllergies()
BEGIN
    SELECT id, name
    FROM FoodAllergies
    ORDER BY name;
END //

-- Get all general GPs
DROP PROCEDURE IF EXISTS GetAllGeneralGPs //

CREATE PROCEDURE GetAllGeneralGPs()
BEGIN
    SELECT id, 
           CONCAT(firstName, ' ', lastName) as fullName,
           practiceName,
           phone,
           email,
           address
    FROM GeneralGPs
    ORDER BY lastName, firstName;
END //

DELIMITER ;