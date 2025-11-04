-- PAIR - Modulo 2 - Leccion 11
-- UNION / UNION ALL, LIKE / NOT LIKE, IN / NOT IN, REGEXP
USE northwind;
/* 1. Ciudades que empiezan con "A" o "B".

Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquellas 
compañías que están afincadas en ciudades que empiezan por "A" o "B". 
Necesita que le devolvamos la ciudad, el nombre de la compañía y el nombre de contacto. */
SELECT *
	FROM customers;
SELECT CompanyName, City
	FROM customers
    WHERE City LIKE 'A%' OR City LIKE 'B%';

/* 2. Número de pedidos que han hecho en las ciudades que empiezan con L.

En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior 
el número de total de pedidos que han hecho todas las ciudades que empiezan por "L". */
SELECT *
	FROM customers;
    
SELECT
    c.City AS ciudad,         -- ES: ciudad / EN: city
    c.CompanyName AS empresa, -- ES: empresa / EN: company
    c.ContactName AS persona_contacto, -- ES: contacto / EN: contact
    COUNT(o.OrderID) AS numero_pedidos
FROM Orders AS o
INNER JOIN Customers AS c
    ON o.CustomerID = c.CustomerID
WHERE c.City LIKE 'L%'       -- ciudades que empiezan con L
GROUP BY c.City, c.CompanyName, c.ContactName;

SELECT
  c.City        AS ciudad,
  c.CompanyName AS empresa,
  c.ContactName AS persona_contacto,
  COUNT(o.OrderID) AS numero_pedidos
FROM customers AS c
LEFT JOIN orders AS o ON c.CustomerID = o.CustomerID
WHERE c.City LIKE 'L%'          -- filtra ciudades que empiezan por L
GROUP BY c.City, c.CompanyName, c.ContactName
HAVING COUNT(o.OrderID) > 0;    -- muestra solo los clientes que tienen pedidos

SELECT							-- ChatGPT
    c.City AS ciudad,
    c.CompanyName AS empresa,
    c.ContactName AS persona_contacto,
    COUNT(o.OrderID) AS numero_pedidos
FROM customers AS c
JOIN orders AS o ON c.CustomerID = o.CustomerID
WHERE c.City LIKE 'L%'         -- ES: ciudades con L / EN: cities starting with L
GROUP BY c.City, c.CompanyName, c.ContactName;
/* 3. Todos los clientes cuyo "country" no incluya "Sales".

Nuestro objetivo es extraer los clientes que no tengan el titulo de "Sales" en "ContactTitle" . 
Extraer el nombre de contacto, su titulo de contacto y el nombre de la compañía. */
SELECT
    c.Country AS pais,         -- ES: ciudad / EN: city
    c.CompanyName AS empresa, -- ES: empresa / EN: company
    c.ContactName AS persona_contacto, -- ES: contacto / EN: contact
    c.ContactTitle AS title
FROM customers AS c
WHERE c.ContactTitle NOT LIKE '%Sales%';       -- % porque pueden haber palabras antes/despues

/* 4. Todos los clientes que no tengan una "A" en segunda posición en su nombre.

Devolved unicamente el nombre de contacto. */
SELECT ContactName
	FROM customers
    WHERE ContactName NOT LIKE '_A%';

/* 5. Extraer toda la información sobre las compañías que tengamos en la bases de datos

Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los 
clientes y proveedores que tenemos en la bases de datos. Mostrad la ciudad a la que pertenecen, 
el nombre de la empresa y el nombre del contacto, además de la relación (Proveedor o Cliente). 
Pero importante! No debe haber duplicados en nuestra respuesta. La columna Relationship no existe 
y debe ser creada como columna temporal. Para ello añade el valor que le quieras dar al campo y
 utilizada como alias Relationship.

Nota: Deberás crear esta columna temporal en cada instrucción SELECT.  8? */
SELECT CompanyName, ContactName, City, "Customer" AS Relationship
	FROM customers
UNION
SELECT CompanyName, ContactName, City, "Supplier"
	FROM suppliers;


/* 6. Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet". */
SELECT *
	FROM categories
    WHERE `Description` LIKE '%sweet%';

/* 7. Extraed todos los nombres y apellidos de los clientes y empleados que tenemos en la bases de datos:

💡 Pista 💡 ¿Ambas tablas tienen las mismas columnas para nombre y apellido? 
Tendremos que combinar dos columnas usando concat para unir dos columnas. -->  */
USE tienda;  -- copiando lo de clase ;)
SELECT ContactName AS nombre , "northwind" AS empresa
	FROM northwind.customers
UNION							-- CONCAT - unir ambas columnas tienda
SELECT CONCAT(contact_first_name, " ", contact_last_name), "tienda"
	FROM customers;

USE northwind;
SELECT CONCAT(contact_first_name, " ", contact_last_name) AS contact, "tienda" AS empresa
	FROM tienda.customers
UNION
SELECT ContactName AS nombre , "northwind"
	FROM customers;
