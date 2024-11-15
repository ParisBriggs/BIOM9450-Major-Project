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
        p.id = id;
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
        LOWER(CONCAT(p.firstName, ' ', p.lastName)) LIKE LOWER(CONCAT('%', searchName, '%'));
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
        p.room = room;
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
END //

-- get all of a patients medications given their id
DROP PROCEDURE IF EXISTS GetPatientMedications //

CREATE PROCEDURE GetPatientMedications(IN patientId INTEGER)
BEGIN
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
            -- Get the most recent order for each medication
            SELECT MAX(do2.dateOrdered)
            FROM DietOrder do2
            WHERE do2.patient = patientId
            AND do2.dietRegime = do.dietRegime
        )
    ORDER BY 
        d.name;
END //

--                                         Medication Rounds Page                                              --

--                                        Diet Regime Rounds Page                                              --

--                                        Insert Patient Record Page                                           --

DROP PROCEDURE IF EXISTS InsertPatientWithContact //

CREATE PROCEDURE InsertPatientWithContact(
    -- Emergency Contact Details
    IN ec_firstName VARCHAR(255),
    IN ec_lastName VARCHAR(255),
    IN ec_relationship VARCHAR(255),
    IN ec_email VARCHAR(255),
    IN ec_phone VARCHAR(10),
    -- Patient Details
    IN p_firstName VARCHAR(255),
    IN p_lastName VARCHAR(255),
    IN p_sex ENUM('male', 'female'),
    IN p_photo VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_phone VARCHAR(10),
    IN p_notes TEXT,
    IN p_room INTEGER,
    IN p_dob DATE
)
BEGIN
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
        room,
        dob
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
        p_dob
    );
END //

--                                        Other util queries                                           --


-- remove patient with id
DROP PROCEDURE IF EXISTS DeletePatient //

CREATE PROCEDURE DeletePatient(IN patientID INTEGER)
BEGIN
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
END //

DELIMITER ;