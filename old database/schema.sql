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

-- drop tables if exist
DROP TABLE IF EXISTS Patients;
CREATE TABLE Patients (
    id          INTEGER AUTO_INCREMENT,
    firstName   VARCHAR(255) NOT NULL,
    lastName    VARCHAR(255) NOT NULL,
    sex         ENUM('male', 'female'),
    photo       VARCHAR(255), -- path to photo for frontend to use
    email       VARCHAR(255),
    phone       VARCHAR(10),
    notes       TEXT,
    emergencyContact INTEGER,
    room        INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (emergencyContact) REFERENCES EmergencyContacts(id)
);

DROP TABLE IF EXISTS Practitioners;
CREATE TABLE Practitioners (
    id          INTEGER AUTO_INCREMENT,
    firstName   VARCHAR(255) NOT NULL,
    lastName    VARCHAR(255) NOT NULL,
    userName    VARCHAR(255) NOT NULL,
    password    VARCHAR(255) NOT NULL, -- change this to hash password
    PRIMARY KEY (id)
);


DROP TABLE IF EXISTS Medications;
CREATE TABLE Medications (
    id          INTEGER AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    routeAdmin  VARCHAR(255) NOT NULL,
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
    frequency   ENUM('1', '2', '3'),
    dosage      DECIMAL(10,2),
    PRIMARY KEY (id),
    FOREIGN KEY (patient) REFERENCES Patients(id),
    FOREIGN KEY (medication) REFERENCES Medications(id)
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
    frequency   ENUM('1', '2', '3'),
    PRIMARY KEY (id),
    FOREIGN KEY (patient) REFERENCES Patients(id),
    FOREIGN KEY (dietRegime) REFERENCES DietRegimes(id)
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