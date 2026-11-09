# Lesson 08: SQL JOINs

## 1. Learning objectives

- Understand why databases use multiple related tables.
- Understand table aliases and join conditions.
- Use INNER JOIN, LEFT JOIN and RIGHT JOIN.
- Join three tables.
- Calculate grouped results from joined tables.

## 2. Why do we need JOIN?

A college database stores different types of information in different tables.

### Students

| student_id | student_name | department |
|---:|---|---|
| 101 | Arjun | CSE |
| 102 | Priya | ECE |
| 103 | Rahul | CSE |

### Placement

| placement_id | student_id | company_name | package_lpa |
|---:|---:|---|---:|
| 1 | 101 | TCS | 6.50 |
| 2 | 102 | Infosys | 7.25 |

The common `student_id` connects a student to their placement record.

## 3. What is a JOIN?

A JOIN combines rows from two or more tables using a related column or condition.

```text
Students table                 Placement table
+------------+                 +------------+
| student_id |                 | student_id |
| name       |                 | company    |
+------------+                 +------------+
       |                              |
       +---------- matching ----------+
                      |
                      v
              Combined result
```

## 4. Table aliases

Aliases make queries shorter:

```sql
SELECT s.student_name, p.company_name
FROM Students AS s
INNER JOIN Placement AS p
    ON s.student_id = p.student_id;
```

- `s` represents Students.
- `p` represents Placement.
- `ON` specifies how the rows match.

## 5. INNER JOIN

Returns only rows with matching values in both tables.

```sql
SELECT s.student_name, p.company_name, p.package_lpa
FROM Students AS s
INNER JOIN Placement AS p
    ON s.student_id = p.student_id;
```

### Conceptual diagram

```text
Students       Placement
   (all)          (all)
       \          /
        \ MATCH  /
         \      /
          INNER
          JOIN
            |
      matching rows
```

A student without a placement record will not appear in this result.

## 6. LEFT JOIN

Returns every row from the left table and matching rows from the right table. If there is no match, right-side columns are `NULL`.

```sql
SELECT s.student_name, p.company_name, p.package_lpa
FROM Students AS s
LEFT JOIN Placement AS p
    ON s.student_id = p.student_id;
```

Use LEFT JOIN when you want every student, including students who have not been placed.

## 7. RIGHT JOIN

Returns every row from the right table and matching rows from the left table.

```sql
SELECT s.student_name, p.company_name, p.package_lpa
FROM Students AS s
RIGHT JOIN Placement AS p
    ON s.student_id = p.student_id;
```

Use it when every placement record must appear. In many cases, the same result can be written by reversing the table order and using LEFT JOIN.

## 8. JOIN three tables

The course contains three tables:

- Students
- Department
- Placement

```sql
SELECT
    s.student_name,
    d.department_name,
    p.company_name,
    p.package_lpa
FROM Students AS s
INNER JOIN Department AS d
    ON s.department = d.department_name
INNER JOIN Placement AS p
    ON s.student_id = p.student_id;
```

This query returns students that have matching department and placement rows.

## 9. JOIN with aggregate functions

Find the average placement package for each department:

```sql
SELECT
    s.department,
    ROUND(AVG(p.package_lpa), 2) AS avg_package
FROM Students AS s
INNER JOIN Placement AS p
    ON s.student_id = p.student_id
GROUP BY s.department;
```

Find departments whose average placement package is above 7 LPA:

```sql
SELECT
    s.department,
    ROUND(AVG(p.package_lpa), 2) AS avg_package
FROM Students AS s
INNER JOIN Placement AS p
    ON s.student_id = p.student_id
GROUP BY s.department
HAVING AVG(p.package_lpa) > 7;
```

## 10. Important JOIN concepts

- Use qualified column names such as `s.student_id` when more than one table contains the same column name.
- Make sure the `ON` condition represents the correct relationship.
- A missing or incorrect join condition can create a large, unintended result.
- A student may have multiple placement records; in that case, the student can appear multiple times.
- NULL values in unmatched rows are expected in outer joins.

## 11. Practice questions

1. Display student names and their company names using INNER JOIN.
2. Display every student and any available placement details using LEFT JOIN.
3. Display every placement and matching student using RIGHT JOIN.
4. Join Students, Department and Placement.
5. Find the average package by department.
6. Find the highest package by department.
7. Find departments with an average package above 7 LPA.
8. Find departments with more than one placement record.

## 12. Common mistakes

- Forgetting the ON clause.
- Joining unrelated columns.
- Using an ambiguous column name without a table alias.
- Assuming LEFT JOIN removes unmatched left-side rows.
- Accidentally multiplying rows when a relationship has multiple matches.

## 13. Lesson recap

- JOIN combines related tables.
- INNER JOIN returns matching rows.
- LEFT JOIN preserves every left-table row.
- RIGHT JOIN preserves every right-table row.
- ON defines the matching condition.
- JOIN can be combined with GROUP BY and HAVING.

**Next lesson:** Use a query inside another query with subqueries.
