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
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (name, city) VALUES
('Janani','Chennai'),
('Arun','Coimbatore'),
('Priya','Madurai'),
('Karthik','Salem');

INSERT INTO accounts (customer_id, account_type, balance) VALUES
(1,'Savings',50000),
(1,'Current',20000),
(2,'Savings',30000),
(3,'Savings',15000),
(4,'Current',40000);

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
    FOREIGN KEY (train_id) REFERENCES trains(train_id)
);

INSERT INTO trains (train_name, source, destination) VALUES
('Express1','Chennai','Madurai'),
('Express2','Coimbatore','Salem'),
('Express3','Madurai','Chennai');

INSERT INTO bookings (train_id, passenger_name, fare, status) VALUES
(1,'Janani',500,'Confirmed'),
(1,'Arun',500,'Waiting'),
(2,'Priya',300,'Confirmed'),
(3,'Karthik',450,'Cancelled'),
(2,'Meena',300,'Confirmed');


-- 1. Retrieve all accounts with balance greater than 20,000.
select * from accounts where balance > 20000;

-- 2. Find customers who live in Chennai.
select * from customers where city = 'Chennai';

-- 3. Display accounts with balance between 20,000 and 50,000.
select * from accounts where balance between 20000 and 50000;

-- 4. Find customers whose names start with 'J'.
select * from customers where name like 'J%';

-- 5. Retrieve accounts of type 'Savings' or 'Current'.
select * from accounts where account_type = 'Savings' or account_type = 'Current';

-- 6. Display accounts that are not 'Savings'.
select * from accounts where account_type not like 'Savings';

-- 7. Find customers whose names contain the letter 'a'.
select * from customers where name like '%a%';

-- 8. Retrieve accounts with balance less than or equal to 30,000.
select * from accounts where balance <= 30000;

-- 9. Find customers who are not from Madurai.
select * from customers where city not like 'Madurai';

-- 10. Display accounts where balance is not between 10,000 and 40,000.
select * from accounts where balance not between 10000 and 40000;

-- 11. Retrieve customers whose names end with 'i'.
select * from customers where name like '%i';

-- 12. Find accounts with balance equal to 50,000.
select * from accounts where balance = 50000;

-- 13. Display customers whose city is either Chennai or Salem.
select * from customers where city in ('Chennai', 'Salem');

-- 14. Find accounts with balance greater than 10,000 and less than 40,000.
select * from accounts where balance > 10000 and balance < 40000;

-- 15. Retrieve accounts where account type is not in ('Current').
select * from accounts where account_type not in ('Current');

-- 16. Display all accounts sorted by balance in descending order.
select * from accounts order by balance desc;

-- 17. List customers sorted alphabetically by name.
select * from customers order by name asc;

-- 18. Display accounts sorted by account type and then by balance (descending).
select * from accounts order by account_type asc, balance desc;

-- 19. Find the total balance of all accounts.
select sum(balance) as TBalance from accounts;

-- 20. Calculate the average balance of accounts.
select avg(balance) as ABalance from accounts;

-- 21. Find the maximum account balance.
select max(balance) as MBalance from accounts;

-- 22. Find the minimum account balance.
select min(balance) as min_balance from accounts;

-- 23. Count the total number of customers.
select count(*) as TCustomers from customers;

-- 24. Find total balance grouped by account type.
select account_type, sum(balance) as TBalance from accounts group by account_type;

-- 25. Find average balance for each account type.
select account_type, avg(balance) as ABalance from accounts group by account_type;

-- 26. Display account types having average balance greater than 20,000.
select account_type, avg(balance) as ABalance from accounts group by account_type having avg(balance) > 20000;

-- 27. Count number of accounts for each customer.
select customer_id, count(*) as num_accounts from accounts group by customer_id;

-- 28. Display customers having more than one account.
select customer_id, count(*) as num_accounts from accounts group by customer_id having count(*) > 1;

-- 29. Retrieve customer names along with their account balances.
select c.name, a.balance from customers c inner join accounts a on c.customer_id = a.customer_id;

-- 30. Display all customers and their accounts (including customers without accounts).
select c.customer_id, c.name, c.city, a.account_id, a.account_type, a.balance from customers c left join accounts a on c.customer_id = a.customer_id;

-- 31. Display all accounts and corresponding customer details.
select a.account_id, a.account_type, a.balance, c.customer_id, c.name, c.city from accounts a left join customers c on a.customer_id = c.customer_id;

-- 32. Retrieve customer names and account types where balance is greater than 20,000.
select c.name, a.account_type from customers c join accounts a on c.customer_id = a.customer_id where a.balance > 20000;

-- 33. List customers with their total balance using JOIN.
select c.customer_id, c.name, sum(a.balance) as TBalance from customers c join accounts a on c.customer_id = a.customer_id group by c.customer_id, c.name;

-- 34. Display customer names and balances sorted by balance.
select c.name, a.balance from customers c join accounts a on c.customer_id = a.customer_id order by a.balance;

