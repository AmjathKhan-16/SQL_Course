-- ================================================================
-- SQL PRACTICE COURSE — COLLEGE PLACEMENT DATABASE
-- Beginner → Intermediate SQL Practice
-- GitHub-ready .sql course
--
-- Each numbered QUERY has:
--   1) A practice question
--   2) The SQL answer
--
-- Topics:
-- 01. CREATE DATABASE / CREATE TABLE
-- 02. INSERT
-- 03. SELECT
-- 04. WHERE
-- 05. UPDATE
-- 06. DELETE
-- 07. DISTINCT
-- 08. AGGREGATE FUNCTIONS
-- 09. GROUP BY
-- 10. HAVING
-- 11. LIKE / IN / BETWEEN
-- 12. CASE
-- 13. JOIN
-- 14. SUBQUERY AND CTE
-- ================================================================


-- ================================================================
-- TOPIC 01 — CREATE DATABASE AND CREATE TABLE
-- ================================================================
-- Learn:
-- CREATE DATABASE creates a database.
-- USE selects the database in which the following commands run.
-- CREATE TABLE defines columns, data types, and constraints.
-- PRIMARY KEY uniquely identifies a row.
-- NOT NULL requires a value.
-- DEFAULT supplies a value when one is not provided.

CREATE DATABASE CollegePlacement;
USE CollegePlacement;

-- QUERY 01
-- Question: Create a Students table with student ID, name, department,
-- age, and marks. Make student_id the primary key.
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department VARCHAR(30),
    age INT,
    marks DECIMAL(5,2)
);

-- QUERY 02
-- Question: Create a Department table with a unique department ID,
-- a required department name, an HOD name, and a default student count of 0.
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    hod_name VARCHAR(50),
    student_count INT DEFAULT 0
);

-- QUERY 03
-- Question: Create a Placement table containing placement ID,
-- student ID, company name, package, placement date, and status.
-- The default status should be 'Pending'.
CREATE TABLE Placement (
    placement_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    package_lpa DECIMAL(5,2),
    placement_date DATE,
    status VARCHAR(20) DEFAULT 'Pending'
);

-- Optional cleanup examples. Uncomment only when you actually want
-- to remove the objects.
-- DROP TABLE Placement;
-- DROP TABLE Department;
-- DROP TABLE Students;
-- DROP DATABASE CollegePlacement;


-- ================================================================
-- TOPIC 02 — INSERT
-- ================================================================
-- Learn:
-- INSERT INTO adds new rows to a table.
-- You can insert one row or multiple rows.
-- You can omit a column when it has a DEFAULT value or allows NULL.

-- QUERY 04
-- Question: Insert Arjun, a CSE student aged 21 with 87.50 marks.
INSERT INTO Students (student_id, student_name, department, age, marks)
VALUES (101, 'Arjun', 'CSE', 21, 87.50);

-- QUERY 05
-- Question: Insert three students: Priya, Rahul, and Meena,
-- with their departments, ages, and marks.
INSERT INTO Students (student_id, student_name, department, age, marks)
VALUES
    (102, 'Priya', 'ECE', 22, 91.25),
    (103, 'Rahul', 'CSE', 21, 78.50),
    (104, 'Meena', 'IT', 22, 88.75);

-- QUERY 06
-- Question: Insert Karthik as a MECH student aged 22.
-- Do not provide marks so that the column remains NULL.
INSERT INTO Students (student_id, student_name, department, age)
VALUES (105, 'Karthik', 'MECH', 22);

-- QUERY 07
-- Question: Insert Arjun's TCS placement with a package of 6.50 LPA.
-- Let the default status remain 'Pending'.
INSERT INTO Placement
    (placement_id, student_id, company_name, package_lpa, placement_date)
VALUES
    (1, 101, 'TCS', 6.50, '2026-08-15');

-- QUERY 08
-- Question: Insert Priya's Infosys placement as Selected and Rahul's
-- Wipro placement as Rejected.
INSERT INTO Placement
    (placement_id, student_id, company_name, package_lpa, placement_date, status)
