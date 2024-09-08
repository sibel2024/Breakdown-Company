CREATE DATABASE Breakdownltd;
USE Breakdownltd;

-- Create Member Table
CREATE TABLE Member (
    Member_ID int PRIMARY KEY,
    First_Name varchar(20),
    Last_Name varchar(20),
    Member_Location varchar(20),
    Member_Age int
);

-- Create Vehicle Table
CREATE TABLE Vehicle (
    Vehicle_Registration varchar(10) PRIMARY KEY,
    Vehicle_Make varchar(10),
    Vehicle_Model varchar(10),
    Member_ID int,
    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID)
);

-- Create Engineer Table
CREATE TABLE Engineer (
    Engineer_ID int PRIMARY KEY,
    First_Name varchar(20),
    Last_Name varchar(20)
);

-- Create Breakdown Table
CREATE TABLE Breakdown (
    Breakdown_ID int PRIMARY KEY,
    Vehicle_Registration varchar(10),
    Engineer_ID int,
    Breakdown_Date date,
    Breakdown_Time time,
    Breakdown_Location varchar(20),
    FOREIGN KEY (Vehicle_Registration) REFERENCES Vehicle(Vehicle_Registration),
    FOREIGN KEY (Engineer_ID) REFERENCES Engineer(Engineer_ID)
);

INSERT INTO Member (Member_ID, First_Name, Last_Name, Member_Location, Member_Age) VALUES
(1, 'John', 'Doe', 'New York', 34),
(2, 'Jane', 'Smith', 'Los Angeles', 28),
(3, 'Alice', 'Johnson', 'Chicago', 45),
(4, 'Bob', 'Brown', 'Houston', 39),
(5, 'Charlie', 'Davis', 'Phoenix', 50);

INSERT INTO Vehicle (Vehicle_Registration, Vehicle_Make, Vehicle_Model, Member_ID) VALUES
('ABC123', 'Toyota', 'Corolla', 1),
('XYZ789', 'Honda', 'Civic', 2),
('LMN456', 'Ford', 'Fiesta', 3),
('QRS678', 'BMW', 'X5', 4),
('DEF321', 'Audi', 'A4', 5),
('UVW111', 'Nissan', 'Altima', 1),
('JKL999', 'Tesla', 'Model S', 3),
('GHI654', 'Chevrolet', 'Impala', 2);

INSERT INTO Engineer (Engineer_ID, First_Name, Last_Name) VALUES
(1, 'Michael', 'Jordan'),
(2, 'Scottie', 'Pippen'),
(3, 'Dennis', 'Rodman');

INSERT INTO Breakdown (Breakdown_ID, Vehicle_Registration, Engineer_ID, Breakdown_Date, Breakdown_Time, Breakdown_Location) VALUES
(1, 'ABC123', 1, '2024-08-01', '09:00:00', 'Manhattan'),
(2, 'XYZ789', 2, '2024-08-01', '10:30:00', 'Brooklyn'),
(3, 'LMN456', 3, '2024-08-05', '12:15:00', 'Chicago'),
(4, 'QRS678', 1, '2024-08-12', '14:45:00', 'Houston'),
(5, 'DEF321', 2, '2024-08-12', '16:00:00', 'Phoenix'),
(6, 'UVW111', 3, '2024-08-15', '18:30:00', 'Queens'),
(7, 'JKL999', 1, '2024-08-20', '08:30:00', 'Chicago'),
(8, 'GHI654', 2, '2024-08-22', '10:15:00', 'Los Angeles'),
(9, 'ABC123', 3, '2024-08-25', '13:00:00', 'Manhattan'),
(10, 'UVW111', 1, '2024-08-25', '13:30:00', 'Bronx'),
(11, 'XYZ789', 2, '2024-08-28', '15:45:00', 'Los Angeles'),
(12, 'LMN456', 3, '2024-08-30', '17:00:00', 'Chicago');

SELECT * FROM Member; 
SELECT * FROM Engineer;
SELECT * FROM Breakdown;

-- Retrieve the first 3 members from the Member table.
SELECT * FROM Member LIMIT 3;

-- Retrieve 3 members, skipping the first 2.
SELECT * FROM Member LIMIT 3 OFFSET 2;

-- Retrieve all vehicles whose Vehicle_Make starts with 'T'.
SELECT * FROM Vehicle WHERE Vehicle_Make LIKE 'T%';

-- Retrieve all breakdowns that occurred between '2023-01-01' and '2023-06-30'.
SELECT * FROM Breakdown WHERE Breakdown_Date>= '2024-08-01' AND Breakdown_Date<= '2024-08-20';

