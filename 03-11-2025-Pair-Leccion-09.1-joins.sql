USE northwind;
-- 1 nos piden: datos empleadas y supervisoras: ubi, nombre y apellido

SELECT trabajadores.EmployeeID, trabajadores.LastName, trabajadores.FirstName, trabajadores.ReportsTo, trabajadores.City, jefes.EmployeeID, jefes.LastName, jefes.FirstName, jefes.City
	FROM employees AS trabajadores
    LEFT JOIN employees AS jefes
    ON trabajadores.ReportsTo = jefes.EmployeeID
    WHERE jefes.EmployeeID IS NULL;   -- para ver cual es "the final boss"

-- 2 nos piden: Todas las categorias de prodcs aunque sean null,  utilizando un RIGHT JOIN 
/*SELECT COUNT(c.id_cliente) AS clientes_sin_pedidos 
	FROM pedidos AS p RIGHT JOIN clientes AS c 
    ON c.id_cliente = p.id_cliente
    WHERE id_pedido IS NULL*/
    SELECT *
		FROM products; 
	
        SELECT *
		FROM categories; 
        
    SELECT c.CategoryID, p.ProductName, c.CategoryName
		FROM products AS p 
        RIGHT JOIN categories AS c
        ON c.CategoryID = p.CategoryID
        ;

-- 3 nos piden : lista de pedidos con clientes incluyendo los pedidos sin cliente asignado. 
SELECT *
	FROM orders;
SELECT *
  FROM customers; 
  
SELECT OrderID, OrderDate,   -- TESTS
	FROM orders
    LEFT JOIN customers
    ON orders.CustomerID = customers.CustomerID
	


		