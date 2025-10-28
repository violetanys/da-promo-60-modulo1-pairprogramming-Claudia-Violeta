USE northwind;

SELECT EmployeeID, LastName, FirstName
	FROM employees;
    
SELECT ProductID, ProductName, UnitPrice, UnitsInStock
	FROM products
    WHERE UnitPrice < 5;
 