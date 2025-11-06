USE northwind;
/*En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria
 para identificar un tipo de producto.
 En concreto, tienen especial interés por los productos con categoría "Beverages".
Devuelve el ID del producto, el nombre del producto y su ID de categoría.*/
    
SELECT p.ProductID, p.ProductName, p.CategoryID
	FROM products as p
	LEFT JOIN categories as c
    ON p.CategoryID = c.CategoryID
    WHERE c.CategoryName = 'Beverages';
    /* solución farragosa pero útil */
    /* a continuación la SOLUCiÓN ÓPTIMA CON SUBCONSULTA*/

SELECT ProductID, ProductName, CategoryID
FROM products
WHERE CategoryID IN (
    SELECT CategoryID
    FROM categories
    WHERE CategoryName = 'Beverages'
);

/*Extraed la lista de países donde viven los clientes,
 pero no hay ningún proveedor ubicado en ese país
Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes,
entonces podría dirigirse a estos países para buscar proveedores adicionales.*/

SELECT DISTINCT country
	FROM customers
    WHERE country NOT IN (
		SELECT country
        FROM suppliers);
        
/*Extraer los clientes que compraron mas de 20 artículos "Grandma's Boysenberry Spread"
Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto
 "Grandma's Boysenberry SOrderIDpread" (ProductID 6) en un solo pedido.*/

        
 SELECT OrderID, CustomerID
        FROM orders
        WHERE OrderID IN (
	SELECT OrderID
	FROM orderdetails
    WHERE ProductID = 6 AND Quantity > 20 );
    

/*Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes
que ha gestionado cada empleado.
Para eso nos pide que lo hagamos con una query correlacionada.*/
        
SELECT OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate
	FROM orders as o1
    WHERE (
    SELECT OrderDate 
		FROM orders as o2
        WHERE o1.OrderDate = o2.OrderDate 
        );
        
  /*SELECT employee_number AS numero_empleado,  -- I ALMOST had it! (as non correlated below_
	first_name AS nombre_empleado, 
    last_name AS apellido_empleado
	FROM employees
    WHERE employee_number IN (
		SELECT sales_rep_employee_number	-- I expected a where with employee_number = sales_rep_employee_number BUT not needed
			FROM customers*/     