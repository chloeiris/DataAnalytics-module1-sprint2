USE northwind;

-- 1. Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
-- Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers.

WITH clientes_CTE (nombres_compañía, id_clientes)
AS (SELECT company_name, customer_id
	FROM customers)
SELECT *
FROM clientes_CTE;

-- 2. Selecciona solo los de que vengan de "Germany"
-- Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, pero solo queremos los que pertezcan a "Germany".

WITH clientes_CTE (nombres_compañía, id_clientes, country)
AS (SELECT company_name, customer_id, country
	FROM customers)
SELECT *
FROM clientes_CTE
WHERE country = 'Germany';

-- 3. Extraed el id de las facturas y su fecha de cada cliente.
-- En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.
-- 📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).

WITH facturas_CTE (facturas_emitidas, fecha_factura, customer_id, compañía) -- aquí estoy definiendo el título de las columnas 
AS (SELECT orders.order_id, orders.order_date, customers.customer_id, customers.company_name -- OJO! el orden de los datos importa, ya que coincide con los nombres de las columnas definidas arriba! 
	FROM orders
    INNER JOIN customers
    USING (customer_id))
SELECT *
FROM facturas_CTE;

-- 4. Contad el número de facturas por cliente
-- Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.

WITH facturas_CTE (facturas_emitidas, fecha_factura, customer_id, compañía) -- aquí estoy definiendo el título de las columnas 
AS (SELECT orders.order_id, orders.order_date, customers.customer_id, customers.company_name -- OJO! el orden de los datos importa, ya que coincide con los nombres de las columnas definidas arriba! 
	FROM orders
    INNER JOIN customers
    USING (customer_id))
SELECT customer_id, COUNT(facturas_emitidas)
FROM facturas_CTE
GROUP BY customer_id;

-- 5. Enunciado ejercicio 5: Cuál la cantidad media pedida de todos los productos ProductID.
-- Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media

# Comprobación del resultado de la media en CTE posterior
SELECT AVG(quantity), product_id
FROM order_details
GROUP BY product_id;

SELECT SUM(quantity), product_id
FROM order_details
GROUP BY product_id;

SELECT COUNT(product_id), product_id
FROM order_details
GROUP BY product_id;

# Definición CTE

WITH average_CTE
AS (SELECT AVG(quantity), product_id
	FROM order_details
	GROUP BY product_id)
SELECT *
FROM average_CTE;