VALUES
    (2, 102, 'Infosys', 7.25, '2026-08-20', 'Selected'),
    (3, 103, 'Wipro', 5.80, '2026-08-22', 'Rejected');

-- QUERY 09
-- Question: Insert department master data so that the later JOIN examples
-- can match student departments.
INSERT INTO Department
    (department_id, department_name, hod_name, student_count)
VALUES
    (1, 'CSE', 'Dr. Kumar', 2),
    (2, 'ECE', 'Dr. Priya', 1),
    (3, 'IT', 'Dr. Meena', 1),
    (4, 'MECH', 'Dr. Ravi', 1);


-- ================================================================
-- TOPIC 03 — SELECT
-- ================================================================
-- Learn:
-- SELECT retrieves data.
-- * means all columns.
-- You can select only the columns you need.
-- AS creates a readable alias.
-- ORDER BY sorts the result.

-- QUERY 10
-- Question: Display all students and all their columns.
SELECT * FROM Students;

-- QUERY 11
-- Question: Display each student's name, department, and marks.
SELECT student_name, department, marks
FROM Students;

-- QUERY 12
-- Question: Display student names as 'Name' and marks as 'Score'.
SELECT student_name AS Name, marks AS Score
FROM Students;

-- QUERY 13
-- Question: Display each unique department in the Students table.
SELECT DISTINCT department
FROM Students;

-- QUERY 14
-- Question: Display student ID, name, and marks from highest marks
-- to lowest marks.
SELECT student_id, student_name, marks
FROM Students
ORDER BY marks DESC;


-- ================================================================
-- TOPIC 04 — WHERE
-- ================================================================
-- Learn:
-- WHERE filters rows.
-- AND requires all conditions to be true.
-- OR requires at least one condition to be true.
-- BETWEEN checks an inclusive range.
-- != means "not equal to".

-- QUERY 15
-- Question: Find students whose marks are greater than 80.
SELECT *
FROM Students
WHERE marks > 80;

-- QUERY 16
-- Question: Find CSE students whose marks are greater than 80.
SELECT student_name, department, marks
FROM Students
WHERE department = 'CSE'
  AND marks > 80;

-- QUERY 17
-- Question: Find students who are from CSE or have marks greater than 90.
SELECT *
FROM Students
WHERE department = 'CSE'
   OR marks > 90;

-- QUERY 18
-- Question: Find students whose marks are between 80 and 90.
SELECT *
FROM Students
WHERE marks BETWEEN 80 AND 90;

-- QUERY 19
-- Question: Find students who are not from CSE and have marks of at least 85.
SELECT *
FROM Students
WHERE department != 'CSE'
  AND marks >= 85;


-- ================================================================
-- TOPIC 05 — UPDATE
-- ================================================================
-- Learn:
-- UPDATE changes existing rows.
-- Always use WHERE unless you intentionally want to update every row.
-- You can update one column or multiple columns.
-- An expression can update a value relative to its current value.

-- QUERY 20
-- Question: Set Karthik's marks to 85.
UPDATE Students
SET marks = 85
WHERE student_name = 'Karthik';

-- QUERY 21
-- Question: Display all students after the previous update.
SELECT * FROM Students;

-- QUERY 22
-- Question: Add 5 marks to every CSE student's current marks.
UPDATE Students
SET marks = marks + 5
WHERE department = 'CSE';

-- QUERY 23
-- Question: Change Karthik's department to CSE and increase his marks by 3.
UPDATE Students
SET department = 'CSE',
    marks = marks + 3
WHERE student_name = 'Karthik';

-- QUERY 24
-- Question: Change every Pending placement to Selected.
UPDATE Placement
SET status = 'Selected'
WHERE status = 'Pending';

-- QUERY 25
-- Question: Display all placement records after changing their status.
SELECT * FROM Placement;

-- QUERY 26
-- Question: Increase every placement package below 7 LPA by 10%,
-- rounding the result to two decimal places.
UPDATE Placement
SET package_lpa = ROUND(package_lpa + (package_lpa * 10 / 100), 2)
WHERE package_lpa < 7;


