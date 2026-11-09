# Lesson 06: Aggregate Functions and GROUP BY

## 1. Learning objectives

- Understand aggregate functions.
- Use `COUNT`, `SUM`, `AVG`, `MIN` and `MAX`.
- Group rows with `GROUP BY`.
- Calculate department-wise results.

## 2. What is an aggregate function?

An aggregate function takes values from multiple rows and returns a summary value.

Imagine these marks:

| Student | Department | Marks |
|---|---|---:|
| Arjun | CSE | 87.50 |
| Rahul | CSE | 78.50 |
| Priya | ECE | 91.25 |
| Meena | IT | 88.75 |

## 3. COUNT: count rows or non-NULL values

Count every row:

```sql
SELECT COUNT(*) AS student_count
FROM Students;
```

Count non-NULL marks:

```sql
SELECT COUNT(marks) AS students_with_marks
FROM Students;
```

`COUNT(*)` counts rows. `COUNT(column)` counts non-NULL values in that column.

## 4. SUM: calculate a total

```sql
SELECT SUM(marks) AS total_marks
FROM Students;
```

## 5. AVG: calculate an average

```sql
SELECT ROUND(AVG(marks), 2) AS average_marks
FROM Students;
```

`AVG` ignores NULL values. `ROUND(value, 2)` rounds the result to two decimal places.

## 6. MAX and MIN

Highest marks:

```sql
SELECT MAX(marks) AS highest_marks
FROM Students;
```

Lowest marks:

```sql
SELECT MIN(marks) AS lowest_marks
FROM Students;
```

## 7. GROUP BY: calculate summaries for each group

Without `GROUP BY`, an aggregate normally summarizes the whole selected set.

With `GROUP BY`, MySQL creates a group for each distinct department and calculates a result for each group.

```sql
SELECT department, COUNT(*) AS student_count
FROM Students
GROUP BY department;
```

### Grouping illustration

```text
Students
   |
   +---- CSE rows ----> COUNT / AVG / MAX
   |
   +---- ECE rows ----> COUNT / AVG / MAX
   |
   +---- IT rows -----> COUNT / AVG / MAX
   |
   +---- MECH rows ---> COUNT / AVG / MAX
```

Example result:

| department | student_count |
|---|---:|
| CSE | 2 |
| ECE | 1 |
| IT | 1 |
| MECH | 1 |

The exact counts depend on the rows currently in your table.

## 8. Department-wise calculations

Average marks:

```sql
SELECT department, ROUND(AVG(marks), 2) AS average_marks
FROM Students
GROUP BY department;
```

Highest marks:

```sql
SELECT department, MAX(marks) AS highest_marks
FROM Students
GROUP BY department;
```

Total marks:

```sql
SELECT department, SUM(marks) AS total_marks
FROM Students
GROUP BY department;
```

Count students:

```sql
SELECT department, COUNT(*) AS student_count
FROM Students
GROUP BY department;
```

## 9. Group by more than one column

```sql
SELECT department, age, COUNT(*) AS student_count
FROM Students
GROUP BY department, age;
```

This creates a group for each unique department-and-age combination.

## 10. GROUP BY rules

When using aggregate queries, selected non-aggregated columns should normally appear in the `GROUP BY` clause. MySQL's `ONLY_FULL_GROUP_BY` SQL mode enforces this rule for many queries.

Good:

```sql
SELECT department, AVG(marks)
FROM Students
GROUP BY department;
```

Potentially invalid under `ONLY_FULL_GROUP_BY`:

```sql
SELECT department, student_name, AVG(marks)
FROM Students
GROUP BY department;
```

Why? A department can contain many student names, so MySQL cannot choose one meaningful name for the group.

## 11. Practice questions

1. Count all students.
2. Count students who have marks recorded.
3. Find the average marks.
4. Find the highest marks.
5. Find the lowest marks.
6. Find the total marks.
7. Count students in each department.
8. Find average marks by department.
9. Find the highest marks by department.
10. Find total marks by department.
11. Group students by department and age.

## 12. Common mistakes

- Confusing `COUNT(*)` with `COUNT(column)`.
- Expecting `AVG` to count NULL values.
- Forgetting `GROUP BY`.
- Selecting a normal column that is not grouped or aggregated.
- Assuming the sample output will remain the same after changing data.

## 13. Lesson recap

- `COUNT` counts rows or non-NULL values.
- `SUM` adds values.
- `AVG` calculates the average.
- `MAX` finds the largest value.
- `MIN` finds the smallest value.
- `GROUP BY` calculates summaries for each group.

**Next lesson:** Filter grouped results with HAVING and create conditional output with CASE.
