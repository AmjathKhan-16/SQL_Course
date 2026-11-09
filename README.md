# SQL Practice Course — College Placement Database

A beginner-to-intermediate **SQL practice course** built around a College Placement database.

The course contains **97 numbered SQL queries**. Each exercise includes a practical question followed by the SQL solution, making it useful for learning SQL concepts, practicing query writing, and preparing for SQL interviews.

## 📚 Topics Covered

| # | Topic | Main Concepts |
|---|---|---|
| 01 | CREATE DATABASE & TABLE | `CREATE DATABASE`, `USE`, `CREATE TABLE`, data types, constraints |
| 02 | INSERT | Single-row and multi-row `INSERT` |
| 03 | SELECT | Selecting columns, `*`, aliases, `ORDER BY` |
| 04 | WHERE | Filtering, `AND`, `OR`, comparison operators, `BETWEEN` |
| 05 | UPDATE | Updating one/multiple columns, calculated updates |
| 06 | DELETE | Conditional row deletion |
| 07 | DISTINCT | Removing duplicate results |
| 08 | Aggregate Functions | `COUNT`, `AVG`, `MAX`, `MIN`, `SUM` |
| 09 | GROUP BY | Grouping rows and aggregate calculations |
| 10 | HAVING | Filtering grouped results |
| 11 | LIKE / IN / BETWEEN | Pattern matching and list/range filtering |
| 12 | CASE | Conditional classification with `CASE` |
| 13 | JOIN | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, multi-table joins |
| 14 | Subqueries & CTE | Subqueries, `IN`, `ALL`, `WITH ... AS`, nested queries |

## 🗂️ Course Structure

The main SQL file is:

```text
SQL_course_GitHub_Ready.sql
```

The queries are numbered continuously:

```text
QUERY 01
QUERY 02
QUERY 03
...
QUERY 97
```

Each query follows this format:

```sql
-- QUERY 10
-- Question: Display each student's name, department, and marks.
SELECT student_name, department, marks
FROM Students;
```

This makes it easy to study one problem at a time.

---

## 🛠️ Setup

You need a SQL database system that supports the SQL syntax used in this course.

### Recommended

- MySQL 8.0+
- MySQL Workbench
- MySQL Command Line Client

You can also use another SQL environment, but some syntax may vary between database systems.

### 1. Clone the repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd <YOUR_REPOSITORY_NAME>
```

### 2. Open the SQL file

Open:

```text
SQL_course_GitHub_Ready.sql
```

in MySQL Workbench or your preferred SQL editor.

### 3. Create and select the database

The course starts with:

```sql
CREATE DATABASE CollegePlacement;
USE CollegePlacement;
```

Run these statements first.

### 4. Create the tables

The course creates three main tables:

```text
Students
Department
Placement
```

Run the `CREATE TABLE` statements before running the `INSERT` queries.

### 5. Insert the sample data

Run the `INSERT` queries after creating the tables.

The sample data provides students, departments, and placement records for the later filtering, aggregation, JOIN, subquery, and CTE exercises.

---

## 🗃️ Database Schema

The course uses three related tables.

### Students

Stores student information.

| Column | Data Type | Description |
|---|---|---|
| `student_id` | `INT` | Unique student ID; Primary Key |
| `student_name` | `VARCHAR(50)` | Student name |
| `department` | `VARCHAR(30)` | Student department |
| `age` | `INT` | Student age |
| `marks` | `DECIMAL(5,2)` | Student marks |

### Department

Stores department information.

| Column | Data Type | Description |
|---|---|---|
| `department_id` | `INT` | Unique department ID; Primary Key |
| `department_name` | `VARCHAR(50)` | Department name; Required |
| `hod_name` | `VARCHAR(50)` | Head of Department |
| `student_count` | `INT` | Student count; Default `0` |

### Placement

Stores student placement information.

| Column | Data Type | Description |
|---|---|---|
| `placement_id` | `INT` | Unique placement ID; Primary Key |
| `student_id` | `INT` | Student associated with the placement |
| `company_name` | `VARCHAR(100)` | Company name |
| `package_lpa` | `DECIMAL(5,2)` | Package in LPA |
| `placement_date` | `DATE` | Placement date |
| `status` | `VARCHAR(20)` | Placement status; Default `Pending` |

### Relationship

The main relationship used in the JOIN exercises is:

```text
Students
   |
   | student_id
   |
Placement
```

Students and Placement are connected through:

```text
Students.student_id = Placement.student_id
```

The Department table is connected to Students through:

```text
Students.department = Department.department_name
```

---

## ▶️ How to Run the Course

### Option 1 — Run the complete course

Open the SQL file in MySQL Workbench and execute it.

However, for learning purposes, it is recommended to execute the queries **topic by topic** and **number by number**.

### Option 2 — Practice one query at a time

For example:

```sql
-- QUERY 15
-- Question: Find students whose marks are greater than 80.