-- Retrieve details of vehicles with three Vehicle_Registration of you own choice in the list –  for example vehicles with registration 'ABC123', 'XYZ789', 'ANZ789'.
SELECT * FROM Breakdown WHERE Vehicle_Registration = "ABC123" OR Vehicle_Registration = "DEF321" OR Vehicle_Registration= "XYZ789";

-- Retrieve the number of breakdowns each vehicle has had.
SELECT Vehicle_Registration, COUNT(Breakdown_ID) AS Number_of_Breakdowns FROM Breakdown GROUP BY Vehicle_Registration;

-- Retrieve all members sorted by Member_Age in descending order
SELECT * FROM Member ORDER BY Member_age DESC;

-- Retrieve all vehicles that are either 'Toyota' make or 'Honda' make, and the model starts with 'C’
SELECT * FROM Vehicle WHERE Vehicle_model LIKE 'C%' AND Vehicle_make = 'Toyota' OR Vehicle_make= 'Honda';

-- Retrieve all engineers who do not have any breakdowns assigned (use LEFT JOIN and IS NULL)
SELECT E.Engineer_ID, E.First_Name, E.Last_Name FROM Engineer E LEFT JOIN Breakdown B ON E.Engineer_ID= B.Engineer_ID WHERE B.Breakdown_ID IS NULL;

-- Retrieve all members aged between 25 and 40
SELECT * FROM Member WHERE Member_age>=25 AND Member_age<=40;

-- Retrieve all members whose First_Name starts with 'J' and Last_Name contains 'son'
SELECT * FROM Member WHERE First_name LIKE 'J%' AND Last_name LIKE '%son%';

-- Retrieve the top 5 oldest member.
SELECT * FROM Member ORDER BY Member_age DESC LIMIT 5;

-- Retrieve all vehicle registrations in uppercase.
SELECT UPPER (Vehicle_registration) FROM Vehicle;

-- Retrieve the details of all members along with the vehicles they own.
SELECT M.Member_ID, M.First_Name, M.Last_Name, V.Vehicle_Registration, V.Vehicle_Make, V.Vehicle_Model FROM Member M LEFT JOIN Vehicle V ON M.Member_ID = V.Member_ID;

-- Retrieve all members and any associated vehicles, including members who do not own any vehicles.
SELECT M.Member_ID, M.First_Name, M.Last_Name, V.Vehicle_Registration, V.Vehicle_Make, V.Vehicle_Model FROM Member M LEFT JOIN Vehicle V ON M.Member_ID = V.Member_ID;

-- Retrieve all vehicles and the associated members, including vehicles that are not owned by any members
SELECT  V.Vehicle_Registration, V.Vehicle_Make, V.Vehicle_Model, M.Member_ID, M.First_Name, M.Last_Name FROM Vehicle V LEFT JOIN Member M ON V.Member_ID = M.Member_ID;

-- Retrieve the number of breakdowns each member has had
SELECT M.Member_ID, M.First_Name, M.Last_Name, COUNT(B.Breakdown_ID) As Number_of_Breakdowns FROM Member M JOIN Vehicle V ON M.Member_ID = V.Member_ID JOIN Breakdown B ON V.Vehicle_Registration = B.Vehicle_Registration GROUP BY M.Member_ID, M.First_Name, M.Last_Name;

-- Retrieve all breakdowns along with member first name and last name that occurred for vehicles owned by members aged over 50
SELECT B.Breakdown_ID, B.Vehicle_Registration, B.Breakdown_Date, B.Breakdown_Time, B.Breakdown_Location, M.First_Name, M.Last_Name FROM Breakdown B JOIN Vehicle V ON B.Vehicle_Registration = V.Vehicle_Registration JOIN Member M ON V.Member_ID = M.Member_ID WHERE M.Member_Age>50;

-- TASK: Research SQL Functions
-- Research the following SQL functions: AVG, MAX, MIN, and SUM. Explain with examples how each is used.
SELECT AVG(Member_Age) As Avarage_Age FROM Member;
SELECT MAX(Member_Age) AS Max_Age FROM Member;
SELECT MIN(breakdown_time) AS Minimum_Breakdown_Time FROM breakdown;
SELECT COUNT(*) AS Total_Engineers FROM Engineer;

-- TASK: Update and Delete Records
-- Update 3 records of your own choice from the Engineer table.
UPDATE Engineer SET Last_Name = 'Jackson' WHERE Engineer_ID = 1;
UPDATE Engineer SET Last_Name = 'Robinson' WHERE Engineer_ID = 2;
UPDATE Engineer SET First_Name = 'Jane' WHERE Engineer_ID = 3;

-- Delete 2 records or your own choice from the breakdown table.
DELETE FROM Breakdown WHERE Breakdown_ID = 1;
DELETE FROM Breakdown WHERE Breakdown_ID = 2; 