-- 35. Count number of accounts for each city using JOIN.
select c.city, count(a.account_id) as num_accounts from customers c join accounts a on c.customer_id = a.customer_id group by c.city;

-- 36. Find accounts with balance greater than average balance.
select * from accounts where balance > (select avg(balance) from accounts);

-- 37. Retrieve customers who have accounts.
select * from customers where customer_id in (select customer_id from accounts);

-- 38. Find customers who do not have any accounts.
select * from customers c where not exists ( select 1 from accounts a where a.customer_id = c.customer_id );

-- 39. Display account(s) with the maximum balance.
select * from accounts where balance = (select max(balance) from accounts);

-- 40. Find customers whose total balance is greater than 40,000.
select * from customers where customer_id in ( select customer_id from accounts group by customer_id having sum(balance) > 40000 );

-- 41. Retrieve all bookings with fare greater than 400.
select * from bookings where fare > 400;

-- 42. Find bookings where status is not 'Confirmed'.
select * from bookings where status not like 'Confirmed';

-- 43. Display trains starting from Chennai.
select * from trains where source = 'Chennai';

-- 44. Retrieve bookings with fare between 300 and 500.
select * from bookings where fare between 300 and 500;

-- 45. Find passengers whose names start with 'A'.
select * from bookings where passenger_name like 'A%';

-- 46. Retrieve train names along with passenger names.
select t.train_name, b.passenger_name from trains t join bookings b on t.train_id = b.train_id order by t.train_name;

-- 47. Count number of bookings for each train.
select t.train_name, count(b.booking_id) as total_bookings from trains t join bookings b on t.train_id = b.train_id group by t.train_id, t.train_name order by total_bookings desc, t.train_name;

-- 48. Display train names and total fare collected for each train.
select t.train_name, sum(b.fare) as total_fare from trains t join bookings b on t.train_id = b.train_id group by t.train_id, t.train_name order by total_fare desc;

-- 49. Find bookings with fare equal to the highest fare.
select * from bookings where fare = (select max(fare) from bookings);

-- 50. Retrieve trains that have more than one booking.
select * from trains where train_id in ( select train_id from bookings group by train_id having count(*) > 1 );


CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    city VARCHAR(30),
    joining_date DATE
);

INSERT INTO Employee VALUES
(101,'John','IT',60000,'Chennai','2022-01-15'),
(102,'David','HR',45000,'Bangalore','2021-03-10'),
(103,'Smith','IT',70000,'Chennai','2020-07-12'),
(104,'Mary','Finance',55000,'Mumbai','2023-01-20'),
(105,'James','HR',48000,'Delhi','2022-05-05'),
(106,'Linda','Finance',65000,'Mumbai','2021-08-18');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders VALUES
(1, 1, 3000, '2024-01-10'),
(2, 1, 2500, '2024-02-12'),
(3, 1, 4000, '2024-03-15'),
(4, 1, 1500, '2024-04-20'),
(5, 2, 2200, '2024-01-25'),
(6, 2, 1800, '2024-02-18'),
(7, 2, 5000, '2024-05-02'),
(8, 3, 900,  '2024-03-09'),
(9, 3, 1200, '2024-04-11'),
(10, 4, 7000, '2024-05-21'),
(11, 4, 4500, '2024-06-03');

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department VARCHAR(30),
    marks INT
);

INSERT INTO Students VALUES
(1,  'Ravi',    'CSE',   85),
(2,  'Anita',   'CSE',   92),
(3,  'Kiran',   'CSE',   78),
(4,  'Divya',   'CSE',   81),
(5,  'Suresh',  'CSE',   88),
(6,  'Meera',   'CSE',   76),
(7,  'Arjun',   'ECE',   72),
(8,  'Sneha',   'ECE',   68),
(9,  'Vikram',  'ECE',   79),
(10, 'Pooja',   'ECE',   83),
(11, 'Rahul',   'MECH',  65),
(12, 'Lakshmi', 'MECH',  74),
(13, 'Naveen',  'MECH',  70),
(14, 'Deepa',   'CIVIL', 91),
(15, 'Manoj',   'CIVIL', 77);


-- 51. Find the total number of employees in each department.
select department, count(*) as total_employees from employee group by department;

-- 52. Find the average salary of employees in each department.
select department, avg(salary) as average_salary from employee group by department;

-- 53. Display departments having more than one employee.
select department, count(*) as total_employees from employee group by department having count(*) > 1;

-- 54. Find the highest salary in each department.
select department, max(salary) as highest_salary from employee group by department;

-- 55. Find the lowest salary in each department.
select department, min(salary) as lowest_salary from employee group by department;

-- 56. Find departments whose average salary is greater than 50,000.
select department, avg(salary) as average_salary from employee group by department having avg(salary) > 50000;

-- 57. Calculate the total salary expenditure for each department.
select department, sum(salary) as total_salary from employee group by department;

-- 58. Display all employees sorted by salary in descending order.
select * from employee order by salary desc;

-- 59. Display employees sorted first by department and then by salary in descending order.
select * from employee order by department asc, salary desc;