-- ================================================================
-- TOPIC 06 — DELETE
-- ================================================================
-- Learn:
-- DELETE removes rows.
-- WHERE controls which rows are deleted.
-- Always check the WHERE condition carefully before DELETE.

-- QUERY 27
-- Question: Delete the student whose student_id is 105.
DELETE FROM Students
WHERE student_id = 105;

-- QUERY 28
-- Question: Delete all students from the MECH department.
DELETE FROM Students
WHERE department = 'MECH';

-- QUERY 29
-- Question: Delete students whose marks are below 60.
DELETE FROM Students
WHERE marks < 60;

-- QUERY 30
-- Question: Delete rejected placements whose package is below 6 LPA.
DELETE FROM Placement
WHERE status = 'Rejected'
  AND package_lpa < 6;

-- QUERY 31
-- Question: Delete students who are from ECE or whose marks are below 50.
DELETE FROM Students
WHERE department = 'ECE'
   OR marks < 50;


-- ================================================================
-- TOPIC 07 — DISTINCT
-- ================================================================
-- Learn:
-- DISTINCT removes duplicate combinations from the result.
-- DISTINCT applies to all selected columns together.

-- QUERY 32
-- Question: Display each unique department in alphabetical order.
SELECT DISTINCT department
FROM Students
ORDER BY department ASC;

-- QUERY 33
-- Question: Display unique combinations of department and age.
SELECT DISTINCT department, age
FROM Students
ORDER BY department ASC;

-- QUERY 34
-- Question: Display each company that appears in the Placement table.
SELECT DISTINCT company_name
FROM Placement;

-- QUERY 35
-- Question: Display each unique combination of company and placement status.
SELECT DISTINCT company_name, status
FROM Placement;

-- QUERY 36
-- Question: Display departments that have at least one student
-- with marks above 80, without duplicates.
SELECT DISTINCT department
FROM Students
WHERE marks > 80
ORDER BY department ASC;


-- ================================================================
-- TOPIC 08 — AGGREGATE FUNCTIONS
-- ================================================================
-- Learn:
-- COUNT counts rows/values.
-- AVG calculates an average.
-- MAX finds the largest value.
-- MIN finds the smallest value.
-- SUM adds numeric values.

-- QUERY 37
-- Question: Count the total number of students.
SELECT COUNT(*) AS student_count
FROM Students;

-- QUERY 38
-- Question: Find the average student marks, rounded to two decimals.
SELECT ROUND(AVG(marks), 2) AS average_marks
FROM Students;

-- QUERY 39
-- Question: Find the highest student marks.
SELECT MAX(marks) AS highest_marks
FROM Students;

-- QUERY 40
-- Question: Find the lowest student marks.
SELECT MIN(marks) AS lowest_marks
FROM Students;

-- QUERY 41
-- Question: Find the total of all student marks.
SELECT SUM(marks) AS total_marks
FROM Students;


-- ================================================================
-- TOPIC 09 — GROUP BY
-- ================================================================
-- Learn:
-- GROUP BY combines rows having the same value.
-- Aggregate functions can then calculate results for each group.

-- QUERY 42
-- Question: Count the number of students in each department.
SELECT department, COUNT(*) AS student_count
FROM Students
GROUP BY department;

-- QUERY 43
-- Question: Find the average marks for each department.
SELECT department, ROUND(AVG(marks), 2) AS average_marks
FROM Students
GROUP BY department;

-- QUERY 44
-- Question: Find the highest marks in each department.
SELECT department, MAX(marks) AS highest_marks
FROM Students
GROUP BY department;

-- QUERY 45
-- Question: Find the total marks for each department.
SELECT department, SUM(marks) AS total_marks
FROM Students
GROUP BY department;

-- QUERY 46
-- Question: Display only departments that contain more than one student.
SELECT department, COUNT(*) AS student_count
FROM Students
GROUP BY department
HAVING COUNT(*) > 1;


-- ================================================================
-- TOPIC 10 — HAVING
-- ================================================================
-- Learn:
-- WHERE filters individual rows before grouping.
-- HAVING filters groups after GROUP BY.
-- HAVING is commonly used with aggregate functions.

