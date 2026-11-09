# Lesson 07: HAVING, CASE and Conditional Queries

## 1. Learning objectives

- Understand the difference between WHERE and HAVING.
- Filter groups after aggregation.
- Use multiple HAVING conditions.
- Create labels using CASE.
- Build simple business-style classifications.

## 2. WHERE vs HAVING

Both clauses filter query results, but they are used at different stages.

| WHERE | HAVING |
|---|---|
| Filters individual rows | Filters groups |
| Used before grouping | Used after GROUP BY |
| Commonly filters normal column values | Commonly filters aggregate results |

### Simple flow

```text
Rows from table
      |
      v
WHERE filters rows
      |
      v
GROUP BY creates groups
      |
      v
Aggregate functions calculate summaries
      |
      v
HAVING filters groups
      |
      v
Final result
```

## 3. HAVING: filter groups

Find departments with an average mark above 80:

```sql
SELECT department,
       ROUND(AVG(marks), 2) AS avg_marks
FROM Students
GROUP BY department
HAVING AVG(marks) > 80;
```

Find departments with more than one student:

```sql
SELECT department, COUNT(*) AS student_count
FROM Students
GROUP BY department
HAVING COUNT(*) > 1;
```

## 4. Multiple HAVING conditions

Find departments with more than one student and average marks above 80:

```sql
SELECT department,
       COUNT(*) AS student_count,
       ROUND(AVG(marks), 2) AS avg_marks
FROM Students
GROUP BY department
HAVING COUNT(*) > 1
   AND AVG(marks) > 80;
```

You can combine `COUNT`, `AVG`, `MIN` and `MAX` conditions in HAVING.

## 5. WHERE and HAVING together

Find departments whose students have marks above 70, and whose average of those qualifying marks is above 80:

```sql
SELECT department,
       COUNT(*) AS qualifying_students,
       AVG(marks) AS average_marks
FROM Students
WHERE marks > 70
GROUP BY department
HAVING AVG(marks) > 80;
```

The WHERE clause first removes rows with marks of 70 or below. The GROUP BY then groups the remaining rows. HAVING filters those groups.

## 6. CASE: conditional output

`CASE` returns a value based on conditions. It is similar to if/elif/else logic in programming.

General syntax:

```sql
CASE
    WHEN condition_1 THEN result_1
    WHEN condition_2 THEN result_2
    ELSE default_result
END
```

### Example: student result category

```sql
SELECT student_name, marks,
       CASE
           WHEN marks >= 85 THEN 'Excellent'
           WHEN marks >= 75 THEN 'Good'
           ELSE 'Needs Improvement'
       END AS result
FROM Students;
```

The conditions are checked from top to bottom. Once a condition matches, its result is returned.

## 7. CASE with multiple categories

```sql
SELECT student_name, marks,
       CASE
           WHEN marks >= 90 THEN 'Topper'
           WHEN marks >= 80 THEN 'Above Average'
           WHEN marks >= 70 THEN 'Average'
           ELSE 'Below Average'
       END AS performance
FROM Students;
```

Place higher thresholds first. If `marks >= 70` came first, a student with 95 marks would match that condition and never reach the Topper condition.

## 8. CASE for placement packages

```sql
SELECT company_name, package_lpa,
       CASE
           WHEN package_lpa >= 10 THEN 'High'
           WHEN package_lpa >= 7 THEN 'Medium'
           ELSE 'Low'
       END AS package_category
FROM Placement;
```

## 9. CASE with more than one condition

```sql
SELECT company_name, package_lpa, status,
       CASE
           WHEN status = 'Selected' AND package_lpa >= 7
               THEN 'Good package'
           WHEN status = 'Selected' AND package_lpa < 7
               THEN 'Low package'
           ELSE 'Not selected'
       END AS placement_result
FROM Placement;
```

## 10. Practice questions

1. Find departments with average marks above 85.
2. Find departments with more than two students.
3. Find departments with more than one student and average marks above 80.
4. Classify marks as Excellent, Good or Needs Improvement.
5. Classify marks as Topper, Above Average, Average or Below Average.
6. Classify placement packages as High, Medium or Low.
7. Display `Eligible` when marks are at least 85 and age is at most 22; otherwise display `Not Eligible`.
8. Use WHERE and HAVING in the same query.

## 11. Common mistakes

- Using WHERE with an aggregate condition such as `AVG(marks) > 80`.
- Forgetting GROUP BY when selecting a department with an aggregate.
- Putting CASE conditions in the wrong order.
- Forgetting `END`.
- Forgetting to give a readable alias to a calculated result.

## 12. Lesson recap

- WHERE filters rows.
- GROUP BY creates groups.
- HAVING filters groups.
- CASE returns conditional values.
- Multiple conditions can be combined using AND and OR.

**Next lesson:** Combine related tables using JOIN.
