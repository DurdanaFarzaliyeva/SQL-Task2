CREATE DATABASE CompanyDB
USE CompanyDB

CREATE TABLE Departments (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100) NULL
);

CREATE TABLE Employees (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Salary DECIMAL(18, 2) NULL,
    DepartmentId INT NULL,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id) ON DELETE SET NULL
);

CREATE TABLE Projects (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Budget DECIMAL(18, 2) NULL,
    ManagerId INT NULL,
    FOREIGN KEY (ManagerId) REFERENCES Employees(Id) ON DELETE SET NULL
);

CREATE TABLE EmployeeProjects (
    EmployeeId INT,
    ProjectId INT,
    AssignedDate DATE,
    PRIMARY KEY (EmployeeId, ProjectId),
    FOREIGN KEY (EmployeeId) REFERENCES Employees(Id) ON DELETE CASCADE,
    FOREIGN KEY (ProjectId) REFERENCES Projects(Id) ON DELETE CASCADE
);

INSERT INTO Departments (Name, Location)
VALUES 
('IT', 'Baku'),
('HR', 'Khachmaz'),
('Marketing', 'Ganja');

INSERT INTO Employees (FullName, Salary, DepartmentId)
VALUES
('Durdana Farzaliyeva', 5000, 1),
('Fatima Abbasova', 3500, 1),
('Sabina Orucova', 4000, 2),
('Aynur Aliyeva', 4500, 3);

INSERT INTO Projects (Title, Budget, ManagerId)
VALUES
('Project A', 100000, 1),
('Project B', 150000, 3),
('Project C', 200000, 2);


INSERT INTO EmployeeProjects (EmployeeId, ProjectId, AssignedDate)
VALUES
(1, 1, '2026-01-01'),
(2, 1, '2026-01-15'),
(3, 2, '2026-02-01'),
(4, 3, '2026-02-15');

DELETE FROM Departments WHERE Id = 1; 
SELECT * FROM Employees;


DELETE FROM Employees WHERE Id = 1;
SELECT * FROM Projects;
SELECT * FROM EmployeeProjects;


DELETE FROM Projects WHERE Id = 1;
SELECT * FROM EmployeeProjects;

--Hər departamentdə neçə işçi olduğunu siyahılayilmaq.
SELECT d.Name AS DepartmentName, COUNT(e.Id) AS EmployeeCount
FROM Departments d
LEFT JOIN Employees e ON e.DepartmentId = d.Id
GROUP BY d.Name;

--Hər işçinin hansı layihələrdə çalışdığı.
SELECT e.FullName AS EmployeeName, p.Title AS ProjectTitle
FROM Employees e
JOIN EmployeeProjects ep ON e.Id = ep.EmployeeId
JOIN Projects p ON ep.ProjectId = p.Id;

--Manager-i olan layihələri manager adı ilə birlikde.
SELECT p.Title AS ProjectTitle, e.FullName AS ManagerName
FROM Projects p
JOIN Employees e ON p.ManagerId = e.Id
WHERE p.ManagerId IS NOT NULL;

--Layihəsi olmayan işçilər.
SELECT e.FullName AS EmployeeName
FROM Employees e
LEFT JOIN EmployeeProjects ep ON e.Id = ep.EmployeeId
WHERE ep.ProjectId IS NULL;

--Department-i silinmiş (DepartmentId = NULL olmuş) işçiləri siyahılamaq
SELECT e.FullName AS EmployeeName
FROM Employees e
WHERE e.DepartmentId IS NULL;




