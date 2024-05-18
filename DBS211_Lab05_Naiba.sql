-- *******************************
-- Name: [Naiba Shabanova]
-- ID: [164598229]
-- Date: [22.02.2024]
-- Purpose: DBS211 Lab 05
-- ********************************************************************************************************
---I added questions here for you because of easy check))) I tried my best

-- Q1 SOLUTION --
---Question--1.	Select data from multiple tables 
--1.	Create a query that shows employee number, first name, last name, city, phone number and postal code for all employees in France.
--a.	Answer this question using an ANSI-89 Join
--b.	Answer this question using an ANSI-92 Join
-- a. Using ANSI-89 Join:

SELECT e.EMPLOYEENUMBER, e.LASTNAME, e.FIRSTNAME, e.EXTENSION, e.EMAIL, o.CITY, o.PHONE, o.POSTALCODE
FROM DBS211_EMPLOYEES e, DBS211_OFFICES o
WHERE e.OFFICECODE = o.OFFICECODE
AND o.COUNTRY = 'France';

--b  Using ANSI-92 Join:
SELECT e.EMPLOYEENUMBER, e.LASTNAME, e.FIRSTNAME, e.EXTENSION, e.EMAIL, o.CITY, o.PHONE, o.POSTALCODE
FROM DBS211_EMPLOYEES e
JOIN DBS211_OFFICES o ON e.OFFICECODE = o.OFFICECODE
WHERE o.COUNTRY = 'France';


--****************************************************************************************************************************************************************


-- Q2 SOLUTION --
--Question--2.		Create a query that displays all payments made by customers from Canada.  
/*a.	Sort the output by Customer Number.  
b.	Only display the Customer Number, Customer Name, Payment Date and Amount.  
c.	Make sure the date is displayed clearly to know what date it is. (i.e. what date is 02-04-19??? � Feb 4, 2019, April 2, 2019, April 19, 2002, �.)*/

SELECT c.CUSTOMERNUMBER, c.CUSTOMERNAME, p.PAYMENTDATE, p.AMOUNT
FROM DBS211_CUSTOMERS c
JOIN DBS211_PAYMENTS p ON c.CUSTOMERNUMBER = p.CUSTOMERNUMBER
WHERE c.COUNTRY = 'Canada'
ORDER BY c.CUSTOMERNUMBER;


---********************************************************************************************************************************************************


-- Q3 SOLUTION --
--Question--3.	Create a query that shows all USA customers who have not made a payment.  Display only the customer number and customer name sorted by customer number.

SELECT c.CUSTOMERNUMBER, c.CUSTOMERNAME
FROM DBS211_CUSTOMERS c
LEFT JOIN DBS211_PAYMENTS p ON c.CUSTOMERNUMBER = p.CUSTOMERNUMBER
WHERE c.COUNTRY = 'USA' AND p.CUSTOMERNUMBER IS NULL
ORDER BY c.CUSTOMERNUMBER;



--***************************************************************************************************************************************************************

------------------ Q4 SOLUTION ------------------
--Question--4 a) Create a view (vwCustomerOrder) to list all orders with the following data for all customers:  
--Customer Number, Order number, order date, product name, quantity ordered, and price for each product in every order. 
--b) Write a statement to view the results of the view just created.

CREATE VIEW vwCustomerOrder AS
SELECT
 o.CUSTOMERNUMBER,
 o.ORDERNUMBER,
 o.ORDERDATE,
 p.PRODUCTNAME,
 d.QUANTITYORDERED,
 d.PRICEEACH
FROM
 DBS211_ORDERS o
 JOIN DBS211_ORDERDETAILS d ON o.ORDERNUMBER = d.ORDERNUMBER
 JOIN DBS211_PRODUCTS p ON d.PRODUCTCODE = p.PRODUCTCODE;
-- b) Write a statement to view the results of the view just created.
SELECT * FROM vwCustomerOrder;




--***************************************************************************************************************************************************************

------------------ Q5 SOLUTION ------------------
--Question-5 /* 5.	Using the vwCustomerOrder  view, display the order information for customer number 124. Sort the output based on order number and then order line number. (Yes, I know orderLineNumber is not in the view)

SELECT *
FROM vwCustomerOrder
WHERE CUSTOMERNUMBER = 124
ORDER BY ORDERNUMBER;



--***************************************************************************************************************************************************************

------------------ Q6 SOLUTION ------------------
-----Question 6* .	Create a query that displays the customer number, first name, last name, phone, and credit limits for all customers who do not have any orders

SELECT c.CUSTOMERNUMBER, c.CONTACTFIRSTNAME, c.CONTACTLASTNAME, c.PHONE, c.CREDITLIMIT
FROM DBS211_CUSTOMERS c
LEFT JOIN DBS211_ORDERS o ON c.CUSTOMERNUMBER = o.CUSTOMERNUMBER
WHERE o.CUSTOMERNUMBER IS NULL;




--***************************************************************************************************************************************************************


------------------ Q7 SOLUTION ------------------
----Questoin7 .	Create a view (vwEmployeeManager) to display all information of all employees and the name and the last name of their managers if there is any manager that the employee reports to.  Include all employees, including those who do not report to anyone.

CREATE VIEW vwEmployeeManager AS
SELECT
 e.EMPLOYEENUMBER,
 e.LASTNAME AS EMPLOYEE_LASTNAME,
 e.FIRSTNAME AS EMPLOYEE_FIRSTNAME,
 e.EXTENSION,
 e.EMAIL,
 e.OFFICECODE,
 e.REPORTSTO,
 e.JOBTITLE,
 m.LASTNAME AS MANAGER_LASTNAME,
 m.FIRSTNAME AS MANAGER_FIRSTNAME
FROM
 DBS211_EMPLOYEES e
LEFT JOIN
 DBS211_EMPLOYEES m ON e.REPORTSTO = m.EMPLOYEENUMBER;
-- Display
SELECT * FROM vwEmployeeManager;



--***************************************************************************************************************************************************************


------------------ Q8 SOLUTION ------------------
----Question 8 8.	Modify the employee_manager view so the view returns only employee information for employees who have a manager. Do not DROP and recreate the view – modify it. (Google is your friend).

CREATE OR REPLACE VIEW vwEmployeeManager AS
SELECT
 e.EMPLOYEENUMBER,
 e.LASTNAME AS EMPLOYEE_LASTNAME,
 e.FIRSTNAME AS EMPLOYEE_FIRSTNAME,
 e.EXTENSION,
 e.EMAIL,
 e.OFFICECODE,
 e.REPORTSTO,
 e.JOBTITLE,
 m.LASTNAME AS MANAGER_LASTNAME,
 m.FIRSTNAME AS MANAGER_FIRSTNAME
FROM
 DBS211_EMPLOYEES e
JOIN
 DBS211_EMPLOYEES m ON e.REPORTSTO = m.EMPLOYEENUMBER;
 
 
 

--***************************************************************************************************************************************************************


------------------ Q9 SOLUTION ------------------
--Question 9 .	Drop both customer_order and employee_manager views. 


DROP VIEW vwCustomerOrder;
DROP VIEW vwEmployeeManager;


--- final output --  
                               --
View VWEMPLOYEEMANAGER dropped.
--


-------------------------------------------------------------