SELECT *
FROM Students
WHERE marks > 80;
```

Before looking at the solution, try writing the query yourself.

Then compare your answer with the provided solution.

### Recommended practice method

For every numbered query:

1. Read the question.
2. Identify the table required.
3. Identify the columns required.
4. Identify the filtering/grouping condition.
5. Write the query yourself.
6. Execute your query.
7. Compare your result with the provided solution.
8. Move to the next query.

---

## 🔢 Query Progression

The course gradually increases in difficulty.

### Beginner

Start with:

```text
QUERY 01 → QUERY 41
```

Focus on:

- Creating tables
- Inserting data
- Selecting data
- Filtering
- Updating
- Deleting
- DISTINCT
- Aggregate functions

### Intermediate

Continue with:

```text
QUERY 42 → QUERY 77
```

Focus on:

- `GROUP BY`
- `HAVING`
- `LIKE`
- `IN`
- `BETWEEN`
- `CASE`
- JOINs
- Multi-table queries

### Subqueries & CTE

Finish with:

```text
QUERY 78 → QUERY 97
```

Focus on:

- Scalar subqueries
- `IN` subqueries
- `ALL`
- Nested queries
- Correlated-style comparisons
- Common Table Expressions
- Combining CTEs with aggregation and JOINs

---

## 💡 Important SQL Concepts

### WHERE vs HAVING

Use `WHERE` to filter individual rows:

```sql
SELECT *
FROM Students
WHERE marks > 80;
```

Use `HAVING` to filter groups created by `GROUP BY`:

```sql
SELECT department, AVG(marks) AS avg_marks
FROM Students
GROUP BY department
HAVING AVG(marks) > 80;
```

### INNER JOIN

Returns matching records from both tables:

```sql
SELECT s.student_name, p.company_name
FROM Students AS s
INNER JOIN Placement AS p
    ON s.student_id = p.student_id;
```

### LEFT JOIN

Keeps all records from the left table, even when a matching record does not exist in the right table.

### CASE

Useful for creating categories:

```sql
CASE
    WHEN marks >= 85 THEN 'Excellent'
    WHEN marks >= 75 THEN 'Good'
    ELSE 'Needs Improvement'
END
```

### Subquery

A query inside another query:

```sql
SELECT student_name, marks
FROM Students
WHERE marks > (
    SELECT AVG(marks)
    FROM Students
);
```

### CTE

A Common Table Expression gives a temporary named result:

```sql
WITH avg_marks AS (
    SELECT AVG(marks) AS average_marks
    FROM Students
)
SELECT *
FROM avg_marks;
```

---

## ⚠️ Important Practice Notes

### 1. Run INSERT statements before SELECT exercises

The SELECT, aggregation, JOIN, subquery, and CTE exercises depend on the sample data.

### 2. Be careful with UPDATE and DELETE

These commands change or remove data.

Always check the condition before executing:

```sql
UPDATE Students
SET marks = 90
WHERE student_id = 101;
```

and:

```sql
DELETE FROM Students
WHERE student_id = 101;
```

### 3. Some exercises modify the sample data

The course contains `UPDATE` and `DELETE` examples. If you want to repeatedly practice the entire course from the beginning, recreate/reset the database so the original sample data is available again.

### 4. NULL values

Karthik's initial INSERT intentionally demonstrates a missing marks value. This is useful for understanding how SQL handles columns that are not provided.

---

## 🎯 Learning Goals

After completing this course, you should be able to:

- Create databases and tables
- Insert and retrieve data
- Filter rows using conditions
- Modify and delete records
- Remove duplicate results
- Use aggregate functions
- Group and filter grouped data
- Use pattern matching
- Write conditional logic with `CASE`
- Combine tables using JOINs
- Write subqueries
- Use CTEs
- Solve beginner-to-intermediate SQL interview problems

---

## 📌 Suggested Learning Order

```text
CREATE DATABASE
       ↓
CREATE TABLE
       ↓
INSERT
       ↓
SELECT
       ↓
WHERE
       ↓
UPDATE / DELETE
       ↓
DISTINCT
       ↓
AGGREGATE FUNCTIONS
       ↓
GROUP BY
       ↓
HAVING
       ↓
LIKE / IN / BETWEEN
       ↓
CASE
       ↓
JOIN
       ↓
SUBQUERY
       ↓
CTE
```

---

## 📁 Repository Structure

A simple GitHub repository can use:

```text
SQL-Practice-Course/
│
├── README.md
│
└── SQL_course_GitHub_Ready.sql
```

---

## 🚀 How to Use This Repository

This repository is designed as a **hands-on SQL practice course**.

Instead of only reading SQL syntax:

> Read the question → write your own query → execute it → compare your solution.

Try to solve each numbered question without looking at the answer first.

**97 queries. One database. Step-by-step SQL practice.**

---

## 📄 License

You can add your preferred open-source license here, such as MIT, if you want to make the repository reusable by others.
