-- 280_coding_sql.sql
-- Topic: SQL (coding) -- 24 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | High Earners
SELECT pg_temp.seed_coding($q$SQL$q$, 'easy', $q$High Earners$q$, $q$Table employees(id, name, dept_id, salary, manager_id). List the name and salary of every employee earning MORE than 70000, highest salary first.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Asha|95000
Chitra|82000
Ben|80000
Isha|75000$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Asha|95000\nChitra|82000\nBen|80000\nIsha|75000"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['select','where','order-by']::text[]);

-- 02 | easy | Employees per Department
SELECT pg_temp.seed_coding($q$SQL$q$, 'easy', $q$Employees per Department$q$, $q$Tables departments(id, name) and employees(id, name, dept_id, salary, manager_id). For EVERY department (including ones with no employees) print the department name and the number of employees, ordered by employee count descending, then department name ascending.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Engineering|4
Sales|3
HR|2
Finance|0$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Engineering|4\nSales|3\nHR|2\nFinance|0"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['group-by','left-join']::text[]);

-- 03 | easy | Departments with No Employees
SELECT pg_temp.seed_coding($q$SQL$q$, 'easy', $q$Departments with No Employees$q$, $q$Print the names of departments that have no employees, in alphabetical order.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Finance$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Finance"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['subquery','not-exists']::text[]);

-- 04 | easy | Duplicate Emails
SELECT pg_temp.seed_coding($q$SQL$q$, 'easy', $q$Duplicate Emails$q$, $q$Table person(id, email). Print every email address that appears more than once, together with how many times it appears, ordered by the email.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
a@x.com|3
b@x.com|2$q$,
  NULL, $j${"sql":"CREATE TABLE person (id INTEGER PRIMARY KEY, email TEXT);\nINSERT INTO person VALUES (1,'a@x.com'),(2,'b@x.com'),(3,'a@x.com'),(4,'c@x.com'),(5,'b@x.com'),(6,'a@x.com');\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"a@x.com|3\nb@x.com|2"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['group-by','having']::text[]);

-- 05 | easy | Customers Who Never Ordered
SELECT pg_temp.seed_coding($q$SQL$q$, 'easy', $q$Customers Who Never Ordered$q$, $q$Tables customers(id, name, city) and orders(id, customer_id, order_date, amount). Print the names of customers who have never placed an order, in alphabetical order.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Eshan
Farah$q$,
  NULL, $j${"sql":"CREATE TABLE customers (id INTEGER PRIMARY KEY, name TEXT, city TEXT);\nCREATE TABLE orders (id INTEGER PRIMARY KEY, customer_id INTEGER, order_date TEXT, amount INTEGER);\nINSERT INTO customers VALUES (1,'Anil','Mumbai'),(2,'Bina','Pune'),(3,'Chetan','Mumbai'),(4,'Divya','Delhi'),(5,'Eshan','Pune'),(6,'Farah','Delhi');\nINSERT INTO orders VALUES\n (1,1,'2024-01-05',500),(2,2,'2024-01-05',300),(3,1,'2024-01-18',200),(4,3,'2024-01-20',700),\n (5,2,'2024-02-02',400),(6,3,'2024-02-14',150),(7,4,'2024-02-14',250),(8,1,'2024-03-01',900),\n (9,4,'2024-03-09',100),(10,2,'2024-03-09',350);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Eshan\nFarah"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['left-join','null']::text[]);

-- 06 | easy | Salary Bands
SELECT pg_temp.seed_coding($q$SQL$q$, 'easy', $q$Salary Bands$q$, $q$Classify each employee's salary as 'Low' (below 60000), 'Mid' (60000 up to but not including 80000) or 'High' (80000 or more). Print each band with the number of employees in it, ordered from the lowest band to the highest.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Low|2
Mid|4
High|3$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Low|2\nMid|4\nHigh|3"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['case','group-by']::text[]);

-- 07 | medium | Second Highest Salary
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Second Highest Salary$q$, $q$Print the second highest DISTINCT salary in employees.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
82000$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"82000"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['subquery','aggregate']::text[]);

-- 08 | medium | Third Highest Distinct Salary
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Third Highest Distinct Salary$q$, $q$Print the third highest DISTINCT salary in employees.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
80000$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"80000"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['limit-offset','distinct']::text[]);

-- 09 | medium | Employees Earning More Than Their Manager
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Employees Earning More Than Their Manager$q$, $q$Print the names of employees who earn more than their direct manager (manager_id refers to employees.id), in alphabetical order.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Esha
Hari$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Esha\nHari"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['self-join']::text[]);

-- 10 | medium | Top Earner in Each Department
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Top Earner in Each Department$q$, $q$For every department that has employees, print the department name, the name of its highest-paid employee and that salary (there are no ties), ordered by department name.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Engineering|Asha|95000
HR|Hari|70000
Sales|Esha|65000$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Engineering|Asha|95000\nHR|Hari|70000\nSales|Esha|65000"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['window-function','join']::text[]);

-- 11 | medium | Departments Paying Above the Company Average
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Departments Paying Above the Company Average$q$, $q$Print each department whose AVERAGE salary is higher than the average salary of all employees, with its average salary rounded down to a whole number, ordered by department name.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Engineering|83000$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Engineering|83000"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['group-by','having','subquery']::text[]);

-- 12 | medium | Employee Pairs in the Same Department
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Employee Pairs in the Same Department$q$, $q$Print every pair of employees who work in the same department as 'name1|name2', listing each pair once with the employee who has the smaller id first. Order by the first name, then the second name.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Asha|Ben
Asha|Chitra
Asha|Isha
Ben|Chitra
Ben|Isha
Chitra|Isha
Dev|Esha
Dev|Farid
Esha|Farid
Gita|Hari$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Asha|Ben\nAsha|Chitra\nAsha|Isha\nBen|Chitra\nBen|Isha\nChitra|Isha\nDev|Esha\nDev|Farid\nEsha|Farid\nGita|Hari"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Accenture']::text[], ARRAY['self-join']::text[]);

-- 13 | medium | Daily Revenue Running Total
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Daily Revenue Running Total$q$, $q$Table orders(id, customer_id, order_date, amount). For each date that has orders print the date, that day's total revenue and the running (cumulative) revenue up to and including that date, ordered by date.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
2024-01-05|800|800
2024-01-18|200|1000
2024-01-20|700|1700
2024-02-02|400|2100
2024-02-14|400|2500
2024-03-01|900|3400
2024-03-09|450|3850$q$,
  NULL, $j${"sql":"CREATE TABLE customers (id INTEGER PRIMARY KEY, name TEXT, city TEXT);\nCREATE TABLE orders (id INTEGER PRIMARY KEY, customer_id INTEGER, order_date TEXT, amount INTEGER);\nINSERT INTO customers VALUES (1,'Anil','Mumbai'),(2,'Bina','Pune'),(3,'Chetan','Mumbai'),(4,'Divya','Delhi'),(5,'Eshan','Pune'),(6,'Farah','Delhi');\nINSERT INTO orders VALUES\n (1,1,'2024-01-05',500),(2,2,'2024-01-05',300),(3,1,'2024-01-18',200),(4,3,'2024-01-20',700),\n (5,2,'2024-02-02',400),(6,3,'2024-02-14',150),(7,4,'2024-02-14',250),(8,1,'2024-03-01',900),\n (9,4,'2024-03-09',100),(10,2,'2024-03-09',350);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"2024-01-05|800|800\n2024-01-18|200|1000\n2024-01-20|700|1700\n2024-02-02|400|2100\n2024-02-14|400|2500\n2024-03-01|900|3400\n2024-03-09|450|3850"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['window-function','running-total']::text[]);

-- 14 | medium | Monthly Revenue
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Monthly Revenue$q$, $q$Print the revenue and number of orders for each month as 'YYYY-MM|revenue|orders', ordered by month.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
2024-01|1700|4
2024-02|800|3
2024-03|1350|3$q$,
  NULL, $j${"sql":"CREATE TABLE customers (id INTEGER PRIMARY KEY, name TEXT, city TEXT);\nCREATE TABLE orders (id INTEGER PRIMARY KEY, customer_id INTEGER, order_date TEXT, amount INTEGER);\nINSERT INTO customers VALUES (1,'Anil','Mumbai'),(2,'Bina','Pune'),(3,'Chetan','Mumbai'),(4,'Divya','Delhi'),(5,'Eshan','Pune'),(6,'Farah','Delhi');\nINSERT INTO orders VALUES\n (1,1,'2024-01-05',500),(2,2,'2024-01-05',300),(3,1,'2024-01-18',200),(4,3,'2024-01-20',700),\n (5,2,'2024-02-02',400),(6,3,'2024-02-14',150),(7,4,'2024-02-14',250),(8,1,'2024-03-01',900),\n (9,4,'2024-03-09',100),(10,2,'2024-03-09',350);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"2024-01|1700|4\n2024-02|800|3\n2024-03|1350|3"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['strftime','group-by']::text[]);

-- 15 | medium | Ordered in January but Not in February
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Ordered in January but Not in February$q$, $q$Print the ids of customers who placed at least one order in January 2024 but none in February 2024, in ascending order.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
1$q$,
  NULL, $j${"sql":"CREATE TABLE customers (id INTEGER PRIMARY KEY, name TEXT, city TEXT);\nCREATE TABLE orders (id INTEGER PRIMARY KEY, customer_id INTEGER, order_date TEXT, amount INTEGER);\nINSERT INTO customers VALUES (1,'Anil','Mumbai'),(2,'Bina','Pune'),(3,'Chetan','Mumbai'),(4,'Divya','Delhi'),(5,'Eshan','Pune'),(6,'Farah','Delhi');\nINSERT INTO orders VALUES\n (1,1,'2024-01-05',500),(2,2,'2024-01-05',300),(3,1,'2024-01-18',200),(4,3,'2024-01-20',700),\n (5,2,'2024-02-02',400),(6,3,'2024-02-14',150),(7,4,'2024-02-14',250),(8,1,'2024-03-01',900),\n (9,4,'2024-03-09',100),(10,2,'2024-03-09',350);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"1"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['except','set-operations']::text[]);

-- 16 | medium | Quarterly Revenue Pivot
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Quarterly Revenue Pivot$q$, $q$Table sales(product, quarter, revenue). Turn the quarters into columns: print product, then total revenue for quarter 1, 2, 3 and 4 (0 when there are no sales), ordered by product.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Laptop|100|150|120|200
Phone|300|250|0|400
Tablet|0|80|90|0$q$,
  NULL, $j${"sql":"CREATE TABLE sales (product TEXT, quarter INTEGER, revenue INTEGER);\nINSERT INTO sales VALUES ('Laptop',1,100),('Laptop',2,150),('Laptop',3,120),('Laptop',4,200),\n ('Phone',1,300),('Phone',2,250),('Phone',4,400),('Tablet',2,80),('Tablet',3,90);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Laptop|100|150|120|200\nPhone|300|250|0|400\nTablet|0|80|90|0"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['case','pivot']::text[]);

-- 17 | medium | Rank Students with Ties
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Rank Students with Ties$q$, $q$Table exam(student, score). Rank students by score (highest first) using DENSE_RANK, so students with equal scores share a rank and the next rank has no gap. Print student, score and rank, ordered by rank then student name.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Kavya|92|1
Meera|92|1
Lalit|85|2
Omkar|85|2
Nikhil|78|3
Pooja|60|4$q$,
  NULL, $j${"sql":"CREATE TABLE exam (student TEXT, score INTEGER);\nINSERT INTO exam VALUES ('Kavya',92),('Lalit',85),('Meera',92),('Nikhil',78),('Omkar',85),('Pooja',60);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Kavya|92|1\nMeera|92|1\nLalit|85|2\nOmkar|85|2\nNikhil|78|3\nPooja|60|4"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Accenture']::text[], ARRAY['window-function','dense-rank']::text[]);

-- 18 | medium | Delete Duplicate Emails
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Delete Duplicate Emails$q$, $q$Table emails(id, email). DELETE the duplicate rows so that only the row with the SMALLEST id remains for each email. Then print the remaining rows (id, email) ordered by id.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
1|a@x.com
2|b@x.com
4|c@x.com
6|d@x.com$q$,
  NULL, $j${"sql":"CREATE TABLE emails (id INTEGER PRIMARY KEY, email TEXT);\nINSERT INTO emails VALUES (1,'a@x.com'),(2,'b@x.com'),(3,'a@x.com'),(4,'c@x.com'),(5,'b@x.com'),(6,'d@x.com');\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"1|a@x.com\n2|b@x.com\n4|c@x.com\n6|d@x.com"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['delete','dml']::text[]);

-- 19 | medium | Raise for the Sales Team
SELECT pg_temp.seed_coding($q$SQL$q$, 'medium', $q$Raise for the Sales Team$q$, $q$Give every employee in department 2 (Sales) a 10% raise using integer arithmetic (salary * 110 / 100), by running an UPDATE statement. Then print the name and new salary of every Sales employee, ordered by id.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Dev|66000
Esha|71500
Farid|63800$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Dev|66000\nEsha|71500\nFarid|63800"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['update','dml']::text[]);

-- 20 | hard | Everyone Under a Manager
SELECT pg_temp.seed_coding($q$SQL$q$, 'hard', $q$Everyone Under a Manager$q$, $q$Using employees.manager_id, list EVERY employee who reports to Asha (id 1), directly or indirectly, with their level (1 = direct report, 2 = report of a report, ...). Print name and level, ordered by level then name.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Ben|1
Chitra|1
Dev|1
Gita|1
Esha|2
Farid|2
Hari|2
Isha|2$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Ben|1\nChitra|1\nDev|1\nGita|1\nEsha|2\nFarid|2\nHari|2\nIsha|2"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Accenture']::text[], ARRAY['recursive-cte','hierarchy']::text[]);

-- 21 | hard | Median Salary
SELECT pg_temp.seed_coding($q$SQL$q$, 'hard', $q$Median Salary$q$, $q$Print the median salary of all employees. (The table has an odd number of rows; write the query so it would also work for an even number by averaging the two middle values, and print the result as a whole number.)

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
70000$q$,
  NULL, $j${"sql":"CREATE TABLE departments (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE employees (id INTEGER PRIMARY KEY, name TEXT, dept_id INTEGER, salary INTEGER, manager_id INTEGER);\nINSERT INTO departments VALUES (1,'Engineering'),(2,'Sales'),(3,'HR'),(4,'Finance');\nINSERT INTO employees VALUES\n (1,'Asha',1,95000,NULL),(2,'Ben',1,80000,1),(3,'Chitra',1,82000,1),\n (4,'Dev',2,60000,1),(5,'Esha',2,65000,4),(6,'Farid',2,58000,4),\n (7,'Gita',3,52000,1),(8,'Hari',3,70000,7),(9,'Isha',1,75000,2);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"70000"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Accenture']::text[], ARRAY['window-function','median']::text[]);

-- 22 | hard | Users with a 3-Day Login Streak
SELECT pg_temp.seed_coding($q$SQL$q$, 'hard', $q$Users with a 3-Day Login Streak$q$, $q$Table logins(user_id, login_date) with ISO dates; a user can log in more than once a day. Print the ids (ascending) of users who logged in on at least 3 CONSECUTIVE calendar days.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
1
3
4$q$,
  NULL, $j${"sql":"CREATE TABLE logins (user_id INTEGER, login_date TEXT);\nINSERT INTO logins VALUES (1,'2024-01-01'),(1,'2024-01-02'),(1,'2024-01-03'),(1,'2024-01-05'),(1,'2024-01-05'),\n (2,'2024-01-01'),(2,'2024-01-03'),(2,'2024-01-05'),(3,'2024-01-10'),(3,'2024-01-11'),(3,'2024-01-12'),(3,'2024-01-13'),\n (4,'2024-01-30'),(4,'2024-01-31'),(4,'2024-02-01');\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"1\n3\n4"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Accenture']::text[], ARRAY['gaps-and-islands','window-function']::text[]);

-- 23 | hard | Find the Missing Ids
SELECT pg_temp.seed_coding($q$SQL$q$, 'hard', $q$Find the Missing Ids$q$, $q$Table items(id) should hold every integer from 1 up to its largest id, but some are missing. Print the missing ids in ascending order.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
3
6
7$q$,
  NULL, $j${"sql":"CREATE TABLE items (id INTEGER PRIMARY KEY);\nINSERT INTO items VALUES (1),(2),(4),(5),(8),(9),(10);\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"3\n6\n7"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Accenture']::text[], ARRAY['recursive-cte','gaps']::text[]);

-- 24 | hard | Students Enrolled in Every Course
SELECT pg_temp.seed_coding($q$SQL$q$, 'hard', $q$Students Enrolled in Every Course$q$, $q$Tables students(id, name) and enrollments(student_id, course). Print the names of students enrolled in EVERY course that appears in enrollments, alphabetically.

The table(s) and data are created by the script already in the editor; write your query after the comment. Your output is the plain rows printed by SQLite (no header, columns separated by |).

Expected output for this data:
Tara$q$,
  NULL, $j${"sql":"CREATE TABLE students (id INTEGER PRIMARY KEY, name TEXT);\nCREATE TABLE enrollments (student_id INTEGER, course TEXT);\nINSERT INTO students VALUES (1,'Rhea'),(2,'Sahil'),(3,'Tara'),(4,'Uday');\nINSERT INTO enrollments VALUES (1,'DBMS'),(1,'OS'),(1,'Networks'),(2,'DBMS'),(2,'OS'),(3,'DBMS'),(3,'OS'),(3,'Networks'),(3,'AI');\n\n-- Write your query below\n"}$j$::jsonb, $j$[{"input":"","expected":"Tara"}]$j$::jsonb,
  $q$SQLite dialect. Output order must match exactly.$q$, 2000, 131072, ARRAY[82],
  ARRAY['Amazon','Accenture']::text[], ARRAY['relational-division','having']::text[]);

