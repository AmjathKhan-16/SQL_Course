# Lesson 09: SQL Subqueries

## 1. Learning objectives

- Understand a subquery.
- Use scalar subqueries.
- Use IN with a subquery.
- Understand ALL.
- Use correlated subqueries as an additional concept.
- Recognize when EXISTS can be useful.

## 2. What is a subquery?

A subquery is a SQL query placed inside another SQL statement.

```text
Outer query
    |
    +---- uses result from ----> Inner query (subquery)
                                      |
                                      v
                                returns a value
```

The inner query is evaluated as part of the outer query. Depending on the query, it may return one value, one column with multiple rows, or a table-like result.

## 3. Scalar subquery

A scalar subquery returns one value.

Find students whose marks are above the overall average:

```sql
SELECT student_name, marks
FROM Students
WHERE marks > (
    SELECT AVG(marks)
    FROM Students
);
```

The inner query calculates the average mark. The outer query finds students whose marks are greater than that value.

## 4. Subquery with MAX and MIN

Find the student or students with the highest marks:

```sql
SELECT student_name, marks
FROM Students
WHERE marks = (
    SELECT MAX(marks)
    FROM Students
);
```

Find the student or students with the lowest marks:

```sql
SELECT student_name, marks
FROM Students
WHERE marks = (
    SELECT MIN(marks)
    FROM Students
);
```

If multiple students share the same highest or lowest mark, all matching students are returned.

## 5. Find the second-highest distinct mark

```sql
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
```

The innermost query finds the highest mark. The middle query finds the highest mark below that value. The outer query finds the student or students with that second-highest distinct mark.

If there is no second distinct mark, the query returns no rows.

## 6. IN with a subquery

Find students who belong to departments whose average marks are above 85:

```sql
SELECT student_name, department, marks
FROM Students
WHERE department IN (
    SELECT department
    FROM Students
    GROUP BY department
    HAVING AVG(marks) > 85
);
```

The inner query returns department names. The outer query returns students whose department is in that result.

## 7. Compare with a particular student's value

Find students whose marks are greater than Rahul's marks:

```sql
SELECT student_name, marks
FROM Students
WHERE marks > (
    SELECT marks
    FROM Students
    WHERE student_name = 'Rahul'
);
```

This assumes the inner query returns one row. If more than one student has the name Rahul, the scalar subquery may fail with a multiple-row error. Prefer a unique student ID for reliable queries.

## 8. ALL operator

`> ALL` means the value must be greater than every value returned by the subquery.

Find students whose marks are greater than every CSE student's marks:

```sql
SELECT student_name, department, marks
FROM Students
WHERE marks > ALL (
    SELECT marks
    FROM Students
    WHERE department = 'CSE'
);
```

Compare:
- `> ALL (...)`: greater than every returned value.
- `> ANY (...)`: greater than at least one returned value.

If the subquery returns no rows, ALL and ANY follow SQL's empty-set rules; understand this before relying on edge cases.

## 9. Correlated subquery

A correlated subquery refers to a column from the outer query.

Find students whose marks are above their own department's average:

```sql
SELECT s.student_name, s.department, s.marks
FROM Students AS s
WHERE s.marks > (
    SELECT AVG(s2.marks)
    FROM Students AS s2
    WHERE s2.department = s.department
);
```

The inner query calculates an average for the department of the current outer row.

## 10. EXISTS

`EXISTS` checks whether a subquery returns at least one row.

Find students who have at least one placement record:

```sql
SELECT s.student_id, s.student_name
FROM Students AS s
WHERE EXISTS (
    SELECT 1
    FROM Placement AS p
    WHERE p.student_id = s.student_id
);
```

Find students who do not have a placement record:

```sql
SELECT s.student_id, s.student_name
FROM Students AS s
WHERE NOT EXISTS (
    SELECT 1
    FROM Placement AS p
    WHERE p.student_id = s.student_id
);
```

EXISTS is especially useful for checking whether related records are present.

## 11. Common subquery patterns

| Requirement | Useful pattern |
|---|---|
| Compare with one calculated value | Scalar subquery |
| Match one of many returned values | `IN (subquery)` |
| Compare against every returned value | `ALL` |
| Check whether related rows exist | `EXISTS` |
| Compare each row with its group | Correlated subquery |

## 12. Practice questions

1. Find students whose marks are above the overall average.
2. Find the student or students with the highest marks.
3. Find the second-highest distinct mark.
4. Find students whose age is above the average age.
5. Find students in the same department as Arjun.
6. Find students who belong to a department containing someone with marks above 90.
7. Find students whose marks are greater than every CSE student's marks.
8. Find companies offering the highest package.
9. Find students with a Selected placement.
10. Find students without any placement record using NOT EXISTS.

## 13. Common mistakes

- Using `=` when a subquery returns multiple rows.
- Forgetting that a scalar subquery must return at most one row.
- Comparing unrelated columns.
- Forgetting to connect a correlated subquery to the outer query.
- Misunderstanding the difference between ALL, ANY and EXISTS.

## 14. Lesson recap

- A subquery is a query inside another query.
- Scalar subqueries return one value.
- IN compares against a list of returned values.
- ALL compares against every returned value.
- Correlated subqueries refer to the outer query.
- EXISTS checks whether matching rows exist.

**Next lesson:** Simplify multi-step queries using CTEs and complete the mini project.
