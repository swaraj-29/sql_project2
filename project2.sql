# library management system project

-- CREATE DATABASE library_project;
create database library_project;

-- Create table "Branch"

drop table if exists branch;
create table branch(
branch_id varchar(15) primary key,
manager_id	varchar(10),
branch_address	varchar(50),
contact_no varchar(20)
);
select * from branch;
use library_project;
show tables;

-- Create table "Employee"

drop table if exists employees;
CREATE TABLE employees(
emp_id	varchar(15) primary key,
emp_name	varchar(30),
position varchar(20),
salary	int,
branch_id varchar(10)
);

-- Create table "books"
create table books(
isbn varchar(25) primary key,
book_title	varchar(60),
category	varchar (20),
rental_price	float,
status	varchar(10),
author	varchar(35),
publisher varchar(45)
);

-- Create table "members"
create table members(
member_id	varchar(10) primary key,
member_name	varchar(18),
member_address	varchar(30),
reg_date date
);

-- Create table "return_status"
create table return_status(
return_id varchar(10) primary key,	
issued_id	varchar(10),
return_book_name varchar(70),
return_date	date,
return_book_isbn varchar(30));

-- Create table "issued_status"

create table issued_status(
issued_id	varchar(10) primary key,
issued_member_id varchar(10),	
issued_book_name varchar (75),	
issued_date	date,
issued_book_isbn varchar(35),	
issued_emp_id varchar(10)
);

ALTER TABLE issued_status
add constraint fk_members
foreign key (issued_member_id)
references members(member_id);

ALTER TABLE issued_status
add constraint books_isbn
foreign key (issued_book_isbn)
references books(isbn);

ALTER TABLE issued_status
add constraint fk_empid
foreign key (issued_emp_id)
references employees(emp_id);

ALTER TABLE return_status
add constraint fk_issueid
foreign key (issued_id)
references issued_status(issued_id);

ALTER TABLE employees
add constraint fk_branchid
foreign key (branch_id)
references branch(branch_id);

INSERT INTO return_status(return_id, issued_id, return_date) 
VALUES
('RS104', 'IS106', '2024-05-01'),
('RS105', 'IS107', '2024-05-03'),
('RS106', 'IS108', '2024-05-05'),
('RS107', 'IS109', '2024-05-07'),
('RS108', 'IS110', '2024-05-09'),
('RS109', 'IS111', '2024-05-11'),
('RS110', 'IS112', '2024-05-13'),
('RS111', 'IS113', '2024-05-15'),
('RS112', 'IS114', '2024-05-17'),
('RS113', 'IS115', '2024-05-19'),
('RS114', 'IS116', '2024-05-21'),
('RS115', 'IS117', '2024-05-23'),
('RS116', 'IS118', '2024-05-25'),
('RS117', 'IS119', '2024-05-27'),
('RS118', 'IS120', '2024-05-29');


-- Project Task

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books(isbn, book_title, category, rental_price, status, author, publisher)
values('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');


select * from branch;
select * from members;
select * from books;
select * from employees;
select * from issued_status;
select * from return_status;

-- Task 2: Update an Existing Member's Address

update members
set member_address = '125 main area'
where member_id = 'C101';

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

delete from issued_status
where issued_id = 'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

select issued_book_name from issued_status where issued_emp_id = 'E104';


-- Task 5: List Members Who Have Issued More Than two Book -- Objective: Use GROUP BY to find members who have issued more than one book.

select issued_emp_id, 
	   count(issued_id) as Total_number
       from issued_status
       group by 1 
       having Total_number > 2;
       
-- CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
       
create table book_cnt
as
select 
	b.isbn,
	b.book_title,
	count(ist.issued_id) as no_issued
from books as b
join
	issued_status as ist
on ist.issued_book_isbn = b.isbn
group by 1,2;
select * from book_cnt;


-- Task 7. Retrieve All Books in a Specific Category:

select *
from books
where category = 'Classic';

-- Task 8: Find Total Rental Income by Category:
select category , sum(rental_price) as rental_income , count(*)
from books
group by 1
order by 2 desc;

select * from members;

-- List Members Who Registered in the Last 180 Days:
insert into members(member_id,member_name, member_address, reg_date)
values('C120', 'David', 'sydney Garden', '2025-04-10'),
('C121', 'tim', 'washington', '2025-03-25');

select * from members
where reg_date >= curdate() - interval 180 day;

-- task 10 List Employees with Their Branch Manager's Name and their branch details:
select e1.*,b1.manager_id, e2.emp_name as manager_name  from employees as e1
join
branch as b1
on
e1.branch_id = b1.branch_id
join
employees as e2
on b1.manager_id = e2.emp_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:

create table Books_above7
as
(select * from books
where rental_price > 7);


-- Task 12: Retrieve the List of Books Not Yet Returned
select isu.issued_book_name from issued_status as isu
left join
return_status as rs
on
isu.issued_id = rs.issued_id
where rs.return_id is null;