-- QUERY 47
-- Question: Find departments whose average marks are above 80.
SELECT department, ROUND(AVG(marks), 2) AS avg_score
FROM Students
GROUP BY department
HAVING AVG(marks) > 80;

-- QUERY 48
-- Question: Find departments whose highest mark is greater than 90.
SELECT department, MAX(marks) AS highest_marks
FROM Students
GROUP BY department
HAVING MAX(marks) > 90;

-- QUERY 49
-- Question: Find departments with more than one student and
-- an average mark above 80.
SELECT department,
       COUNT(*) AS student_count,
       ROUND(AVG(marks), 2) AS avg_marks
FROM Students
GROUP BY department
HAVING COUNT(*) > 1
   AND AVG(marks) > 80;

-- QUERY 50
-- Question: Find departments with more than one student,
-- average marks above 80, and highest marks above 90.
SELECT department,
       COUNT(*) AS student_count,
       ROUND(AVG(marks), 2) AS avg_marks,
       MAX(marks) AS max_marks
FROM Students
GROUP BY department
HAVING COUNT(*) > 1
   AND AVG(marks) > 80
   AND MAX(marks) > 90;

-- QUERY 51
-- Question: Find departments with at least two students,
-- average marks above 80, and minimum marks above 80.
SELECT department,
       COUNT(*) AS student_count,
       ROUND(AVG(marks), 2) AS avg_marks,
       MIN(marks) AS min_marks
FROM Students
GROUP BY department
HAVING AVG(marks) > 80
   AND MIN(marks) > 80
   AND COUNT(*) >= 2;


-- ================================================================
-- TOPIC 11 — LIKE / IN / BETWEEN
-- ================================================================
-- Learn:
-- LIKE performs pattern matching.
-- % means zero or more characters.
-- _ means exactly one character.
-- IN checks whether a value belongs to a list.
-- NOT IN excludes values from a list.
-- BETWEEN checks an inclusive range.

-- QUERY 52
-- Question: Display all students before practicing pattern matching.
SELECT * FROM Students;

-- QUERY 53
-- Question: Find students whose names start with the letter 'A'.
SELECT *
FROM Students
WHERE student_name LIKE 'A%';

-- QUERY 54
-- Question: Find students whose names end with the letter 'A'.
SELECT *
FROM Students
WHERE student_name LIKE '%A';

-- QUERY 55
-- Question: Find students whose names contain the letter 'A' anywhere.
SELECT *
FROM Students
WHERE student_name LIKE '%A%';

-- QUERY 56
-- Question: Find students whose names contain exactly five characters.
SELECT *
FROM Students
WHERE student_name LIKE '_____';

-- QUERY 57
-- Question: Find students whose names start with 'A' and contain
-- exactly five characters in total.
SELECT *
FROM Students
WHERE student_name LIKE 'A____';

-- QUERY 58
-- Question: Find students belonging to CSE, IT, or ECE.
SELECT student_name, department
FROM Students
WHERE department IN ('CSE', 'IT', 'ECE');

-- QUERY 59
-- Question: Find students who do not belong to CSE or IT.
SELECT student_name, department
FROM Students
WHERE department NOT IN ('CSE', 'IT');

-- QUERY 60
-- Question: Find students whose marks are exactly 83.50, 88.75, or 92.50.
SELECT student_name, marks
FROM Students
WHERE marks IN (83.50, 88.75, 92.50);

-- QUERY 61
-- Question: Find students who are not in CSE or IT and whose marks
-- are greater than 80.
SELECT student_name, department, marks
FROM Students
WHERE department NOT IN ('CSE', 'IT')
  AND marks > 80;

-- QUERY 62
-- Question: Find CSE or IT students whose marks are greater than 85.
SELECT student_name, department, marks
FROM Students
WHERE department IN ('CSE', 'IT')
  AND marks > 85;


-- ================================================================
-- TOPIC 12 — CASE STATEMENT
-- ================================================================
-- Learn:
-- CASE creates conditional output.
-- WHEN checks a condition.
-- THEN returns a value when the condition is true.
-- ELSE handles all remaining cases.
-- END finishes the CASE expression.

