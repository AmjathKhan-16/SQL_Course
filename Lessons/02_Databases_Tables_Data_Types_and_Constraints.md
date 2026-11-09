# Lesson 02: Databases, Tables, Data Types and Constraints

## 1. Learning objectives

You will learn to:

- Create and select a database.
- Create, inspect and remove tables.
- Choose suitable data types.
- Use primary keys, `NOT NULL`, `DEFAULT` and `UNIQUE`.
- Build the course's CollegePlacement database.

## 2. Create a database

A database is a container for related tables.

```sql
CREATE DATABASE CollegePlacement;
```

Select it before creating tables:

```sql
USE CollegePlacement;
```

To list databases:

```sql
SHOW DATABASES;
```

To see the currently selected database:

```sql
SELECT DATABASE();
```

## 3. Create a table

A table definition specifies its columns, data types and constraints.

```sql
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department VARCHAR(30),
    age INT,
    marks DECIMAL(5,2)
);
```

### Table structure

| Column | Meaning | Example |
|---|---|---|
| `student_id` | Student's unique ID | 101 |
| `student_name` | Student's name | Arjun |
| `department` | Department name | CSE |
| `age` | Student's age | 21 |
| `marks` | Marks with decimal places | 87.50 |

## 4. Common MySQL data types

| Data type | Used for | Example |
|---|---|---|
| `INT` | Whole numbers | `21` |
| `DECIMAL(5,2)` | Exact decimal values | `87.50` |
| `VARCHAR(50)` | Variable-length text | `'Arjun'` |
| `CHAR(2)` | Fixed-length text | `'IN'` |
| `DATE` | Calendar date | `'2026-08-15'` |
| `DATETIME` | Date and time | `'2026-08-15 10:30:00'` |
| `BOOLEAN` | True/false-style value | `TRUE` |

`DECIMAL(5,2)` allows five digits in total, with two digits after the decimal point. For example, `999.99` fits.

## 5. Constraints

Constraints are rules applied to table data.

### PRIMARY KEY

A primary key uniquely identifies each row and cannot contain `NULL`.

```sql
student_id INT PRIMARY KEY
```

### NOT NULL

Requires a value.

```sql
department_name VARCHAR(50) NOT NULL
```

### UNIQUE

Prevents duplicate values in a column or column combination.

```sql
email VARCHAR(100) UNIQUE
```

### DEFAULT

Supplies a value when an insert does not provide one.

```sql
student_count INT DEFAULT 0
```

### FOREIGN KEY

A foreign key links a column to a key in another table. It helps maintain referential integrity.

```sql
CREATE TABLE ExampleDepartment (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TABLE ExampleStudent (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES ExampleDepartment(department_id)
);
```

The course's original `Department` and `Students` tables use matching department names for the JOIN lesson. The example above demonstrates a more formal ID-based relationship.

## 6. Create the course tables

Run the following setup script once in a fresh practice database:

```sql
CREATE DATABASE IF NOT EXISTS CollegePlacement;
USE CollegePlacement;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department VARCHAR(30),
    age INT,
    marks DECIMAL(5,2)
);

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    hod_name VARCHAR(50),
    student_count INT DEFAULT 0
);

CREATE TABLE Placement (
    placement_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    package_lpa DECIMAL(5,2),
    placement_date DATE,
    status VARCHAR(20) DEFAULT 'Pending'
);
```

## 7. Inspect table structure

```sql
SHOW TABLES;
DESCRIBE Students;
DESCRIBE Department;
DESCRIBE Placement;
```

`DESCRIBE` displays column names, types, nullability, key information and defaults.

## 8. Modify a table structure

Add a column:

```sql
ALTER TABLE Students
ADD email VARCHAR(100);
```

Change a column's definition:

```sql
ALTER TABLE Students
MODIFY student_name VARCHAR(80);
```

Remove a column carefully:

```sql
ALTER TABLE Students
DROP COLUMN email;
```

`ALTER TABLE` changes the table structure; it does not simply change a row's data.

## 9. Drop database or table

```sql
DROP TABLE Placement;
```

```sql
DROP DATABASE CollegePlacement;
```

These commands remove database objects and their data. Do not run them on a database you need.

## 10. Practice questions

1. Create a database named `CompanyDB`.
2. Create an `Employees` table with employee ID, name, department and salary.
3. Make employee ID the primary key.
4. Make employee name `NOT NULL`.
5. Give a new column a suitable `DEFAULT` value.
6. Use `DESCRIBE` to inspect the table.

## 11. Common mistakes

- Forgetting the semicolon at the end of a statement.
- Creating a table before selecting the intended database.
- Choosing `VARCHAR` that is too short.
- Using a non-unique column as a primary key.
- Confusing `ALTER TABLE` with `UPDATE`.

## 12. Lesson recap

- `CREATE DATABASE` creates a database.
- `USE` selects a database.
- `CREATE TABLE` defines a table.
- Data types determine what kind of value a column stores.
- Constraints protect data quality.
- `ALTER TABLE` changes structure; `DROP` removes objects.

**Next lesson:** Insert records and retrieve them using SELECT.
