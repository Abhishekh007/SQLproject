CREATE DATABASE IF NOT EXISTS banking_db;
USE banking_db;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    city VARCHAR(50)
);
CREATE TABLE accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(10,2),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
INSERT INTO customers (name, city) VALUES('Janani', 'Chennai'),('Arun', 'Coimbatore'),('Priya', 'Madurai'),('Karthik', 'Salem');
INSERT INTO accounts(customer_id, account_type, balance) VALUES(1, 'Savings', 50000),(1, 'Current', 20000),(2, 'Savings', 30000),(3, 'Savings', 15000),(4, 'Current', 40000);
SELECT * FROM customers;
SELECT * FROM accounts;
-- 1. Accounts with balance greater than 20000
SELECT * FROM accounts
WHERE balance > 20000;
-- 2. Customers who live in Chennai
SELECT * FROM customers
WHERE city = 'Chennai';
-- 3. Accounts with balance between 20000 and 50000
SELECT * FROM accounts
WHERE balance BETWEEN 20000 AND 50000;
-- 4. Customers whose names start with J
SELECT * FROM customers
WHERE name LIKE 'J%';
-- 5. Accounts of type Savings or Current
SELECT * FROM accounts
WHERE account_type IN ('Savings', 'Current');
-- 6. Accounts that are not Savings
SELECT * FROM accounts
WHERE account_type <> 'Savings';
-- 7. Customers whose names contain the letter a
SELECT * FROM customers
WHERE name LIKE '%a%';
-- 8. Accounts with balance less than or equal to 30000
SELECT * FROM accounts
WHERE balance <= 30000;
-- 9. Customers who are not from Madurai
SELECT * FROM customers
WHERE city <> 'Madurai';
-- 10. Accounts with balance outside 10000 to 40000
SELECT * FROM accounts
WHERE balance NOT BETWEEN 10000 AND 40000;
-- 11. Customers whose names end with i
SELECT * FROM customers
WHERE name LIKE '%i';
-- 12. Accounts with balance equal to 50000
SELECT * FROM accounts
WHERE balance = 50000;
-- 13. Customers from Chennai or Salem
SELECT * FROM customers
WHERE city IN ('Chennai', 'Salem');
-- 14. Balance greater than 10000 and less than 40000
SELECT * FROM accounts
WHERE balance > 10000 AND balance < 40000;
-- 15. Accounts whose type is not Current
SELECT * FROM accounts
WHERE account_type NOT IN ('Current');
-- 16. Accounts sorted by balance descending
SELECT * FROM accounts
ORDER BY balance DESC;
-- 17. Customers sorted alphabetically
SELECT * FROM customers
ORDER BY name ASC;
-- 18. Sort by account type, then balance descending
SELECT * FROM accounts
ORDER BY account_type ASC, balance DESC;
-- 19. Total balance
SELECT SUM(balance) AS total_balance
FROM accounts;
-- 20. Average balance
SELECT AVG(balance) AS average_balance
FROM accounts;
-- 21. Maximum balance
SELECT MAX(balance) AS maximum_balance
FROM accounts;
-- 22. Minimum balance
SELECT MIN(balance) AS minimum_balance
FROM accounts;
-- 23. Total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;
-- 24. Total balance by account type
SELECT account_type, SUM(balance) AS total_balance
FROM accounts
GROUP BY account_type;
-- 25. Average balance by account type
SELECT account_type, AVG(balance) AS average_balance
FROM accounts
GROUP BY account_type;
-- 26. Account types with average balance above 20000
SELECT account_type, AVG(balance) AS average_balance
FROM accounts
GROUP BY account_type
HAVING AVG(balance) > 20000;
-- 27. Number of accounts for each customer
SELECT c.customer_id, c.name,
       COUNT(a.account_id) AS account_count
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name;
-- 28. Customers having more than one account
SELECT c.customer_id, c.name,
       COUNT(a.account_id) AS account_count
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(a.account_id) > 1;
-- 29. Customer names and account balances
SELECT c.name, a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id;
-- 30. All customers and their accounts
SELECT c.name, c.city, a.account_id,
       a.account_type, a.balance
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id;
-- 31. All accounts with customer details
SELECT a.account_id, a.account_type, a.balance,
       c.name, c.city
