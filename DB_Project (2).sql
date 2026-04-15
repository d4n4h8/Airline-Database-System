CREATE DATABASE airline_system;
USE airline_system;

-----------------------------------------
-- TABLE: Airline
-----------------------------------------
CREATE TABLE Airline (
    Airline_ID      INT AUTO_INCREMENT PRIMARY KEY,
    Name            VARCHAR(100) NOT NULL,
    Country         VARCHAR(100) NOT NULL
);

-----------------------------------------
-- TABLE: Passenger
-----------------------------------------
CREATE TABLE Passenger (
    Passenger_ID    INT AUTO_INCREMENT PRIMARY KEY,
    PassportNo      VARCHAR(20) NOT NULL UNIQUE,
    First_name      VARCHAR(50) NOT NULL,
    Last_name       VARCHAR(50) NOT NULL,
    Gender          VARCHAR(10),
    Nationality     VARCHAR(50),
    DOB             DATE,
    Phone_Number    VARCHAR(20),

    CONSTRAINT chk_gender CHECK (Gender IN ('Male','Female'))
);

-----------------------------------------
-- TABLE: Airplane
-----------------------------------------
CREATE TABLE Airplane (
    Airplane_ID     INT AUTO_INCREMENT PRIMARY KEY,
    Model           VARCHAR(50) NOT NULL,
    Number          VARCHAR(20) NOT NULL UNIQUE,
    Capacity        INT NOT NULL,
    Airline_ID      INT NOT NULL,

    CONSTRAINT chk_capacity CHECK (Capacity > 0),

    FOREIGN KEY (Airline_ID)
        REFERENCES Airline (Airline_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-----------------------------------------
-- TABLE: Flight
-----------------------------------------
CREATE TABLE Flight (
    Flight_ID       INT AUTO_INCREMENT PRIMARY KEY,
    Origin          VARCHAR(100) NOT NULL,
    Destination     VARCHAR(100) NOT NULL,
    Departure_Time  DATETIME NOT NULL,
    Arrival_Time    DATETIME NOT NULL,
    Airline_ID      INT NOT NULL,
    Airplane_ID     INT NOT NULL,

    FOREIGN KEY (Airline_ID)
        REFERENCES Airline (Airline_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (Airplane_ID)
        REFERENCES Airplane (Airplane_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-----------------------------------------
-- TABLE: Flight_Status MV
-----------------------------------------
CREATE TABLE Flight_Status (
    Flight_ID   INT NOT NULL,
    Status      VARCHAR(30) NOT NULL,
	PRIMARY KEY (Flight_ID, Status),
    
    CONSTRAINT chk_status CHECK (Status IN 
        ('Scheduled','Delayed','Cancelled','Departed','Arrived', 'Boarding')
    ),

    FOREIGN KEY (Flight_ID)
        REFERENCES Flight (Flight_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-----------------------------------------
-- TABLE: Booking
-----------------------------------------
CREATE TABLE Booking (
    Booking_ID      INT AUTO_INCREMENT PRIMARY KEY,
    BookingDate     DATETIME NOT NULL,
    TicketClass     VARCHAR(20) NOT NULL,
    Flight_ID       INT NOT NULL,
    Passenger_ID    INT NOT NULL,

    CONSTRAINT chk_class CHECK (TicketClass IN ('Economy','Business','First')),

    FOREIGN KEY (Flight_ID)
        REFERENCES Flight (Flight_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    FOREIGN KEY (Passenger_ID)
        REFERENCES Passenger (Passenger_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-----------------------------------------
-- Describe tables
-----------------------------------------
describe airline;
describe airplane;
describe booking;
describe flight;
describe flight_status;
describe passenger;

-----------------------------------------
-- Add data: Airline 
-----------------------------------------
INSERT INTO Airline (Name, Country) VALUES
('Saudi Airlines','Saudi Arabia'),
('Flynas','Saudi Arabia'),
('Qatar Airways','Qatar'),
('Emirates','UAE'),
('Etihad Airways','UAE'),
('Turkish Airlines','Turkey'),
('Lufthansa','Germany'),
('British Airways','UK'),
('EgyptAir','Egypt'),
('Oman Air','Oman');

-----------------------------------------
-- Add data: Passenger 
-----------------------------------------
INSERT INTO Passenger (PassportNo, First_name, Last_name, Gender, Nationality, DOB, Phone_Number) VALUES
('P1001','Ali','Saleh','Male','Saudi Arabia','1990-05-12','0551234567'),
('P1002','Sara','Ahmed','Female','Egypt','1995-02-20','0102233445'),
('P1003','Fahad','Harbi','Male','Saudi Arabia','1988-11-03','0508887766'),
('P1004','Maryam','Saad','Female','UAE','1992-01-15','0521113344'),
('P1005','John','Smith','Male','UK','1985-07-09','0044123456'),
('P1006','Lina','Hassan','Female','Jordan','1998-03-22','0795566778'),
('P1007','Omar','Farouq','Male','Egypt','1999-08-18','0124455667'),
('P1008','Nora','Ali','Female','Saudi Arabia','2000-12-01','0556677889'),
('P1009','Huda','Salem','Female','Qatar','1993-09-14','009743334455'),
('P1010','James','Brown','Male','USA','1990-10-05','0012023344');

-----------------------------------------
-- Add data: Airplane
-----------------------------------------
INSERT INTO Airplane (Model, Number, Capacity, Airline_ID) VALUES
('A320','SA100',180,1),
('A330','SA200',250,1),
('B777','FN300',300,2),
('A350','QA400',320,3),
('B787','EM500',250,4),
('B737','ET600',160,5),
('A380','EM700',500,4),
('B747','TK800',410,6),
('A321','LH900',190,7),
('B767','BA1000',200,8);

-----------------------------------------
-- Add data: Flight 
-----------------------------------------
INSERT INTO Flight (Origin, Destination, Departure_Time, Arrival_Time, Airline_ID, Airplane_ID) VALUES
('Riyadh','Jeddah','2025-01-01 08:00','2025-01-01 10:00',1,1),
('Jeddah','Dubai','2025-01-02 12:00','2025-01-02 15:00',1,2),
('Doha','London','2025-01-03 05:00','2025-01-03 12:30',3,4),
('Dubai','Istanbul','2025-01-04 09:00','2025-01-04 13:00',4,5),
('Istanbul','Frankfurt','2025-01-05 14:00','2025-01-05 17:00',6,8),
('Riyadh','Cairo','2025-01-06 07:00','2025-01-06 09:30',2,3),
('Jeddah','Doha','2025-01-07 11:00','2025-01-07 13:00',1,1),
('London','Dubai','2025-01-08 21:00','2025-01-09 05:00',8,10),
('Cairo','Jeddah','2025-01-09 06:00','2025-01-09 08:00',9,9),
('Jeddah','Muscat','2025-01-10 16:00','2025-01-10 18:00',10,10);

-----------------------------------------
-- Add data: Flight_Status
-----------------------------------------
INSERT INTO Flight_Status VALUES
(1,'Scheduled'), 
(2,'Scheduled'),
(2,'Delayed'),
(3,'Scheduled'), 
(4,'Cancelled'),
(5,'Arrived'),
(6,'Scheduled'),
(6,'Departed'),
(7,'Scheduled'),
(8,'Scheduled'),
(9,'Arrived'),
(10,'Scheduled');

-----------------------------------------
-- Add data: Booking
-----------------------------------------
INSERT INTO Booking (BookingDate, TicketClass, Flight_ID, Passenger_ID) VALUES
('2025-01-01 07:00','Economy',1,1),
('2025-01-01 07:30','Business',1,2),
('2025-01-02 11:00','Economy',2,3),
('2025-01-03 03:00','First',3,4),
('2025-01-04 08:00','Economy',4,5),
('2025-01-05 10:00','Business',5,6),
('2025-01-06 05:30','Economy',6,7),
('2025-01-07 09:40','Business',7,8),
('2025-01-08 20:00','Economy',8,9),
('2025-01-09 05:15','First',9,10);

---------------------------------------
-- Duha's QUERIES
---------------------------------------
-- Show all passengers from Saudi Arabia
SELECT First_name, Last_name, Nationality
FROM Passenger
WHERE Nationality = 'Saudi Arabia';

-- Show all flights going to Jeddah
SELECT Flight_ID, Origin, Destination, Departure_Time
FROM Flight
WHERE Destination = 'Jeddah';

-- Count how many flights each airline operates
SELECT Airline.Name AS Airline_Name, COUNT(Flight.Flight_ID) AS Total_Flights
FROM Airline
JOIN Flight ON Airline.Airline_ID = Flight.Airline_ID
GROUP BY Airline.Name;

-- Average airplane capacity per airline
SELECT Airline.Name AS Airline_Name, AVG(Airplane.Capacity) AS Avg_Capacity
FROM Airline
JOIN Airplane ON Airline.Airline_ID = Airplane.Airline_ID
GROUP BY Airline.Name;

-- Show bookings with passenger names
SELECT Booking.Booking_ID, Passenger.First_name, Passenger.Last_name, Booking.TicketClass
FROM Booking
INNER JOIN Passenger ON Booking.Passenger_ID = Passenger.Passenger_ID;

-- Show flights and the airplane model used
SELECT Flight.Flight_ID, Flight.Origin, Flight.Destination, Flight_Status.Status
FROM Flight
LEFT JOIN Flight_Status 
    ON Flight.Flight_ID = Flight_Status.Flight_ID;

-- Passengers who booked a First-Class ticket
SELECT First_name, Last_name
FROM Passenger
WHERE Passenger_ID IN (
    SELECT Passenger_ID
    FROM Booking
    WHERE TicketClass = 'First'
);

-- Flights operated by airlines located in the UAE
SELECT Flight_ID, Origin, Destination
FROM Flight
WHERE Airline_ID IN (
    SELECT Airline_ID
    FROM Airline
    WHERE Country = 'UAE'
);

-- Create a view showing all flights and their status
CREATE VIEW Flight_Report AS
SELECT Flight.Flight_ID, Flight.Origin, Flight.Destination,
       Flight.Departure_Time, Flight.Arrival_Time,
       Flight_Status.Status
FROM Flight
JOIN Flight_Status ON Flight.Flight_ID = Flight_Status.Flight_ID;
SELECT * FROM Flight_Report;

---------------------------------------
-- Danah's QUERIES
---------------------------------------

-- Show the First Name, Last Name, and Date of Birth of all male passengers
SELECT First_name, Last_name, DOB
FROM Passenger
WHERE Gender = 'Male';

-- Show the Booking ID, Booking Date, and Ticket Class for all bookings made in 'Business' class
SELECT Booking_ID, BookingDate, TicketClass
FROM Booking
WHERE TicketClass = 'Business';

-- Count the total number of airplanes in the database
SELECT COUNT(Airplane_ID) AS Total_Airplanes_Count
FROM Airplane;

-- Count the number of bookings made for each flight
SELECT Flight_ID, COUNT(Booking_ID) AS Total_Bookings_Per_Flight
FROM Booking
GROUP BY Flight_ID;

-- List the Flight ID, Departure Time, and its recorded Status
SELECT F.Flight_ID, F.Departure_Time, FS.Status
FROM Flight F
INNER JOIN Flight_Status FS
    ON F.Flight_ID = FS.Flight_ID;

-- Show all Bookings and the destination of the booked flight 
SELECT B.Booking_ID, B.BookingDate, F.Destination AS Flight_Destination
FROM Booking B
LEFT JOIN Flight F 
    ON B.Flight_ID = F.Flight_ID;

-- Show all flights that currently have a 'Scheduled' status
SELECT Flight_ID, Origin, Destination
FROM Flight
WHERE Flight_ID IN (
    SELECT Flight_ID
    FROM Flight_Status
    WHERE Status = 'Scheduled'
);

-- Show all flights that use an airplane model with a capacity greater than 300
SELECT Flight_ID, Origin, Destination
FROM Flight
WHERE Airplane_ID IN (
    SELECT Airplane_ID
    FROM Airplane
    WHERE Capacity > 300
);

-- Create a View to display airplane numbers, models, and capacities greater than 200
CREATE VIEW Airplane_Capacity_View AS
SELECT Number AS Airplane_Number, Model, Capacity
FROM Airplane
WHERE Capacity > 200;
SELECT * FROM Airplane_Capacity_View;

---------------------------------------
-- Wasan’s QUERIES
---------------------------------------

-- Retrieve all aircraft details for specific Airbus models (A320 and A380)
SELECT * FROM Airplane 
WHERE Model IN ('A320', 'A380');
-- List the names and birth dates of passengers born before the year 1990
SELECT First_name, Last_name, DOB 
FROM Passenger 
WHERE DOB < '1990-01-01';

-- Calculate the total seating capacity available for each airline provider
SELECT Airline_ID, SUM(Capacity) AS Total_Seats
FROM Airplane
GROUP BY Airline_ID;

-- Group passengers by their nationality to see the distribution of travelers
SELECT Nationality, COUNT(Passenger_ID) AS Passenger_Count
FROM Passenger
GROUP BY Nationality;

-- Link bookings to their respective airlines to identify which company is operating each ticket
SELECT B.Booking_ID, A.Name AS Airline_Name
FROM Booking B
JOIN Flight F ON B.Flight_ID = F.Flight_ID
JOIN Airline A ON F.Airline_ID = A.Airline_ID;

 -- Retrieve passenger names alongside their final flight destinations
SELECT P.First_name, P.Last_name, F.Destination
FROM Passenger P
JOIN Booking B ON P.Passenger_ID = B.Passenger_ID
JOIN Flight F ON B.Flight_ID = F.Flight_ID;

-- Filter flights to show only those operated by 'Saudi Airlines' by fetching the ID dynamically
SELECT * FROM Flight
WHERE Airline_ID = (SELECT Airline_ID FROM Airline WHERE Name = 'Saudi Airlines');

-- Identify the specific flight record that has the earliest departure timestamp in the system
SELECT * FROM Flight
WHERE Departure_Time = (SELECT MIN(Departure_Time) FROM Flight);

-- Locate passengers who have booked any flight originating from 'Riyadh' using nested IDs
SELECT First_name, Last_name FROM Passenger
WHERE Passenger_ID IN (
    SELECT Passenger_ID FROM Booking WHERE Flight_ID IN (
        SELECT Flight_ID FROM Flight WHERE Origin = 'Riyadh'
    )
);
-- Show aircraft that have a higher capacity than the calculated average of the entire fleet
SELECT Model, Number, Capacity 
FROM Airplane
WHERE Capacity > (SELECT AVG(Capacity) FROM Airplane);

CREATE VIEW High_Capacity_Fleet AS
SELECT Model, Number, Capacity
FROM Airplane
WHERE Capacity > 250;
SELECT * FROM high_capacity_fleet;

---------------------------------------
-- Retal's QUERIES
---------------------------------------

-- Show passenger names and phone numbers for passengers from Egypt
SELECT First_name, Last_name, Phone_Number
FROM Passenger
WHERE Nationality = 'Egypt';

-- Show flight details departing from Riyadh
SELECT Flight_ID, Destination, Departure_Time
FROM Flight
WHERE Origin = 'Riyadh';


-- Count number of passengers per nationality
SELECT Nationality, COUNT(Passenger_ID) AS Total_Passengers
FROM Passenger
GROUP BY Nationality;

-- Calculate the average airplane capacity
SELECT AVG(Capacity) AS Average_Capacity
FROM Airplane;


-- Show booking details with passenger full name
SELECT B.Booking_ID, P.First_name, P.Last_name, B.BookingDate
FROM Booking B
INNER JOIN Passenger P
    ON B.Passenger_ID = P.Passenger_ID;

-- Show flight origin, destination, and airline name
SELECT F.Flight_ID, F.Origin, F.Destination, A.Name AS Airline_Name
FROM Flight F
JOIN Airline A
    ON F.Airline_ID = A.Airline_ID;


-- Show passengers who booked flights to Dubai
SELECT First_name, Last_name
FROM Passenger
WHERE Passenger_ID IN (
    SELECT Passenger_ID
    FROM Booking
    WHERE Flight_ID IN (
        SELECT Flight_ID
        FROM Flight
        WHERE Destination = 'Dubai'
    )
);

-- Show flights that use airplanes with capacity less than 200
SELECT Flight_ID, Origin, Destination
FROM Flight
WHERE Airplane_ID IN (
    SELECT Airplane_ID
    FROM Airplane
    WHERE Capacity < 200
);


-- Create a view showing booking info with passenger and flight destination
CREATE VIEW Booking_Report AS
SELECT B.Booking_ID,
       P.First_name,
       P.Last_name,
       F.Origin,
       F.Destination,
       B.TicketClass
FROM Booking B
JOIN Passenger P ON B.Passenger_ID = P.Passenger_ID
JOIN Flight F ON B.Flight_ID = F.Flight_ID;

SELECT * FROM Booking_Report;