-- 60. Find cities that have more than one employee.
select city, count(*) as total_employees from employee group by city having count(*) > 1;

-- 61. Find the total salary paid in each city.
select city, sum(salary) as total_salary from employee group by city;

-- 62. Display departments ordered by total salary expenditure from highest to lowest.
select department, sum(salary) as total_salary from employee group by department order by total_salary desc;

-- 63. Find the number of employees in each department whose salary is greater than 50,000.
select department, count(*) as total_employees from employee where salary > 50000 group by department;

-- 64. Find the difference between the highest and lowest salary in each department.
select department, max(salary) - min(salary) as salary_difference from employee group by department;

-- 65. Display the top 3 highest-paid employees.
select * from employee order by salary desc limit 3;

-- 66. Find the total order amount for each customer.
select c.customer_id, c.name, sum(o.amount) as total_amount from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name;

-- 67. Find customers who have placed more than 3 orders.
select c.customer_id, c.name, count(o.order_id) as total_orders from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name having count(o.order_id) > 3;

-- 68. Find the average order amount for each customer.
select c.customer_id, c.name, avg(o.amount) as average_amount from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name;

-- 69. Find the highest order amount placed by each customer.
select c.customer_id, c.name, max(o.amount) as highest_amount from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name;

-- 70. Display customers sorted by their total purchase amount.
select c.customer_id, c.name, sum(o.amount) as total_purchase from Customers c join Orders o on c.customer_id = o.customer_id  group by c.customer_id, c.name order by total_purchase desc;

-- 71. Find customers whose total purchase amount exceeds 10,000.
select c.customer_id, c.name, sum(o.amount) as total_purchase from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name having sum(o.amount) > 10000;

-- 72. Display customer names along with the total number of orders placed.
select c.name, count(o.order_id) as total_orders from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name; 

-- 73. Find the customer who spent the highest amount.
select c.customer_id, c.name, sum(o.amount) as total_spent from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name order by total_spent desc limit 1;

-- 74. Find the customer who placed the maximum number of orders.
select c.customer_id, c.name, count(o.order_id) as total_orders from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name order by total_orders desc limit 1;

-- 75. Find customers whose average order amount is greater than 2,000.
select c.customer_id, c.name, avg(o.amount) as average_amount from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name having avg(o.amount) > 2000;

-- 76. Display the top 5 customers based on total purchase amount.
select c.customer_id, c.name, sum(o.amount) as total_purchase from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name order by total_purchase desc limit 5;

-- 77. Find the minimum order amount for each customer.
select c.customer_id, c.name, min(o.amount) as minimum_amount from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name;

-- 78. Find customers who have placed orders worth more than 5,000 in total.
select c.customer_id, c.name, sum(o.amount) as total_purchase from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name having sum(o.amount) > 5000;

-- 79. Display customer-wise total orders and total purchase amount.
select c.customer_id, c.name, count(o.order_id) as total_orders, sum(o.amount) as total_purchase from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name;

-- 80. Find customers who placed more than 2 orders and spent more than 8,000.
select c.customer_id, c.name, count(o.order_id) as total_orders, sum(o.amount) as total_purchase from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name having count(o.order_id) > 2 and sum(o.amount) > 8000;

-- 81. Find the average marks scored by students in each department.
select department, avg(marks) as average_marks from Students group by department;

-- 82. Find departments whose average marks are above 75.
select department, avg(marks) as average_marks from Students group by department having avg(marks) > 75;

-- 83. Find the highest mark scored in each department.
select department, max(marks) as highest_marks from Students group by department;

-- 84. Find the total number of students in each department.
select department, count(*) as total_students from Students group by department;

-- 85. Find departments having more than 5 students.
select department, count(*) as total_students from Students group by department having count(*) > 5;

-- 86. Display departments sorted by average marks in descending order.
select department, avg(marks) as average_marks from Students group by department order by average_marks desc;

-- 87. Find the top 3 departments based on average marks.
select department, avg(marks) as average_marks from Students group by department order by average_marks desc limit 3;

-- 88. Find departments whose average marks are between 70 and 90.
select department, avg(marks) as average_marks from Students group by department having avg(marks) between 70 and 90;

-- 89. Find the total marks scored by students in each department.
select department, sum(marks) as total_marks from Students group by department;

-- 90. Display departments sorted by the total number of students.
select department, count(*) as total_students from Students group by department order by total_students desc;

-- 91. Find the lowest mark scored in each department.
select department, min(marks) as lowest_marks from Students group by department;

-- 92. Find departments where the highest mark is greater than 90.
select department, max(marks) as highest_marks from Students group by department having max(marks) > 90;

-- 93. Find the number of students scoring above 80 in each department.
select department, count(*) as students_above_80 from Students where marks > 80 group by department;

-- 94. Find departments where more than 3 students scored above 75.
select department, count(*) as students_above_75 from Students where marks > 75 group by department having count(*) > 3;

-- 95. Display departments ordered by highest mark in descending order.
select department, max(marks) as highest_marks from Students group by department order by highest_marks desc;