USE northwind;

SELECT EmployeeID, LastName, FirstName
	FROM employees;
    
SELECT ProductID, ProductName, UnitPrice, UnitsInStock
	FROM products
    WHERE UnitPrice < 5;
SELECT *
	FROM customers
    WHERE City = "London" or City = "Seattle";
    
    
CustomerID CompanyNameContactNameContactTitleAddressCityRegionPostalCodeCountryPhoneFax