USE Northwind;

-- Ejercicio 1
-- Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores 
-- que tenemos en la BBDD. Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, 
-- además de la relación (Proveedor o Cliente). Pero importante! No debe haber duplicados en nuestra respuesta.
SELECT city, company_name, contact_name, 'Cliente' AS tipo_empresa 
FROM customers
UNION
SELECT city, company_name, contact_name, 'Proveedor' AS tipo_empresa
FROM suppliers; 


-- Ejercicio 2
-- En este caso, nuestro jefe quiere saber cuantos pedidos ha gestionado "Nancy Davolio", una de nuestras empleadas. 
-- Nos pide todos los detalles tramitados por ella.
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Nancy' AND last_name = 'Davolio';  -- primero hice esta consulta, como sentido común

SELECT *
FROM orders
WHERE employee_id IN (
	SELECT employee_id
	FROM employees
	WHERE first_name = 'Nancy' AND last_name = 'Davolio');
    

-- Ejercicio 3
-- En este caso, nuestro jefe quiere saber cuántas empresas no han comprado en el año 1997.
-- Para extraer el año de una fecha, podemos usar el estamento year. Más documentación sobre este método.
SELECT customer_id, company_name
FROM customers
WHERE customer_id NOT IN (         -- REVIEW: NO ES DEL TODO CORRECTO, PORQUE ESTOY COMPARANDO UN CUSTOMER_ID CON UN ORDER_DATE
	SELECT YEAR(order_date)
    FROM orders
    WHERE YEAR(order_date) = 1997); -- para obtener el campo fecha y comprobar si acertamos, deberíamos hacer un join?
   
SELECT customers.customer_id, customers.company_name, orders.order_date
FROM customers JOIN orders
ON customers.customer_id = orders.customer_id
WHERE YEAR(orders.order_date) NOT IN (
	SELECT YEAR(order_date)
    FROM orders
    WHERE YEAR(order_date) = 1997); -- efectivamente, hacemos un join y asi podemos comprobar que ningun año es 1997
    
-- SOLUCIÓN, AÑADIENDO EL DISTINCT QUE FALTABA (porque quiere saber cuántas)
SELECT DISTINCT customers.customer_id, customers.company_name, customers.country, YEAR(orders.order_date) AS 'ComprobacionFecha'
FROM customers JOIN orders
ON customers.customer_id = orders.customer_id
WHERE YEAR(orders.order_date) <> 1997
GROUP BY customers.customer_id;

-- con WHERE NOT IN
SELECT DISTINCT customers.customer_id, customers.company_name, customers.country, YEAR(orders.order_date) AS 'ComprobacionFecha'
FROM customers JOIN orders
ON customers.customer_id = orders.customer_id
WHERE YEAR(orders.order_date) NOT IN (SELECT YEAR(order_date)
										FROM orders
										WHERE YEAR(order_date) = 1997)
GROUP BY customers.customer_id;

    

-- Ejercicio 4
-- Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo. 
-- Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu".
-- En esta query tendremos que combinar conocimientos adquiridos en las lecciones anteriores como por ejemplo el INNER JOIN.
SELECT product_id, product_name
FROM products
WHERE product_name = 'Konbu';
-- Encuentro el id de Konbu

SELECT order_id
FROM order_details
WHERE product_id IN (
	SELECT product_id
	FROM products
	WHERE product_name = 'Konbu');
-- encuentro el order_id de los pedidos de Konbu

SELECT *
FROM orders
WHERE order_id IN (
	SELECT order_id
	FROM order_details
	WHERE product_id IN (
		SELECT product_id
		FROM products
		WHERE product_name = 'Konbu'));
        
        
        -- CON INNER JOIN DENTRO DE LA SUBCONSULTA
        
SELECT *
FROM orders
WHERE orders.order_id IN (
	SELECT order_id
	FROM order_details JOIN products
	USING (product_id)
    WHERE order_details.product_id IN (
		SELECT product_id
		FROM products
		WHERE product_name = 'Konbu'));
