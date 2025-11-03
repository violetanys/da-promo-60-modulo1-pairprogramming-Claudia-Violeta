USE northwind;
-- Ejercicio 1 --
SELECT *	
	FROM Customers
    INNER JOIN Orders
    LIMIT 5;
SELECT c.CustomerID, CompanyName, COUNT(o.OrderID)
	FROM customers AS c
    INNER JOIN orders AS o
		ON c.CustomerID = o.CustomerID
	GROUP BY c.customerID
    HAVING COUNT(o.OrderID)
    ;
-- Ejercicio 2 --
-- Primer paso: unimos 3 tablas
SELECT *
	FROM orders AS o
    INNER JOIN customers AS c
		ON c.CustomerID = o.CustomerID
	INNER JOIN orderdetails AS od
		ON o.OrderID = od.OrderID
	LIMIT 10;
-- Segundo paso: filtramos las columnas que necesitabamos y añadimos el where para filtrar por pais
SELECT CompanyName, year(orderdate), Quantity
	FROM orders AS o
    INNER JOIN customers AS c
		ON c.CustomerID = o.CustomerID
	INNER JOIN orderdetails AS od
		ON o.OrderID = od.OrderID
	WHERE o.ShipCountry = "UK"
        ;
-- tercer paso: limpiamos los resultados, agrupando por nombre de compañia y sumando los objetos que habian comprado
-- también pusimos alias en las columnas
SELECT CompanyName AS nombre_empresa, year(orderdate) AS año, SUM(Quantity) AS num_objetos
	FROM orders AS o
    INNER JOIN customers AS c
		ON c.CustomerID = o.CustomerID
	INNER JOIN orderdetails AS od
		ON o.OrderID = od.OrderID
	WHERE o.ShipCountry = "UK"
    GROUP BY CompanyName, year(orderdate)
     ;
-- Ejercicio 3 --
SELECT OrderID, CompanyName, DATE(OrderDate)
	FROM orders
	INNER JOIN customers;
-- Ejercicio 4 --
-- Primer paso: unimos las 3 tablas products con categories y products con orderdetails
SELECT *
	FROM products AS p
    INNER JOIN categories AS c
		ON p.CategoryID = c.CategoryID
	INNER JOIN orderdetails AS od
		ON p.ProductID = od.ProductID
	LIMIT 20;
-- Segundo paso: limpiamos las columnas que necesitamos
SELECT c.CategoryID, CategoryName, ProductName, Quantity, od.UnitPrice, Discount
	FROM products AS p
    INNER JOIN categories AS c
		ON p.CategoryID = c.CategoryID
	INNER JOIN orderdetails AS od
		ON p.ProductID = od.ProductID
	;
-- Tercer paso: intentamos sacar el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).
-- tenemos sumado la cantidad de productos
SELECT c.CategoryID, CategoryName,
		ProductName, SUM(DISTINCT Quantity),
			od.UnitPrice, Discount
	FROM products AS p
    INNER JOIN categories AS c
		ON p.CategoryID = c.CategoryID
	INNER JOIN orderdetails AS od
		ON p.ProductID = od.ProductID
	GROUP BY  c.CategoryID, CategoryName, ProductName, od.UnitPrice, Discount
	;
-- Cuarto paso: intentamos la matematica
SELECT c.CategoryID,
    c.CategoryName,
    p.ProductName,
    SUM((od.Quantity * od.UnitPrice) * (100 - od.Discount)) AS product_sales
	FROM products AS p
    INNER JOIN categories AS c
		ON p.CategoryID = c.CategoryID
	INNER JOIN orderdetails AS od
		ON p.ProductID = od.ProductID
	GROUP BY  c.CategoryID, CategoryName, ProductName
	;