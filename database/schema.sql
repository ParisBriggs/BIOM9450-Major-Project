-- schema.sql
-- Drop database if it exists and create new one
DROP DATABASE IF EXISTS biom9450;
CREATE DATABASE biom9450;
USE biom9450;

DROP TABLE IF EXISTS EmergencyContacts;
CREATE TABLE EmergencyContacts (
    id          INTEGER AUTO_INCREMENT,
    firstName   VARCHAR(255) NOT NULL,
    lastName    VARCHAR(255) NOT NULL,
    relationship VARCHAR(255),
    email       VARCHAR(255),
    phone       VARCHAR(10),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS GeneralGPs;
CREATE TABLE GeneralGPs (
    id              INTEGER AUTO_INCREMENT,
    firstName       VARCHAR(255) NOT NULL,
    lastName        VARCHAR(255) NOT NULL,
    practiceName    VARCHAR(255) NOT NULL,
    phone           VARCHAR(20) NOT NULL,
    email          VARCHAR(255),
    address        TEXT,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS FoodAllergies;
CREATE TABLE FoodAllergies (
    id          INTEGER AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Wards;
CREATE TABLE Wards (
    id          INTEGER AUTO_INCREMENT,
    wardName    ENUM('A', 'B', 'C') NOT NULL,
    numRooms    INTEGER CHECK (numRooms = 15),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Rooms;
CREATE TABLE Rooms (
    id      INTEGER AUTO_INCREMENT,
    ward    INTEGER,
    RoomNum INTEGER,
    available BOOLEAN,
    PRIMARY KEY (id),
    FOREIGN KEY (ward) REFERENCES wards(id)
);

DROP TABLE IF EXISTS Patients;
CREATE TABLE Patients (
    id          INTEGER AUTO_INCREMENT,
    firstName   VARCHAR(255) NOT NULL,
    lastName    VARCHAR(255) NOT NULL,
    sex         ENUM('male', 'female'),
    photo       VARCHAR(255),
    email       VARCHAR(255),
    phone       VARCHAR(10),
    notes       TEXT,
    emergencyContact INTEGER,
    room        INTEGER,
    dob         DATE,
    bloodType   ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'),
    generalGP   INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (emergencyContact) REFERENCES EmergencyContacts(id),
    FOREIGN KEY (room) REFERENCES Rooms(id),
    FOREIGN KEY (generalGP) REFERENCES GeneralGPs(id)
);

DROP TABLE IF EXISTS PatientAllergies;
CREATE TABLE PatientAllergies (
    patient_id      INTEGER,
    allergy_id      INTEGER,
    PRIMARY KEY (patient_id, allergy_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(id),
    FOREIGN KEY (allergy_id) REFERENCES FoodAllergies(id)
);

DROP TABLE IF EXISTS Practitioners;
CREATE TABLE Practitioners (
    id          INTEGER AUTO_INCREMENT,
    firstName   VARCHAR(255) NOT NULL,
    lastName    VARCHAR(255) NOT NULL,
    userName    VARCHAR(255) NOT NULL,
    position    ENUM('Nurse', 'Doctor'),
    ward        INTEGER,
    password    VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (ward) REFERENCES wards(id)
);

DROP TABLE IF EXISTS Medications;
CREATE TABLE Medications (
    id          INTEGER AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    routeAdmin  VARCHAR(255) NOT NULL,
    requirements ENUM('before food', 'after food', 'with food', 'no requirements') NOT NULL DEFAULT 'no requirements',
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS DietRegimes;
CREATE TABLE DietRegimes (
    id          INTEGER AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    food        TEXT NOT NULL,
    excercise   TEXT NOT NULL,
    beauty      TEXT NOT NULL,
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS MedicationOrder;
CREATE TABLE MedicationOrder (
    id          INTEGER AUTO_INCREMENT,
    patient     INTEGER,
    medication  INTEGER,
    dateOrdered DATE,
    dateCeased  DATE,
    orderedBy   INTEGER,
    frequency   ENUM('1', '2', '3'),
    dosage      DECIMAL(10,2),
    PRIMARY KEY (id),
    FOREIGN KEY (patient) REFERENCES Patients(id),
    FOREIGN KEY (medication) REFERENCES Medications(id),
    FOREIGN KEY (orderedBy) REFERENCES Practitioners(id)
);

DROP TABLE IF EXISTS MedicationRound;
CREATE TABLE MedicationRound (
    id              INTEGER AUTO_INCREMENT,
    orderId         INTEGER,
    practitioner    INTEGER,
    roundTime       ENUM('morning', 'afternoon', 'evening'),
    status          ENUM('given', 'refused', 'fasting', 'no stock', 'ceased'),
    notes           TEXT,
    PRIMARY KEY (id),
    FOREIGN KEY (orderId) REFERENCES MedicationOrder(id),
    FOREIGN KEY (practitioner) REFERENCES Practitioners(id)
);

DROP TABLE IF EXISTS DietOrder;
CREATE TABLE DietOrder (
    id          INTEGER AUTO_INCREMENT,
    patient     INTEGER,
    dietRegime  INTEGER,
    dateOrdered DATE,
    orderedBy   INTEGER,
    frequency   ENUM('1', '2', '3'),
    PRIMARY KEY (id),
    FOREIGN KEY (patient) REFERENCES Patients(id),
    FOREIGN KEY (dietRegime) REFERENCES DietRegimes(id),
    FOREIGN KEY (orderedBy) REFERENCES Practitioners(id)
);

DROP TABLE IF EXISTS DietRound;
CREATE TABLE DietRound (
    id              INTEGER AUTO_INCREMENT,
    orderId         INTEGER,
    practitioner    INTEGER,
    roundTime       ENUM('morning', 'afternoon', 'evening'),
    status          ENUM('given', 'refused', 'fasting', 'no stock', 'ceased'),
    notes           TEXT,
    PRIMARY KEY (id),
    FOREIGN KEY (orderId) REFERENCES DietOrder(id),
    FOREIGN KEY (practitioner) REFERENCES Practitioners(id)
);