-- QUERY 63
-- Question: Categorize students as Excellent (85+), Good (75+),
-- or Needs Improvement.
SELECT student_name, marks,
       CASE
           WHEN marks >= 85 THEN 'Excellent'
           WHEN marks >= 75 THEN 'Good'
           ELSE 'Needs Improvement'
       END AS result
FROM Students;

-- QUERY 64
-- Question: Categorize student performance as Topper (90+),
-- Above Average (80+), Average (70+), or Below Average.
SELECT student_name, department, marks,
       CASE
           WHEN marks >= 90 THEN 'Topper'
           WHEN marks >= 80 THEN 'Above Average'
           WHEN marks >= 70 THEN 'Average'
           ELSE 'Below Average'
       END AS performance
FROM Students;

-- QUERY 65
-- Question: Categorize placement packages as High (10+ LPA),
-- Medium (7+ LPA), or Low.
SELECT company_name, package_lpa,
       CASE
           WHEN package_lpa >= 10 THEN 'High'
           WHEN package_lpa >= 7 THEN 'Medium'
           ELSE 'Low'
       END AS package_category
FROM Placement;

-- QUERY 66
-- Question: For each placement, label it as Good Package when selected
-- with 7+ LPA, Low Package when selected below 7 LPA,
-- or Not Selected otherwise.
SELECT company_name, package_lpa, status,
       CASE
           WHEN status = 'Selected' AND package_lpa >= 7 THEN 'Good package'
           WHEN status = 'Selected' AND package_lpa < 7 THEN 'Low package'
           ELSE 'Not selected'
       END AS placement_result
FROM Placement;

-- QUERY 67
-- Question: Classify students as Eligible when marks are at least 85
-- and age is at most 22, Maybe when marks are at least 75 and age
-- is at most 22, otherwise Not Eligible.
SELECT student_name, age, marks,
       CASE
           WHEN marks >= 85 AND age <= 22 THEN 'Eligible'
           WHEN marks >= 75 AND age <= 22 THEN 'Maybe'
           ELSE 'Not Eligible'
       END AS eligibility
FROM Students;


-- ================================================================
-- TOPIC 13 — JOIN
-- ================================================================
-- Learn:
-- JOIN combines related rows from multiple tables.
-- INNER JOIN returns matching rows from both tables.
-- LEFT JOIN keeps every row from the left table.
-- RIGHT JOIN keeps every row from the right table.
-- The ON clause defines how the tables are related.

-- QUERY 68
-- Question: Display students who have a matching placement,
-- including student name, company, and package.
SELECT s.student_name, p.company_name, p.package_lpa
FROM Students AS s
INNER JOIN Placement AS p
    ON s.student_id = p.student_id;

-- QUERY 69
-- Question: Display every student and their placement details when available.
SELECT s.student_name, p.company_name, p.package_lpa
FROM Students AS s
LEFT JOIN Placement AS p
    ON s.student_id = p.student_id;

-- QUERY 70
-- Question: Display every placement and the matching student details
-- when available.
SELECT s.student_name, p.company_name, p.package_lpa
FROM Placement AS p
LEFT JOIN Students AS s
    ON s.student_id = p.student_id;

-- QUERY 71
-- Question: Display every placement using RIGHT JOIN, together with
-- the matching student details.
SELECT s.student_name, p.company_name, p.package_lpa
FROM Students AS s
RIGHT JOIN Placement AS p
    ON s.student_id = p.student_id;

-- QUERY 72
-- Question: Join Students, Department, and Placement to display
-- student name, department name, company, and package.
SELECT s.student_name,
       d.department_name,
       p.company_name,
       p.package_lpa
FROM Students AS s
INNER JOIN Department AS d
    ON s.department = d.department_name
INNER JOIN Placement AS p
    ON s.student_id = p.student_id;

-- QUERY 73
-- Question: Find the average placement package for each department.
SELECT s.department, ROUND(AVG(p.package_lpa), 2) AS avg_package
FROM Students AS s
INNER JOIN Placement AS p
    ON s.student_id = p.student_id
