# Lesson 01: SQL Introduction, Installation and MySQL Workbench Setup

## 1. Learning objectives

By the end of this lesson, you should be able to:

- Explain what data and databases are.
- Understand SQL and a relational database.
- Distinguish MySQL Server from MySQL Workbench.
- Install MySQL on a computer.
- Connect to a local MySQL server using Workbench.
- Create and run your first SQL query.

## 2. What is data?

Data is a collection of facts. Examples include a student's name, age, department, marks, a product price or an employee's salary.

| Student ID | Student name | Department | Marks |
|---:|---|---|---:|
| 101 | Arjun | CSE | 87.50 |
| 102 | Priya | ECE | 91.25 |
| 103 | Rahul | CSE | 78.50 |

A database stores data in an organized way so that it can be searched, inserted, updated and deleted.

## 3. What is a database?

A database is an organized collection of related information. A college may store students, departments, attendance, fees and placement information in a database.

### Simple database structure

```text
College database
       |
       +-- Students table
       |      +-- student_id
       |      +-- student_name
       |      +-- department
       |      +-- marks
       |
       +-- Department table
       |      +-- department_id
       |      +-- department_name
       |
       +-- Placement table
              +-- placement_id
              +-- student_id
              +-- company_name
              +-- package_lpa
```

## 4. What is SQL?

SQL stands for **Structured Query Language**. It is used to communicate with relational database systems.

Common SQL tasks:

| Task | SQL command |
|---|---|
| Create a database | `CREATE DATABASE` |
| Create a table | `CREATE TABLE` |
| Add records | `INSERT` |
| Read records | `SELECT` |
| Change records | `UPDATE` |
| Remove records | `DELETE` |

SQL is a language. MySQL is a database management system that understands SQL.

## 5. What is a relational database?

A relational database stores data in tables. A table contains columns and rows.

- **Table:** a collection of related records.
- **Column:** one property, such as student name.
- **Row:** one complete record.
- **Primary key:** a column (or group of columns) that uniquely identifies each row.
- **Relationship:** a connection between tables, often made using keys.

## 6. MySQL Server vs MySQL Workbench

| MySQL Server | MySQL Workbench |
|---|---|
| Stores and manages the database | Graphical application used to work with MySQL |
| Executes SQL statements | Lets you type and run SQL statements |
| Runs as a service/process | Connects to a MySQL Server |
| Required for a local MySQL database | Convenient graphical interface |

**Important:** Installing Workbench alone does not necessarily install or start the database server. You need a running MySQL Server to execute queries against a local database.

## 7. Install MySQL on Windows

Use the official MySQL website:

- MySQL Community Server: https://dev.mysql.com/downloads/mysql/
- MySQL Installer for Windows: https://dev.mysql.com/downloads/installer/
- MySQL Workbench: https://dev.mysql.com/downloads/workbench/

The exact installer screens can change between releases. Follow the current installer instructions.

### Installation steps

1. Open the official MySQL downloads page.
2. Download the MySQL Installer for Windows, if available for your Windows version.
3. Run the installer as a normal application.
4. Select a setup type that includes **MySQL Server** and **MySQL Workbench**. If using separate installers, install both.
5. Follow the configuration wizard.
6. Choose a server port. The common default is `3306`.
7. Set a strong password for the MySQL `root` account and keep it private.
8. Configure MySQL as a Windows service if the installer offers that option.
9. Finish the installation.
10. Open MySQL Workbench.

For macOS or Linux, use the installation instructions on the official MySQL download page for that operating system.

## 8. Connect using MySQL Workbench

1. Open MySQL Workbench.
2. Find the MySQL Connections section.
3. Select the local connection created during installation, or create a new connection.
4. Use `127.0.0.1` or `localhost` as the hostname for a local server.
5. Use port `3306`, unless you selected another port.
6. Enter the username configured during installation, commonly `root`.
7. Click **Test Connection**.
8. Enter your password when prompted.
9. Save the connection only if this is your own trusted computer.

### Connection diagram

```text
You
 |
 v
MySQL Workbench
 |
 | SQL query over local connection
 v
MySQL Server (localhost:3306)
 |
 v
Database and tables
```

Workbench is the client; MySQL Server is the database engine.

## 9. Your first SQL query

Open a SQL tab in Workbench and run:

```sql
SELECT 'Hello, SQL!' AS message;
```

Expected result:

| message |
|---|
| Hello, SQL! |

Try another query:

```sql
SELECT 10 + 20 AS total;
```

Expected result: `30`.

## 10. Useful Workbench controls

- **SQL Editor:** where you write queries.
- **Execute button:** runs the selected query or statement.
- **Schemas panel:** lists databases and their tables.
- **Result Grid:** displays rows returned by a `SELECT`.
- **Action Output:** shows execution messages and errors.
- **Refresh icon:** refreshes the schema list.

You can usually execute the current statement with the lightning-bolt button. Keyboard shortcuts can vary by operating system and Workbench version.

## 11. First practice

Run these queries:

```sql
SELECT 100 AS first_number;
SELECT 50 + 25 AS addition_result;
SELECT 'MySQL Workbench' AS tool_name;
SELECT 100 - 40 AS subtraction_result;
```

### Check your understanding

1. What does SQL stand for?
2. What is the difference between MySQL Server and Workbench?
3. What is the common MySQL port?
4. What is a row?
5. Can Workbench execute a query if no MySQL Server is available to connect to?

## 12. Lesson recap

- A database organizes related data.
- A relational database stores data in tables.
- SQL is used to work with relational databases.
- MySQL Server stores and processes database operations.
- MySQL Workbench is a graphical client for connecting to MySQL.
- The first step after installation is to test the connection.

**Next lesson:** Create a database and tables, and learn data types and constraints.
