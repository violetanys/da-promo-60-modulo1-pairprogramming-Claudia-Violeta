USE `northwind`;

/*-- 1. Productos más baratos y caros de nuestra la bases de datos:

Desde la división de productos nos piden conocer el precio de los productos 
que tienen el precio más alto y más bajo. Dales el alias lowestPrice y highestPrice.*/

SELECT *
	FROM products;

SELECT MAX(list_price) AS maximum, MIN(list_price) AS minimum
	FROM products;
/* 2. Conociendo el numero de productos y su precio medio:

Adicionalmente nos piden que diseñemos otra consulta para conocer 
el número de productos y el precio medio de todos ellos (en general, no por cada producto). */

SELECT COUNT(product_code), AVG(list_price) AS average
	FROM products;
    
/* 3. Sacad la máxima y mínima carga de los pedidos de UK:

Nuestro siguiente encargo consiste en preparar una consulta 
que devuelva la máxima y mínima cantidad de carga para un pedido (freight) 
enviado a Reino Unido (United Kingdom). */

columnas - country, cantidad de carga
SELECT *
	FROM shippers;
    
SELECT DISTINCT ship_country_region
	FROM orders;

SELECT MAX(shipping_fee), MIN(shipping_fee)
	FROM orders
    WHERE ship_country_region = "USA";  -- No en UK :(
    
/* 4. Qué productos se venden por encima del precio medio:

Después de analizar los resultados de alguna de nuestras consultas anteriores, desde el departamento de Ventas quieren conocer qué productos en concreto se venden por encima del precio medio para todos los productos de la empresa, ya que sospechan que dicho número es demasiado elevado. También quieren que ordenemos los resultados por su precio de mayor a menor.

📌NOTA: para este ejercicio puedes necesitar dos consultas separadas y usar el resultado de la primera para filtrar la segunda. */

SELECT AVG(list_price) -- 15.84577778 AVG list_price
    FROM products; */

SELECT product_name, list_price
    FROM products
    WHERE list_price > 15.84577778;
    -- no se podia procesar en una sola consulta, que lo decia la pregunta :P  (oops!) --
    -- en TESTS: GROUP BY product_name;
	-- en TESTS: HAVING list_price > 15.84577778;
	-- en TESTS: WHERE list_price > AVG(list_price)
    