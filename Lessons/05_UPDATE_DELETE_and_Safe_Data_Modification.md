# Lesson 05: UPDATE, DELETE and Safe Data Modification

## 1. Learning objectives

- Change existing table values with `UPDATE`.
- Modify one or more columns.
- Delete selected records with `DELETE`.
- Understand why a WHERE condition matters.
- Preview the affected rows before changing data.

## 2. UPDATE: change existing data

Syntax:

```sql
UPDATE table_name
SET column_name = new_value
WHERE condition;
```

Example: update Karthik's marks.

```sql
UPDATE Students
SET marks = 85
WHERE student_name = 'Karthik';
```

The `WHERE` condition identifies which row should change.

## 3. Update more than one column

```sql
UPDATE Students
SET department = 'CSE',
    marks = marks + 3
WHERE student_name = 'Karthik';
```

You can use expressions based on the current value:

```sql
UPDATE Students
SET marks = marks + 5
WHERE department = 'CSE';
```

## 4. Update placement information

```sql
UPDATE Placement
SET status = 'Selected'
WHERE status = 'Pending';
```

Increase packages below 7 LPA by 10%:

```sql
UPDATE Placement
SET package_lpa = ROUND(package_lpa * 1.10, 2)
WHERE package_lpa < 7;
```

## 5. Preview before UPDATE

A safe workflow:

```sql
-- Step 1: inspect the rows
SELECT *
FROM Students
WHERE department = 'CSE';

-- Step 2: update only after checking the result
UPDATE Students
SET marks = marks + 5
WHERE department = 'CSE';

-- Step 3: verify the change
SELECT *
FROM Students
WHERE department = 'CSE';
```

## 6. DELETE: remove rows

Syntax:

```sql
DELETE FROM table_name
WHERE condition;
```

Delete the student with ID 105:

```sql
DELETE FROM Students
WHERE student_id = 105;
```

Delete students whose marks are below 60:

```sql
DELETE FROM Students
WHERE marks < 60;
```

Delete rejected placements below 6 LPA:

```sql
DELETE FROM Placement
WHERE status = 'Rejected'
  AND package_lpa < 6;
```

## 7. Important: DELETE without WHERE

```sql
DELETE FROM Students;
```

This deletes every row in the table. The table structure remains.

Never run a DELETE statement until you have checked which rows its condition matches.

## 8. DELETE vs DROP vs TRUNCATE

| Command | What it does |
|---|---|
| `DELETE` | Removes rows; can target rows with WHERE |
| `TRUNCATE TABLE` | Removes all rows from a table |
| `DROP TABLE` | Removes the table structure and its data |

These commands have different effects and transaction behavior depending on the database engine. Treat them as destructive operations.

## 9. Use a transaction for practice

In MySQL, transactions can help you review a change before committing it when the table uses a transactional storage engine such as InnoDB.

```sql
START TRANSACTION;

UPDATE Students
SET marks = marks + 1
WHERE student_id = 101;

SELECT *
FROM Students
WHERE student_id = 101;

-- If the result is correct:
COMMIT;

-- If you want to cancel instead, use ROLLBACK
-- ROLLBACK;
```

Run either `COMMIT` or `ROLLBACK` as appropriate. Do not run both expecting the same change to be undone.

## 10. Safe modification checklist

Before UPDATE or DELETE:

1. Confirm the correct database using `SELECT DATABASE();`.
2. Write the intended `WHERE` condition.
3. Run a SELECT with the same condition.
4. Check the returned rows.
5. Execute the modification.
6. Verify the result.
7. Use a transaction where appropriate.

## 11. Practice questions

1. Change Arjun's marks to 90.
2. Increase every IT student's marks by 2.
3. Change a student's department using their student ID.
4. Increase packages below 8 LPA by 5%.
5. Delete one student using their ID.
6. Delete students whose marks are below 40.
7. Write a SELECT query to preview the rows before each modification.

## 12. Common mistakes

- Forgetting `WHERE` in UPDATE or DELETE.
- Using a name that is not unique to identify a row.
- Writing a text value without quotes.
- Expecting DELETE to remove the table itself.
- Forgetting to verify a change.

## 13. Lesson recap

- `UPDATE` changes existing values.
- `SET` specifies the new value.
- `DELETE` removes rows.
- `WHERE` controls which rows are affected.
- Previewing rows first is an important professional habit.

**Next lesson:** Calculate counts, averages, minimums, maximums and totals.
