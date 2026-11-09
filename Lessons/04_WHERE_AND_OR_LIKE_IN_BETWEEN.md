# Lesson 04: WHERE, AND, OR, LIKE, IN and BETWEEN

## 1. Learning objectives

You will learn to:

- Filter rows with `WHERE`.
- Combine conditions using `AND` and `OR`.
- Search text patterns with `LIKE`.
- Match a list of values with `IN` and `NOT IN`.
- Filter numeric or date ranges with `BETWEEN`.

## 2. WHERE: filter rows

`WHERE` returns only rows that satisfy a condition.

```sql
SELECT *
FROM Students
WHERE marks > 80;
```

Common comparison operators:

| Operator | Meaning | Example |
|---|---|---|
| `=` | Equal to | `department = 'CSE'` |
| `!=` | Not equal to | `department != 'CSE'` |
| `<>` | Not equal to | `age <> 21` |
| `>` | Greater than | `marks > 80` |
| `<` | Less than | `marks < 50` |
| `>=` | Greater than or equal | `marks >= 85` |
| `<=` | Less than or equal | `age <= 22` |

## 3. AND: every condition must be true

```sql
SELECT student_name, department, marks
FROM Students
WHERE department = 'CSE'
  AND marks > 80;
```

A row is returned only when it is from CSE **and** its marks are above 80.

## 4. OR: at least one condition must be true

```sql
SELECT *
FROM Students
WHERE department = 'CSE'
   OR marks > 90;
```

A student is returned if either condition is true.

### AND and OR together

Use parentheses to make the intended logic clear:

```sql
SELECT *
FROM Students
WHERE department = 'CSE'
  AND (marks > 80 OR age < 20);
```

## 5. BETWEEN: check an inclusive range

```sql
SELECT student_name, marks
FROM Students
WHERE marks BETWEEN 80 AND 90;
```

`BETWEEN` includes both endpoints: 80 and 90.

Equivalent condition:

```sql
WHERE marks >= 80 AND marks <= 90
```

It can also be used with dates:

```sql
SELECT *
FROM Placement
WHERE placement_date BETWEEN '2026-08-01' AND '2026-08-31';
```

## 6. LIKE: pattern matching

`LIKE` searches text using wildcard characters.

| Pattern | Meaning |
|---|---|
| `'A%'` | Starts with A |
| `'%A'` | Ends with A |
| `'%A%'` | Contains A |
| `'A____'` | Starts with A and has five characters total |
| `'_____'` | Exactly five characters |

Examples:

```sql
-- Names starting with A
SELECT *
FROM Students
WHERE student_name LIKE 'A%';

-- Names ending with a
SELECT *
FROM Students
WHERE student_name LIKE '%a';

-- Names containing the letter a
SELECT *
FROM Students
WHERE student_name LIKE '%a%';

-- Names with exactly five characters
SELECT *
FROM Students
WHERE student_name LIKE '_____';
```

`%` represents zero or more characters. `_` represents exactly one character. Case sensitivity depends on the column collation.

## 7. IN and NOT IN

`IN` checks whether a value matches any value in a list.

```sql
SELECT student_name, department
FROM Students
WHERE department IN ('CSE', 'IT', 'ECE');
```

This is similar to:

```sql
WHERE department = 'CSE'
   OR department = 'IT'
   OR department = 'ECE'
```

`NOT IN` excludes the listed values:

```sql
SELECT student_name, department
FROM Students
WHERE department NOT IN ('CSE', 'IT');
```

Be careful when using `NOT IN` with a subquery that may return `NULL`; `NOT EXISTS` is often safer for that situation.

## 8. Filtering workflow

```text
Students table
      |
      v
WHERE condition
      |
      +-- true  --> include row
      |
      +-- false --> skip row
      |
      v
Filtered result
```

## 9. Practical examples

Find CSE and IT students with marks above 85:

```sql
SELECT student_name, department, marks
FROM Students
WHERE department IN ('CSE', 'IT')
  AND marks > 85;
```

Find students who are not in CSE or IT and have marks above 80:

```sql
SELECT student_name, department, marks
FROM Students
WHERE department NOT IN ('CSE', 'IT')
  AND marks > 80;
```

## 10. Practice questions

1. Find students whose marks are greater than 75.
2. Find CSE students older than 20.
3. Find students from CSE or ECE.
4. Find marks between 70 and 90.
5. Find names beginning with `P`.
6. Find names containing `a`.
7. Find names with exactly five characters.
8. Find students in CSE, IT or ECE.
9. Find students not in MECH.
10. Find placements dated within August 2026.

## 11. Common mistakes

- Using `AND` when the requirement is either condition.
- Forgetting parentheses in complex conditions.
- Thinking `BETWEEN` excludes its endpoints.
- Using `=` with a wildcard instead of `LIKE`.
- Forgetting that `_` matches one character, not any number of characters.

## 12. Lesson recap

- `WHERE` filters rows.
- `AND` requires all conditions to be true.
- `OR` requires at least one condition to be true.
- `BETWEEN` checks an inclusive range.
- `LIKE` searches patterns.
- `IN` and `NOT IN` match or exclude a list.

**Next lesson:** Modify and delete records safely.
