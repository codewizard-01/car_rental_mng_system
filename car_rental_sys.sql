-- Part 1
CREATE TABLE Cars (
  CarID INTEGER PRIMARY KEY,
  Brand TEXT NOT NULL,
  Model TEXT NOT NULL,
  Year INTEGER NOT NULL,
  DailyPrice REAL NOT NULL
);

CREATE TABLE Customers (
  CustomerID INTEGER PRIMARY KEY,
  FullName TEXT NOT NULL,
  Email TEXT UNIQUE,
  Phone TEXT
);

CREATE TABLE Rentals (
  RentalID INTEGER PRIMARY KEY,
  CarID INTEGER NOT NULL,
  CustomerID INTEGER NOT NULL,
  StartDate TEXT NOT NULL,  
  EndDate TEXT NOT NULL,
  TotalCost REAL NOT NULL,
  FOREIGN KEY (CarID) REFERENCES Cars(CarID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


-- Part 2
INSERT INTO Cars (CarID, Brand, Model, Year, DailyPrice) VALUES
(1, 'Toyota', 'Corolla', 2019, 45.00),
(2, 'Ford', 'Focus', 2017, 40.00),
(3, 'BMW', '320i', 2021, 85.00),
(4, 'Audi', 'A4', 2020, 95.00),
(5, 'Fiat', '500', 2016, 30.00),
(6, 'Tesla', 'Model 3', 2022, 120.00),
(7, 'Renault', 'Clio', 2018, 38.00),
(8, 'Honda', 'Civic', 2023, 75.00);

INSERT INTO Customers (CustomerID, FullName, Email, Phone) VALUES
(1, 'Alice Romano', 'alice.romano@example.com', '6041234567'),
(2, 'Bruno Esposito', 'bruno@example.net', '3933332222'),
(3, 'Carla Bianchi', 'carla.bianchi@mail.com', '6049876543'),
(4, 'Daniele Russo', 'daniele.russo@example.com', '3354447777'),
(5, 'Elena Ferri', 'elena@ferri.org', '6045550000'),
(6, 'Fabio Greco', 'fabio@greco.io', '3201112222');

INSERT INTO Rentals (RentalID, CarID, CustomerID, StartDate, EndDate, TotalCost) VALUES
(1, 1, 1, '2025-11-01', '2025-11-05', 4 * 45.00),
(2, 3, 2, '2025-10-20', '2025-10-23', 3 * 85.00),
(3, 6, 3, '2025-09-15', '2025-09-20', 5 * 120.00),
(4, 2, 4, '2025-11-10', '2025-11-12', 2 * 40.00),
(5, 8, 1, '2025-10-28', '2025-11-03', 6 * 75.00),
(6, 5, 5, '2025-07-01', '2025-07-10', 9 * 30.00),
(7, 4, 6, '2025-11-05', '2025-11-09', 4 * 95.00),
(8, 7, 2, '2025-08-20', '2025-08-25', 5 * 38.00),
(9, 1, 3, '2025-10-05', '2025-10-08', 3 * 45.00),
(10, 3, 5, '2025-11-12', '2025-11-17', 5 * 85.00);


-- Part 3
SELECT * FROM Cars
ORDER BY DailyPrice DESC;

SELECT * FROM Customers
WHERE LOWER(FullName) LIKE '%a%';

SELECT * FROM Rentals
WHERE date(StartDate) >= date('now', '-30 days');


-- Part 4
SELECT * FROM Cars
WHERE Year < 2018;

SELECT * FROM Customers
WHERE Phone LIKE '604%';

SELECT *, (julianday(EndDate) - julianday(StartDate)) AS DurationDays
FROM Rentals
WHERE (julianday(EndDate) - julianday(StartDate)) > 5;

SELECT * FROM Cars
WHERE DailyPrice BETWEEN 50 AND 100;


-- Part 5 
SELECT r.RentalID, r.StartDate, r.EndDate, r.TotalCost,
       c.Brand, c.Model, c.Year, c.DailyPrice,
       cu.FullName, cu.Email, cu.Phone
FROM Rentals r
JOIN Cars c ON r.CarID = c.CarID
JOIN Customers cu ON r.CustomerID = cu.CustomerID;

SELECT *
FROM Cars c
LEFT JOIN Rentals r ON c.CarID = r.CarID
WHERE r.RentalID IS NULL;

SELECT DISTINCT cu.CustomerID, cu.FullName, cu.Email
FROM Customers cu
JOIN Rentals r ON cu.CustomerID = r.CustomerID
JOIN Cars c ON r.CarID = c.CarID
WHERE c.DailyPrice > 80;


-- Part 6 
SELECT COUNT(*) AS TotalRentals FROM Rentals;

SELECT AVG(julianday(EndDate) - julianday(StartDate)) AS AvgDurationDays FROM Rentals;

SELECT SUM(TotalCost) AS TotalRevenue FROM Rentals;

SELECT r.CustomerID, cu.FullName, COUNT(*) AS RentalsCount
FROM Rentals r
JOIN Customers cu ON r.CustomerID = cu.CustomerID
GROUP BY r.CustomerID, cu.FullName;


-- Part 7
SELECT r.CustomerID, cu.FullName, SUM(r.TotalCost) AS Revenue
FROM Rentals r
JOIN Customers cu ON r.CustomerID = cu.CustomerID
GROUP BY r.CustomerID, cu.FullName;

SELECT r.CustomerID, cu.FullName, COUNT(*) AS RentalsCount
FROM Rentals r
JOIN Customers cu ON r.CustomerID = cu.CustomerID
GROUP BY r.CustomerID, cu.FullName
HAVING COUNT(*) > 2;

SELECT r.CarID, c.Brand, c.Model, SUM(r.TotalCost) AS Income
FROM Rentals r
JOIN Cars c ON r.CarID = c.CarID
GROUP BY r.CarID, c.Brand, c.Model
HAVING SUM(r.TotalCost) > 500;