GROUP BY s.department;

-- QUERY 74
-- Question: Find departments whose average placement package is above 7 LPA.
SELECT s.department, ROUND(AVG(p.package_lpa), 2) AS avg_package
FROM Students AS s
INNER JOIN Placement AS p
    ON s.student_id = p.student_id
GROUP BY s.department
HAVING AVG(p.package_lpa) > 7;

-- QUERY 75
-- Question: Find the highest placement package for each department.
SELECT s.department, MAX(p.package_lpa) AS highest_package
FROM Students AS s
INNER JOIN Placement AS p
    ON s.student_id = p.student_id
GROUP BY s.department;

-- QUERY 76
-- Question: Find departments with more than one placed student and
-- a highest package above 7 LPA.
SELECT s.department,
       COUNT(*) AS placed_student_count,
       MAX(p.package_lpa) AS highest_package
FROM Students AS s
INNER JOIN Placement AS p
    ON s.student_id = p.student_id
GROUP BY s.department
HAVING MAX(p.package_lpa) > 7
   AND COUNT(*) > 1;

-- QUERY 77
-- Question: Find departments where the average student marks are above 85
-- and the highest placement package is above 7 LPA.
SELECT s.department,
       ROUND(AVG(s.marks), 2) AS avg_marks,
       MAX(p.package_lpa) AS highest_package
FROM Students AS s
INNER JOIN Placement AS p
    ON s.student_id = p.student_id
GROUP BY s.department
HAVING AVG(s.marks) > 85
   AND MAX(p.package_lpa) > 7;


-- ================================================================
-- TOPIC 14 — SUBQUERIES AND CTE
-- ================================================================
-- Learn:
-- A subquery is a query inside another query.
-- A scalar subquery returns one value, such as AVG or MAX.
-- IN can compare a value with multiple rows from a subquery.
-- ALL compares a value against every value returned by a subquery.
-- A CTE (WITH ... AS) creates a temporary named result for the query.
--
-- IMPORTANT:
-- Some of the original examples used aliases incorrectly or compared
-- unrelated columns. The versions below keep the intended learning
-- objective while making the SQL executable and logically meaningful.

-- QUERY 78
-- Question: Find students whose marks are above the overall average marks.
SELECT student_name, marks
FROM Students
WHERE marks > (
    SELECT AVG(marks)
    FROM Students
);

-- QUERY 79
-- Question: Using a CTE, find students whose marks are above
-- the overall average marks.
WITH avg_mark AS (
    SELECT AVG(marks) AS avg_marks
    FROM Students
)
SELECT student_name, marks
FROM Students
WHERE marks > (SELECT avg_marks FROM avg_mark);

-- QUERY 80
-- Question: Find students who belong to departments whose average
-- marks are above 85.
SELECT student_name, department, marks
FROM Students
WHERE department IN (
    SELECT department
    FROM Students
    GROUP BY department
    HAVING AVG(marks) > 85
);

-- QUERY 81
-- Question: Using a CTE, find students who belong to departments
-- whose average marks are above 85.
WITH departments AS (
    SELECT department
    FROM Students
    GROUP BY department
    HAVING AVG(marks) > 85
)
SELECT student_name, department, marks
FROM Students
WHERE department IN (SELECT department FROM departments);

-- QUERY 82
-- Question: Find the student or students who have the highest marks.
SELECT student_name, marks
FROM Students
WHERE marks = (
    SELECT MAX(marks)
    FROM Students
);

-- QUERY 83
-- Question: Using a CTE, find the student or students with the highest marks.
WITH maximum AS (
    SELECT MAX(marks) AS max_marks
    FROM Students
)
SELECT student_name, marks
FROM Students
WHERE marks = (SELECT max_marks FROM maximum);

-- QUERY 84
-- Question: Find the student or students who have the lowest marks.
SELECT student_name, marks
FROM Students
WHERE marks = (
    SELECT MIN(marks)
    FROM Students
);