FROM accounts a
JOIN customers c
ON a.customer_id = c.customer_id;
-- 32. Customer names and account types where balance > 20000
SELECT c.name, a.account_type
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
WHERE a.balance > 20000;
-- 33. Total balance for each customer
SELECT c.customer_id, c.name,
       COALESCE(SUM(a.balance), 0) AS total_balance
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name;
-- 34. Customer names and balances sorted by balance
SELECT c.name, a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
ORDER BY a.balance ASC;
-- 35. Number of accounts for each city
SELECT c.city, COUNT(a.account_id) AS account_count
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.city;
-- 36. Accounts with balance greater than average balance
SELECT *
FROM accounts
WHERE balance > (
    SELECT AVG(balance) FROM accounts
);
-- 37. Customers who have accounts
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM accounts
);
-- 38. Customers who do not have accounts
SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM accounts
);
-- 39. Account or accounts with maximum balance
SELECT *
FROM accounts
WHERE balance = (
    SELECT MAX(balance) FROM accounts
);
-- 40. Customers whose total balance exceeds 40000
SELECT c.customer_id, c.name,
       SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(a.balance) > 40000;




CREATE DATABASE IF NOT EXISTS railway_db;
USE railway_db;
CREATE TABLE trains (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_name VARCHAR(50),
    source VARCHAR(50),
    destination VARCHAR(50)
);
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    train_id INT,
    passenger_name VARCHAR(50),
    fare DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (train_id)
        REFERENCES trains(train_id)
);
INSERT INTO trains (train_name, source, destination) VALUES('Express1', 'Chennai', 'Madurai'),('Express2', 'Coimbatore', 'Salem'),('Express3', 'Madurai', 'Chennai');
INSERT INTO bookings(train_id, passenger_name, fare, status) VALUES(1, 'Janani', 500, 'Confirmed'),(1, 'Arun', 500, 'Waiting'),(2, 'Priya', 300, 'Confirmed'),(3, 'Karthik', 450, 'Cancelled'),(2, 'Meena', 300, 'Confirmed');
SELECT * FROM trains;
SELECT * FROM bookings;
-- 41. Bookings with fare greater than 400
SELECT * FROM bookings
WHERE fare > 400;
-- 42. Bookings not confirmed
SELECT * FROM bookings
WHERE status <> 'Confirmed';
-- 43. Trains starting from Chennai
SELECT * FROM trains
WHERE source = 'Chennai';
-- 44. Bookings with fare between 300 and 500
SELECT * FROM bookings
WHERE fare BETWEEN 300 AND 500;
-- 45. Passengers whose names start with A
SELECT * FROM bookings
WHERE passenger_name LIKE 'A%';
-- 46. Train names and passenger names
SELECT t.train_name, b.passenger_name
FROM trains t
JOIN bookings b
ON t.train_id = b.train_id;
-- 47. Number of bookings for each train
SELECT t.train_name,
       COUNT(b.booking_id) AS booking_count
FROM trains t
LEFT JOIN bookings b
ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name;
-- 48. Total confirmed fare collected for each train
SELECT t.train_name,
       COALESCE(
           SUM(CASE
               WHEN b.status = 'Confirmed' THEN b.fare
               ELSE 0
           END), 0
       ) AS total_fare_collected
FROM trains t
LEFT JOIN bookings b
ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name;
-- 49. Bookings with the highest fare
SELECT *
FROM bookings
WHERE fare = (
    SELECT MAX(fare) FROM bookings
);
-- 50. Trains having more than one booking
SELECT t.train_id, t.train_name,
       COUNT(b.booking_id) AS booking_count
FROM trains t
JOIN bookings b
ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name
HAVING COUNT(b.booking_id) > 1;






