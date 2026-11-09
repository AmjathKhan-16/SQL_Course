# Lesson 03: INSERT, SELECT, DISTINCT and ORDER BY

## 1. Learning objectives

- Insert one row and multiple rows.
- Understand column lists and values.
- Retrieve all or selected columns.
- Rename output columns with aliases.
- Remove duplicate values from query results.
- Sort results.

## 2. INSERT: add records

`INSERT INTO` adds rows to a table.

```sql
INSERT INTO Students
    (student_id, student_name, department, age, marks)
VALUES
    (101, 'Arjun', 'CSE', 21, 87.50);
```

The column list tells MySQL which value belongs in each column.

### Insert multiple rows

```sql
INSERT INTO Students
    (student_id, student_name, department, age, marks)
VALUES
    (102, 'Priya', 'ECE', 22, 91.25),
    (103, 'Rahul', 'CSE', 21, 78.50),
    (104, 'Meena', 'IT', 22, 88.75),
    (105, 'Karthik', 'MECH', 22, NULL);
```

If a column allows `NULL`, you can insert `NULL` explicitly. If a column has a default, you can omit it from the insert column list.

```sql
INSERT INTO Department
    (department_id, department_name, hod_name)
VALUES
    (1, 'CSE', 'Dr. Kumar');
```

Here, `student_count` receives its default value of `0`.

## 3. SELECT: retrieve data

`SELECT` reads data without changing the stored rows.

```sql
SELECT * FROM Students;
```

The `*` means all columns.

Select only the columns you need:

```sql
SELECT student_name, department, marks
FROM Students;
```

### Why avoid SELECT * in larger projects?

Selecting only required columns can make queries clearer and reduce unnecessary data transfer.

## 4. Column aliases

An alias gives a column a temporary display name.

```sql
SELECT
    student_name AS Name,
    marks AS Score
FROM Students;
```

`AS` does not rename the actual table column. It changes the column label in this query's result.

## 5. DISTINCT: remove duplicate results

```sql
SELECT DISTINCT department
FROM Students;
```

Suppose the data is:

| student_name | department |
|---|---|
| Arjun | CSE |
| Priya | ECE |
| Rahul | CSE |
| Meena | IT |

The query returns:

| department |
|---|
| CSE |
| ECE |
| IT |

`DISTINCT` applies to the complete combination of selected columns:

```sql
SELECT DISTINCT department, age
FROM Students;
```

Two rows are duplicates for this query only if both department and age match.

## 6. ORDER BY: sort results

Ascending order:

```sql
SELECT student_name, marks
FROM Students
ORDER BY marks ASC;
```

Descending order:

```sql
SELECT student_name, marks
FROM Students
ORDER BY marks DESC;
```

`ASC` means ascending and is the default. `DESC` means descending.

Sort using more than one column:

```sql
SELECT student_name, department, marks
FROM Students
ORDER BY department ASC, marks DESC;
```

This sorts departments alphabetically, then sorts marks from highest to lowest inside each department.

## 7. Query flow illustration

```text
Stored table
    |
    v
SELECT requested columns
    |
    v
DISTINCT (if specified)
    |
    v
ORDER BY (if specified)
    |
    v
Result displayed in Workbench
```

This is a simplified learning illustration, not the complete SQL logical processing order.

## 8. Combined example

```sql
SELECT DISTINCT department
FROM Students
ORDER BY department ASC;
```

This returns the unique department names in alphabetical order.

## 9. Practice questions

1. Insert one new student named Dinesh into the IT department.
2. Insert two more students using one INSERT statement.
3. Display every column from Students.
4. Display only student name and age.
5. Display marks with the alias `Score`.
6. Find the unique departments.
7. Display students from highest marks to lowest marks.
8. Display unique department-and-age combinations.

## 10. Common mistakes

- Putting text values without single quotes.
- Providing a different number of values from the number of columns.
- Forgetting that `NULL` is not written as `'NULL'`.
- Assuming `DISTINCT department, age` means unique departments only.
- Expecting rows to be sorted without `ORDER BY`.

## 11. Lesson recap

- `INSERT` adds records.
- `SELECT` retrieves records.
- `*` selects all columns.
- `AS` creates an output alias.
- `DISTINCT` removes duplicate result combinations.
- `ORDER BY` sorts the result.

**Next lesson:** Filter rows with WHERE and pattern-matching operators.