INSERT INTO issued_status(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id)
VALUES
('IS151', 'C118', 'The Catcher in the Rye', CURRENT_DATE - INTERVAL 24 day ,  '978-0-553-29698-2', 'E108'),
('IS152', 'C119', 'The Catcher in the Rye', CURRENT_DATE - INTERVAL 13 day ,  '978-0-553-29698-2', 'E109'),
('IS153', 'C106', 'Pride and Prejudice', CURRENT_DATE - INTERVAL 7 day,  '978-0-14-143951-8', 'E107'),
('IS154', 'C105', 'The Road', CURRENT_DATE - INTERVAL 32 day,  '978-0-375-50167-0', 'E101');

-- Adding new column in return_status

ALTER TABLE return_status
ADD Column book_quality VARCHAR(15) DEFAULT('Good');

UPDATE return_status
SET book_quality = 'Damaged'
WHERE issued_id 
    IN ('IS112', 'IS117', 'IS118');
    
    
SELECT * FROM return_status;
select * from issued_status;
select * from books;
select * from branch;
select * from members;
select * from employees;

/*
Task 13: 
Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue.
*/

select 
m.member_id, 
m.member_name, 
ist.issued_book_name as Book, 
ist.issued_date,
DATEDIFF(curdate() , ist.issued_date) as overdue_days
from members as m
join
issued_status as ist
on
m.member_id = ist.issued_member_id
left join 
return_status as rt
on
rt.issued_id = ist.issued_id

where rt.return_date is null
and DATEDIFF(curdate() , ist.issued_date) > 30
order by 1;

-- 
/*    
Task 14: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
*/

DELIMITER $$

CREATE PROCEDURE add_return_records(
    IN p_return_id VARCHAR(20),
    IN p_issued_id VARCHAR(20),
    IN p_book_quality VARCHAR(15)
)
BEGIN
    DECLARE v_isbn VARCHAR(50);
    DECLARE v_book_name VARCHAR(80);

    -- Insert return record
    INSERT INTO return_status (return_id, issued_id, return_date, book_quality)
    VALUES (p_return_id, p_issued_id, CURRENT_DATE(), p_book_quality);

    -- Fetch the ISBN and Book Title based on issued_id
    SELECT issued_book_isbn, issued_book_name
    INTO v_isbn, v_book_name
    FROM issued_status
    WHERE issued_id = p_issued_id;

    -- Update book status to available
    UPDATE books
    SET status = 'yes'
    WHERE isbn = v_isbn;

    -- Display message
    SELECT CONCAT('Thank you for returning the book: ', v_book_name) AS message;
END$$

DELIMITER ;

CALL add_return_records('RS213', 'IS140', 'Good');

update books
set status = 'no'
where isbn = '978-0-330-25864-8';

SELECT * FROM return_status;
select * from issued_status;
select * from books;
select * from branch;
select * from members;
select * from employees;

/*
Task 15: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
*/

create table branch_reports
as
select b.branch_id, b.manager_id, count(ist.issued_id) as number_issued_books, count(rs.return_id) as returned_book_count, sum(bk.rental_price) as total_revenue
from issued_status as ist
join
employees as ep
on ep.emp_id = ist.issued_emp_id
join branch as b
on
b.branch_id = ep.branch_id
left join return_status as rs
on rs.issued_id = ist.issued_id
join books as bk
on ist.issued_book_isbn = bk.isbn
group by 1, 2;

select * from branch_reports;

-- Task 16: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.

create table active_mambers
as
select distinct m.member_id, m.member_name, ist.issued_id , ist.issued_date as last_issued_date
from members as m
join issued_status as ist
on
m.member_id = ist.issued_member_id
where issued_date > curdate() - interval 6 month;

-- 
-- Task 17: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.


select ep.emp_name , count(ist.issued_emp_id), ep.branch_id
from issued_status as ist
join employees as ep
on ist.issued_emp_id = ep.emp_id
group by 1,3
order by 2 desc
limit 3;

/*
Task 19: Stored Procedure Objective: 

Create a stored procedure to manage the status of books in a library system. 

Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 

The procedure should function as follows: 

The stored procedure should take the book_id as an input parameter. 

The procedure should first check if the book is available (status = 'yes'). 

If the book is available, it should be issued, and the status in the books table should be updated to 'no'. 

If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
*/

delimiter $$

create procedure 
book_availibity_record( 
in p_issued_id varchar(10),
in p_issued_member_id varchar(10),
in p_issued_book_isbn varchar(25), 
in p_issued_emp_id varchar(10)
)
begin
	declare v_status varchar(10);
    select status into v_status
    from books
    where isbn = p_issued_book_isbn;
    
    if v_status = 'yes' then
		insert into issued_status ( issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
        values (p_issued_id , p_issued_member_id, curdate(), p_issued_book_isbn, p_issued_emp_id);
        
		update books
		set status = 'no'
		where isbn = p_issued_book_isbn;
		SELECT CONCAT('Book records added successfully for book isbn: ', p_issued_book_isbn) AS message;
    else
		select concat('sorry this book is not available right now: ', p_issued_book_isbn) as message;
    end if;
end $$
delimiter ;

call book_availibity_record('IS160', 'C125', '978-0-14-143951-8', 'E105'); 