CREATE DATABASE IF NOT EXISTS employee_db;
USE employee_db;
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    city VARCHAR(30),
    joining_date DATE
);
INSERT INTO Employee VALUES(101, 'John', 'IT', 60000, 'Chennai', '2022-01-15'),(102, 'David', 'HR', 45000, 'Bangalore', '2021-03-10'),(103, 'Smith', 'IT', 70000, 'Chennai', '2020-07-12'),(104, 'Mary', 'Finance', 55000, 'Mumbai', '2023-01-20'),(105, 'James', 'HR', 48000, 'Delhi', '2022-05-05'),(106, 'Linda', 'Finance', 65000, 'Mumbai', '2021-08-18');
SELECT * FROM Employee;
-- 1. Total employees in each department
SELECT department, COUNT(*) AS employee_count
FROM Employee
GROUP BY department;
-- 2. Average salary in each department
SELECT department, AVG(salary) AS average_salary
FROM Employee
GROUP BY department;
-- 3. Departments having more than one employee
SELECT department, COUNT(*) AS employee_count
FROM Employee
GROUP BY department
HAVING COUNT(*) > 1;
-- 4. Highest salary in each department
SELECT department, MAX(salary) AS highest_salary
FROM Employee
GROUP BY department;
-- 5. Lowest salary in each department
SELECT department, MIN(salary) AS lowest_salary
FROM Employee
GROUP BY department;
-- 6. Departments with average salary greater than 50000
SELECT department, AVG(salary) AS average_salary
FROM Employee
GROUP BY department
HAVING AVG(salary) > 50000;
-- 7. Total salary expenditure per department
SELECT department, SUM(salary) AS total_salary
FROM Employee
GROUP BY department;
-- 8. Employees sorted by salary descending
SELECT * FROM Employee
ORDER BY salary DESC;
-- 9. Sort by department and salary descending
SELECT * FROM Employee
ORDER BY department ASC, salary DESC;
-- 10. Cities having more than one employee
SELECT city, COUNT(*) AS employee_count
FROM Employee
GROUP BY city
HAVING COUNT(*) > 1;
-- 11. Total salary paid in each city
SELECT city, SUM(salary) AS total_salary
FROM Employee
GROUP BY city;
-- 12. Departments ordered by total salary, highest first
SELECT department, SUM(salary) AS total_salary
FROM Employee
GROUP BY department
ORDER BY total_salary DESC;
-- 13. Employees in each department earning more than 50000
SELECT department, COUNT(*) AS employee_count
FROM Employee
WHERE salary > 50000
GROUP BY department;
-- 14. Difference between highest and lowest salary
SELECT department,
       MAX(salary) - MIN(salary) AS salary_difference
FROM Employee
GROUP BY department;
-- 15. Top 3 highest-paid employees
SELECT * FROM Employee
ORDER BY salary DESC
LIMIT 3;




CREATE DATABASE IF NOT EXISTS orders_db;
USE orders_db;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30)
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);
INSERT INTO Customers VALUES(1, 'Janani', 'Chennai'),(2, 'Arun', 'Coimbatore'),(3, 'Priya', 'Madurai'),(4, 'Karthik', 'Salem'),(5, 'Meena', 'Bengaluru'),(6, 'Ravi', 'Mumbai');
INSERT INTO Orders VALUES(1001, 1, 3000, '2026-01-05'),(1002, 1, 4500, '2026-01-10'),(1003, 1, 3200, '2026-02-01'),(1004, 1, 1500, '2026-02-10'),(1005, 2, 6000, '2026-01-08'),(1006, 2, 2500, '2026-02-15'),(1007, 2, 1800, '2026-03-02'),(1008, 3, 12000, '2026-01-20'),(1009, 3, 3500, '2026-02-20'),(1010, 4, 700, '2026-03-01'),(1011, 5, 5200, '2026-02-02'),(1012, 5, 4800, '2026-02-18');
SELECT * FROM Customers;
SELECT * FROM Orders;
-- 16. Total order amount for each customer
SELECT c.customer_id, c.customer_name,
       COALESCE(SUM(o.amount), 0) AS total_order_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
-- 17. Customers who placed more than 3 orders
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS order_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 3;
-- 18. Average order amount for each customer
SELECT c.customer_id, c.customer_name,
       AVG(o.amount) AS average_order_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
-- 19. Highest order amount for each customer
SELECT c.customer_id, c.customer_name,
       MAX(o.amount) AS highest_order
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
-- 20. Customers sorted by total purchase amount
SELECT c.customer_id, c.customer_name,
       COALESCE(SUM(o.amount), 0) AS total_purchase
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC;
-- 21. Customers whose total purchase exceeds 10000
SELECT c.customer_id, c.customer_name,
       SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 10000;
