create type StatusType as enum ('given', 'refused', 'fasting', 'no stock', 'ceased');

create table Patients (
    id          integer,
    firstName   text not null,
    lastName    text not null,
    photo       blob, 
    room        integer,
    primary key (id)
);

create table Practitioners (
    id          integer,
    firstName   text not null,
    lastName    text not null,
    userName    text not null,
    password    text not null, -- change this to hash password
    primary key (id)
);

create table Medications (
    id          integer,
    name        text not null,
    routeAdmin  text not null,
    primary key (id)
);

create table DietRegimes (
    id          integer,
    name        text not null,
    food        text not null,
    excercise   text not null,
    beauty      text not null,
    primary key (id)
);

create table MedicationOrder (
    id          integer,
    dateOrdered date,
    dateDue     date,
    primary key (id)
);

create table MedicationRound (
    id          integer,
    practitioner text references Practitioners(id),
    status      StatusType, -- given, refused, fasting, no stock, ceased
    primary key (id)
);

create table DietOrder (
    id          integer,
    dateOrdered date,
    dateDue     date,
    primary key (id)
);

create table DietRound (
    id          integer,
    practitioner text references Practitioners(id),
    status      StatusType, -- given, refused, fasting, no stock, ceased
    primary key (id)
);