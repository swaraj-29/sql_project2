# sql_project2
# Library Management System – SQL Project
This project implements a Library Management System using MySQL. It simulates real-world library operations like book issuance, return management, tracking overdue books, rental revenue, and employee/branch performance reporting.

# 🗂️ Project Structure
The project consists of SQL scripts to:

Create and manage a relational database schema.

Insert sample data for testing.

Perform various business operations using SQL queries and stored procedures.

Generate analytical reports using CTAS and joins.

# 🏗️ Database Schema
Tables:
branch – Stores information about library branches and managers.

employees – Library staff records linked to branches.

books – Book details including ISBN, author, rental price, and availability.

members – Registered library users.

issued_status – Tracks book issuance by employees to members.

return_status – Tracks book returns and quality.

branch_reports – Aggregated report of performance by branch.

book_cnt, Books_above7, active_mambers – CTAS summary tables.

# ✅ Features Implemented
# 🔨 Setup and Data Insertion
Created all core tables with foreign key relationships.

Inserted test records into all major tables.

# 🔄 CRUD Operations
Add new books and members.

Update member addresses and book statuses.

Delete issued records.

#  📋 Business Queries
List books by category.

Retrieve overdue books (30+ days).

Identify employees who issued the most books.

Generate rental income by category.

#  📦 Reporting & Analysis
Branch Performance Report: Books issued/returned and revenue.

Active Members Table: Members active in the last 6 months.

Books Not Yet Returned.

#  ⚙️ Stored Procedures
add_return_records: Handles book return and status update.

book_availibity_record: Validates and processes book issuance.

#  📌 Sample Tasks
Task	Description
Task 1	Add new book record
Task 5	Identify members who issued more than two books
Task 13	List members with overdue books
Task 15	Generate branch-wise performance report
Task 19	Stored procedure for issuing books if available

#  💡 Key SQL Concepts Used
DDL & DML Operations

Joins (INNER, LEFT)

Aggregate Functions

GROUP BY & HAVING

Stored Procedures with Conditional Logic

Date Functions

Views and CTAS (Create Table As Select)

# 📎 How to Run
Install MySQL or use any SQL-compatible RDBMS.

Execute the SQL script library_project.sql in your SQL console.

Modify/add procedure calls or queries as needed.

🔖 Credits
Project by: Swaraj Gaurav
Tech Stack: MySQL, SQL Procedures, CTAS, Joins, Data Aggregation