-- 22. Customer names and total number of orders
SELECT c.customer_name,
       COUNT(o.order_id) AS order_count
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
-- 23. Customer or customers who spent the highest total amount
SELECT c.customer_id, c.customer_name,
       SUM(o.amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) = (
    SELECT MAX(total_amount)
    FROM (
        SELECT SUM(amount) AS total_amount
        FROM Orders
        GROUP BY customer_id
    ) AS totals
);
-- 24. Customer or customers with the maximum number of orders
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS order_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) = (
    SELECT MAX(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM Orders
        GROUP BY customer_id
    ) AS counts
);
-- 25. Customers whose average order exceeds 2000
SELECT c.customer_id, c.customer_name,
       AVG(o.amount) AS average_order
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING AVG(o.amount) > 2000;
-- 26. Top 5 customers by total purchase
SELECT c.customer_id, c.customer_name,
       SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC
LIMIT 5;
-- 27. Minimum order amount for each customer
SELECT c.customer_id, c.customer_name,
       MIN(o.amount) AS minimum_order
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
-- 28. Customers whose total orders exceed 5000
SELECT c.customer_id, c.customer_name,
       SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 5000;
-- 29. Customer-wise total orders and total purchase amount
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS total_orders,
       COALESCE(SUM(o.amount), 0) AS total_purchase
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
-- 30. Customers with more than 2 orders and total spending above 8000
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS order_count,
       SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 2
   AND SUM(o.amount) > 8000;
 
   
   
   
   CREATE DATABASE IF NOT EXISTS students_db;
USE students_db;
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department VARCHAR(30),
    marks INT
);
INSERT INTO Students VALUES(1, 'Asha', 'CSE', 92),(2, 'Ravi', 'CSE', 78),(3, 'Meena', 'CSE', 85),(4, 'Kiran', 'CSE', 69),(5, 'Priya', 'CSE', 88),(6, 'Arun', 'CSE', 81),(7, 'John', 'ECE', 76),(8, 'Mary', 'ECE', 82),(9, 'David', 'ECE', 71),(10, 'Sara', 'ECE', 95),(11, 'Vijay', 'ISE', 67),(12, 'Nisha', 'ISE', 73),(13, 'Rahul', 'ISE', 89),(14, 'Pooja', 'ISE', 91),(15, 'Imran', 'ISE', 84),(16, 'Leena', 'MECH', 62),(17, 'Manoj', 'MECH', 75),(18, 'Anu', 'MECH', 80);
SELECT * FROM Students;
-- 31. Average marks in each department
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department;
-- 32. Departments with average marks above 75
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
HAVING AVG(marks) > 75;
-- 33. Highest mark in each department
SELECT department, MAX(marks) AS highest_mark
FROM Students
GROUP BY department;
-- 34. Total number of students in each department
SELECT department, COUNT(*) AS student_count
FROM Students
GROUP BY department;
-- 35. Departments having more than 5 students
SELECT department, COUNT(*) AS student_count
FROM Students
GROUP BY department
HAVING COUNT(*) > 5;
-- 36. Departments sorted by average marks descending
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
ORDER BY average_marks DESC;
-- 37. Top 3 departments based on average marks
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
ORDER BY average_marks DESC
LIMIT 3;
-- 38. Departments with average marks between 70 and 90
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
HAVING AVG(marks) BETWEEN 70 AND 90;
-- 39. Total marks scored in each department
SELECT department, SUM(marks) AS total_marks
FROM Students
GROUP BY department;
-- 40. Departments sorted by total number of students
SELECT department, COUNT(*) AS student_count
FROM Students
GROUP BY department
ORDER BY student_count ASC;
-- 41. Lowest mark in each department
SELECT department, MIN(marks) AS lowest_mark
FROM Students
GROUP BY department;
-- 42. Departments where the highest mark exceeds 90
SELECT department, MAX(marks) AS highest_mark
FROM Students
GROUP BY department
HAVING MAX(marks) > 90;
-- 43. Number of students scoring above 80 in each department
SELECT department, COUNT(*) AS students_above_80
FROM Students
WHERE marks > 80
GROUP BY department;
-- 44. Departments where more than 3 students scored above 75
SELECT department, COUNT(*) AS students_above_75
FROM Students
WHERE marks > 75
GROUP BY department
HAVING COUNT(*) > 3;
-- 45. Departments ordered by highest mark descending
SELECT department, MAX(marks) AS highest_mark
FROM Students
GROUP BY department
ORDER BY highest_mark DESC;




-- SHOW DATABASES;
-- USE banking_db;
-- SHOW TABLES;

-- USE railway_db;
-- SHOW TABLES;

-- USE employee_db;
-- SHOW TABLES;

-- USE orders_db;
-- SHOW TABLES;

-- USE students_db;
-- SHOW TABLES;