-- QUERY 85
-- Question: Find the student or students who have the second-highest
-- distinct marks.
SELECT student_name, marks
FROM Students
WHERE marks = (
    SELECT MAX(marks)
    FROM Students
    WHERE marks < (
        SELECT MAX(marks)
        FROM Students
    )
);

-- QUERY 86
-- Question: Find students whose marks are greater than Rahul's marks.
SELECT student_name, marks
FROM Students
WHERE marks > (
    SELECT marks
    FROM Students
    WHERE student_name = 'Rahul'
);

-- QUERY 87
-- Question: Find students whose age is greater than the average age.
SELECT student_name, age
FROM Students
WHERE age > (
    SELECT AVG(age)
    FROM Students
);

-- QUERY 88
-- Question: Find students who belong to the same department as Arjun.
SELECT student_name, department
FROM Students
WHERE department IN (
    SELECT department
    FROM Students
    WHERE student_name = 'Arjun'
);

-- QUERY 89
-- Question: Find students who belong to departments containing
-- at least one student with marks above 90.
SELECT student_name, department, marks
FROM Students
WHERE department IN (
    SELECT department
    FROM Students
    WHERE marks > 90
);

-- QUERY 90
-- Question: Find students whose marks are greater than every CSE student's marks.
SELECT student_name, department, marks
FROM Students
WHERE marks > ALL (
    SELECT marks
    FROM Students
    WHERE department = 'CSE'
);

-- QUERY 91
-- Question: Find the company or companies offering the highest package.
SELECT company_name, package_lpa
FROM Placement
WHERE package_lpa = (
    SELECT MAX(package_lpa)
    FROM Placement
);

-- QUERY 92
-- Question: Find students who have a placement with status 'Selected'.
SELECT student_name, department
FROM Students
WHERE student_id IN (
    SELECT student_id
    FROM Placement
    WHERE status = 'Selected'
);

-- QUERY 93
-- Question: Using a CTE, find students whose marks are above 85.
WITH high_mark_students AS (
    SELECT student_id
    FROM Students
    WHERE marks > 85
)
SELECT student_name, department, marks
FROM Students
WHERE student_id IN (
    SELECT student_id
    FROM high_mark_students
);

-- QUERY 94
-- Question: Using a CTE, calculate the average marks of each department
-- and display only departments whose average is above 85.
WITH department_averages AS (
    SELECT department,
           ROUND(AVG(marks), 2) AS avg_marks
    FROM Students
    GROUP BY department
)
SELECT department, avg_marks
FROM department_averages
WHERE avg_marks > 85;

-- QUERY 95
-- Question: Using a CTE, find the highest-marked student in the CSE department.
WITH cse_students AS (
    SELECT student_name, marks, department
    FROM Students
    WHERE department = 'CSE'
),
cse_max AS (
    SELECT MAX(marks) AS max_marks
    FROM cse_students
)
SELECT student_name, marks
FROM cse_students
WHERE marks = (SELECT max_marks FROM cse_max);

-- QUERY 96
-- Question: Using a CTE, display placed students whose package is above 7 LPA.
WITH placed_students AS (
    SELECT s.student_name,
           s.department,
           p.company_name,
           p.package_lpa
    FROM Students AS s
    INNER JOIN Placement AS p
        ON s.student_id = p.student_id
)
SELECT student_name, department, company_name, package_lpa
FROM placed_students
WHERE package_lpa > 7;

-- QUERY 97
-- Question: Using a CTE, calculate the average placement package by
-- department and display departments whose average package is above 7 LPA,
-- together with the number of placement records in each department.
WITH department_packages AS (
    SELECT s.department,
           AVG(p.package_lpa) AS avg_package,
           COUNT(*) AS placed_count
    FROM Students AS s
    INNER JOIN Placement AS p
        ON s.student_id = p.student_id
    GROUP BY s.department
    HAVING AVG(p.package_lpa) > 7
)
SELECT department,
       ROUND(avg_package, 2) AS avg_package,
       placed_count
FROM department_packages;


-- ================================================================
-- END OF SQL PRACTICE COURSE
-- Total numbered queries: 97
-- ================================================================
