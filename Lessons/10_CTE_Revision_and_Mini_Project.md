# Lesson 10: CTEs, Revision and Mini Project

## 1. Learning objectives

- Understand Common Table Expressions.
- Write a CTE using WITH.
- Use more than one CTE.
- Combine CTEs with JOIN, GROUP BY and filters.
- Review the course topics.
- Complete a small college placement project.

## 2. What is a CTE?

CTE stands for **Common Table Expression**. A CTE is a named result set defined with `WITH` and used by the statement that follows it.

A CTE can make a long query easier to read by separating it into meaningful steps.

### Basic syntax

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT ...
FROM cte_name;
```

A CTE is not a permanent table. It exists only for the statement in which it is defined.

## 3. First CTE example

Find students whose marks are above the overall average:

```sql
WITH avg_mark AS (
    SELECT AVG(marks) AS avg_marks
    FROM Students
)
SELECT student_name, marks
FROM Students
WHERE marks > (
    SELECT avg_marks
    FROM avg_mark
);
```

### How it works

```text
WITH avg_mark AS (...)
          |
          v
Calculate the average marks
          |
          v
Name the result avg_mark
          |
          v
Main SELECT reads that result
          |
          v
Display students above average
```

## 4. CTE with GROUP BY

Calculate average marks for each department and display departments with an average above 85:

```sql
WITH department_averages AS (
    SELECT department,
           AVG(marks) AS avg_marks
    FROM Students
    GROUP BY department
)
SELECT department,
       ROUND(avg_marks, 2) AS avg_marks
FROM department_averages
WHERE avg_marks > 85;
```

## 5. Multiple CTEs

You can define more than one CTE separated by commas.

Find the highest-marked student in CSE:

```sql
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
WHERE marks = (
    SELECT max_marks
    FROM cse_max
);
```

Each CTE can use a previous CTE in the same WITH clause.

## 6. CTE with JOIN

Display placed students whose package is above 7 LPA:

```sql
WITH placed_students AS (
    SELECT
        s.student_name,
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
```

## 7. CTE with aggregate results

Calculate the average placement package and number of placements by department. Display departments with an average package above 7 LPA:

```sql
WITH department_packages AS (
    SELECT
        s.department,
        AVG(p.package_lpa) AS avg_package,
        COUNT(*) AS placed_count
    FROM Students AS s
    INNER JOIN Placement AS p
        ON s.student_id = p.student_id
    GROUP BY s.department
    HAVING AVG(p.package_lpa) > 7
)
SELECT
    department,
    ROUND(avg_package, 2) AS avg_package,
    placed_count
FROM department_packages;
```

## 8. Subquery vs CTE

| Subquery | CTE |
|---|---|
| Query nested inside another query | Named query result declared with WITH |
| Good for compact conditions | Good for organizing multi-step logic |
| Can become difficult to read when deeply nested | Often easier to read when several steps are needed |
| Used inside SELECT, FROM, WHERE and other contexts | Defined before the main statement |

A CTE is not automatically faster than a subquery. Choose the form that makes the query clear, then measure performance when necessary.

## 9. SQL topic revision map

```text
SQL Beginner-to-Intermediate
          |
          +-- Database setup
          |      CREATE DATABASE / USE
          |
          +-- Table design
          |      CREATE TABLE / data types / constraints
          |
          +-- Data operations
          |      INSERT / SELECT / UPDATE / DELETE
          |
          +-- Filtering and sorting
          |      WHERE / LIKE / IN / BETWEEN / ORDER BY
          |
          +-- Summary and conditions
          |      COUNT / AVG / SUM / GROUP BY / HAVING / CASE
          |
          +-- Relationships
          |      INNER JOIN / LEFT JOIN / RIGHT JOIN
          |
          +-- Advanced query structure
                 Subqueries / ALL / EXISTS / CTE
```

## 10. Mini project: College Placement Analysis

Use the `CollegePlacement` database and its three tables:

- Students
- Department
- Placement

If you need sample data, use the INSERT statements in your original `SQL_course_GitHub_Ready.sql` practice file or insert your own records.

### Project tasks

**Part A — Basic retrieval**

1. Display all students.
2. Display student names, departments and marks.
3. Display unique departments.
4. Display students with marks above 80.
5. Display students in CSE or IT.

**Part B — Data modification**

6. Insert a new student.
7. Update that student's marks.
8. Preview the row before deleting it.
9. Delete only that test student by ID.

**Part C — Analysis**

10. Count the students in each department.
11. Calculate average marks by department.
12. Find departments with average marks above 80.
13. Classify students using CASE.
14. Find the highest marks in the Students table.

**Part D — Relationships**

15. Display student names with their placement company.
16. Display all students, including those without a placement.
17. Calculate the average placement package by department.
18. Find the company offering the highest package.

**Part E — Subqueries and CTEs**

19. Find students above the overall average marks using a subquery.
20. Find students above the overall average marks using a CTE.
21. Find students without a placement using NOT EXISTS.
22. Find the highest-marked student in each department using a CTE or a suitable alternative.

## 11. Suggested project submission structure

```text
CollegePlacement-SQL-Project/
|
+-- README.md
+-- 01_create_tables.sql
+-- 02_insert_sample_data.sql
+-- 03_basic_queries.sql
+-- 04_filtering_and_sorting.sql
+-- 05_aggregate_and_grouping.sql
+-- 06_joins.sql
+-- 07_subqueries_and_ctes.sql
+-- screenshots/
```

## 12. Beginner-to-intermediate completion checklist

- [ ] I can explain database, table, row and column.
- [ ] I can install MySQL Server and connect through Workbench.
- [ ] I can create a database and tables.
- [ ] I understand basic data types and constraints.
- [ ] I can insert and retrieve records.
- [ ] I can filter and sort results.
- [ ] I can update and delete records safely.
- [ ] I can use aggregate functions and GROUP BY.
- [ ] I understand WHERE vs HAVING.
- [ ] I can write CASE expressions.
- [ ] I can use INNER, LEFT and RIGHT JOIN.
- [ ] I can write scalar and multi-row subqueries.
- [ ] I understand EXISTS and correlated subqueries.
- [ ] I can write a CTE.
- [ ] I can complete the College Placement mini project.

## 13. What to learn next

After completing these lessons, continue with:

1. SQL functions: string, numeric, date and NULL-handling functions.
2. Constraints and relationships in greater depth.
3. Views and indexes.
4. Transactions, COMMIT, ROLLBACK and ACID properties.
5. Window functions: ROW_NUMBER, RANK, DENSE_RANK, LAG and LEAD.
6. Stored procedures, functions and triggers.
7. Query optimization and EXPLAIN.
8. Database normalization and schema design.
9. More complex real-world projects.

## 14. Final note

The purpose of this course is to build a strong SQL foundation. Do not only read the examples: type each query, run it, change the values and observe the result. Consistent practice is the best way to become confident with SQL.
