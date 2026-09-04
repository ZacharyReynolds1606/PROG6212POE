-- ==============================
-- RaceDay Database Schema (Part 1)
-- ==============================

-- Organiser Table
CREATE TABLE Organiser (
    OrganiserID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(20),
    OrganisationName NVARCHAR(100)
);

-- Participant Table
CREATE TABLE Participant (
    ParticipantID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(20),
    DateOfBirth DATE NOT NULL
);

-- Event Table
CREATE TABLE Event (
    EventID INT PRIMARY KEY IDENTITY(1,1),
    OrganiserID INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    Date DATE NOT NULL,
    Location NVARCHAR(100) NOT NULL,
    Distance DECIMAL(5,2) NOT NULL,
    EventType NVARCHAR(20) CHECK (EventType IN ('Run','Walk','Cycle')),
    FOREIGN KEY (OrganiserID) REFERENCES Organiser(OrganiserID)
);

-- Category Table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    EventID INT NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(100),
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- Enrolment Table
CREATE TABLE Enrolment (
    EnrolmentID INT PRIMARY KEY IDENTITY(1,1),
    ParticipantID INT NOT NULL,
    EventID INT NOT NULL,
    CategoryID INT NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Confirmed','Pending')),
    FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Result Table
CREATE TABLE Result (
    ResultID INT PRIMARY KEY IDENTITY(1,1),
    ParticipantID INT NOT NULL,
    EventID INT NOT NULL,
    CategoryID INT NOT NULL,
    FinishTime TIME,
    Position INT,
    FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- ==============================
-- Sample Data Inserts
-- ==============================

-- Organisers
INSERT INTO Organiser (Name, Email, Phone, OrganisationName)
VALUES ('Damien Lockhart', 'damien@raceday.com', '0821234567', 'RaceDay SA'),
       ('Mary Stevens', 'mary@events.co.za', '0839876543', 'EventMasters');

-- Participants
INSERT INTO Participant (Name, Email, Phone, DateOfBirth)
VALUES ('Alice Brown', 'alice@gmail.com', '0721112222', '1995-04-12'),
       ('David Green', 'david@gmail.com', '0733334444', '1988-09-30');

-- Events
INSERT INTO Event (OrganiserID, Name, Description, Date, Location, Distance, EventType)
VALUES (1, 'Cape Town Cycle Tour', 'Annual cycling event', '2026-03-10', 'Cape Town', 109.00, 'Cycle'),
       (1, 'Comrades Marathon', 'Ultra marathon race', '2026-06-04', 'Durban', 90.00, 'Run'),
       (2, 'Soweto Walkathon', 'Community walk event', '2026-09-15', 'Soweto', 10.00, 'Walk');

-- Categories
INSERT INTO Category (EventID, Name, Description)
VALUES (1, 'Elite Cyclists', 'Professional category'),
       (1, 'Amateur Cyclists', 'Open category'),
       (2, 'Under 35', 'Young runners'),
       (2, 'Veterans', 'Experienced runners'),
       (3, 'Family Walk', 'Casual walkers');

-- Enrolments
INSERT INTO Enrolment (ParticipantID, EventID, CategoryID, Status)
VALUES (1, 1, 2, 'Confirmed'),
       (2, 2, 3, 'Pending');

-- Results
INSERT INTO Result (ParticipantID, EventID, CategoryID, FinishTime, Position)
VALUES (1, 1, 2, '03:45:00', 120),
       (2, 2, 3, '07:30:00', 250);
