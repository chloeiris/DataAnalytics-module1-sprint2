USE northwind;

-- Ejercicio 1 
-- Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas 
-- las empresas cliente, los ID de sus pedidos y las fechas.

SELECT orders.order_id AS OrderID, customers.company_name AS CompanyName, orders.order_date AS OrderDate
FROM customers
LEFT JOIN orders
USING (customer_id);



-- Ejercicio 2
-- Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado 
-- cada cliente del propio Reino Unido de cara a conocerlos mejor y poder adaptarse al mercado actual.
-- Especificamente nos piden el nombre de cada compañía cliente junto con el número de pedidos.

SELECT customers.company_name AS NombreCliente, COUNT(DISTINCT orders.order_id) AS NumeroPedidos, customers.country
FROM customers
LEFT JOIN orders
USING (customer_id)
WHERE customers.country = 'UK'  -- no me dejaba con el having
GROUP BY customers.customer_id; -- hay que poner un group by para que el count funcione **

-- LO QUE VIENE AHORA SON PRUEBAS ANTERIORES QUE ESTUVIMOS HACIENDO SIN GROUP BY, HASTA QUE NOS DIMOS CUENTA
-- solo me da un resultado, pruebo sin el where
SELECT customers.customer_name AS CompanyName, COUNT(DISTINCT orders.order_number), customers.country
FROM customers
LEFT JOIN orders
USING (customer_number); -- me sale uno solo tambien, pero de Francia. pruebo sin el count

SELECT customers.customer_name AS CompanyName, orders.order_number, customers.country
FROM customers
LEFT JOIN orders
USING (customer_number); -- ahora tiene mas sentido, creo que no se puede contar si no agrupamos por customer ** 

SELECT customers.customer_name AS CompanyName, COUNT(DISTINCT orders.order_number)AS NumberofOrders, customers.country
FROM customers
LEFT JOIN orders
USING (customer_number)
GROUP BY customers.customer_name;  -- Ahora afino busqueda a UK

SELECT customers.customer_name AS CompanyName, COUNT(DISTINCT orders.order_number)AS NumberofOrders, customers.country
FROM customers
LEFT JOIN orders
USING (customer_number)
GROUP BY customers.customer_name
HAVING customers.country = 'UK';



-- Ejercicio 3
-- También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o no) junto con los ID de 
-- todos los pedidos que han realizado, el nombre de contacto de cada empresa y la fecha del pedido.
SELECT customers.company_name AS CompanyName, customers.contact_name AS ContactName, orders.order_id AS OrderID, orders.order_date AS OrderDate, customers.country
FROM customers
LEFT JOIN orders
USING (customer_id)
WHERE customers.country = 'UK';  -- para comprobar que no me falta ninguna empresa, por lo de que aparezca aunque no tenga pedidos, voy a probar un full join

SELECT customers.customer_name AS CompanyName, customers.contact_first_name AS ContactName, customers.country, orders.order_number AS OrderID, orders.order_date AS OrderDate
FROM customers
LEFT JOIN orders
USING (customer_number)
WHERE customers.country = 'UK'
UNION
SELECT customers.customer_name AS CompanyName, customers.contact_first_name AS ContactName, customers.country, orders.order_number AS OrderID, orders.order_date AS OrderDate
FROM customers
RIGHT JOIN orders
USING (customer_number)
WHERE customers.country = 'UK';

-- conclusion, es lo mismo en este caso. Para que te salgan solo los de UK hay que añadir el where uk en ambos joins-


## OJO, estabamos usando la BBDD tienda, en vez de northwind. Lo he cambiado hasta ahora, pero lo voy a saltar y volver a copiar para no perder la consulta
-- Ejercicio 4
-- Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas las empleadas y sus supervisoras. 
-- Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. Investiga el resultado, ¿sabes decir quién es el director?
SELECT offices.city, employees1.employee_number, employees1.first_name, employees1.last_name, employees1.reports_to, employees2.employee_number, employees2.first_name, employees2.last_name, employees2.reports_to
FROM employees AS employees1, employees AS employees2  -- sin el alias no reconoce la tabla y te da error
INNER JOIN offices
USING (office_code)
WHERE employees1.employee_number = employees2.reports_to;  -- me deja poner el where, pero es despues del join.
-- el resultado podria salir mas claro si igualo el reports to con el employee number, osea al reves.

SELECT offices.city, employees1.employee_number, employees1.first_name, employees1.last_name, employees1.reports_to, employees2.employee_number, employees2.first_name, employees2.last_name, employees2.reports_to
FROM employees AS employees1, employees AS employees2
INNER JOIN offices
USING (office_code)
WHERE employees1.reports_to = employees2.employee_number;
-- La directora es Diane Murphy, de San Francisco, puesto que no tiene nadie a quien reportar ## OJO en la BBDD tienda es así, en northwind no!

SELECT employee_number, first_name, last_name, reports_to
FROM employees 
WHERE reports_to = NULL; 
-- consulta simple para saber quien de los empleados no tiene nadie a quien reportar, osea que no tiene jefe, pero no sale. No se por qué


## usando la BBDD northwind

SELECT employees1.city, employees1.employee_id, employees1.first_name, employees1.last_name, employees1.reports_to, employees2.city, employees2.employee_id, employees2.first_name, employees2.last_name, employees2.reports_to
FROM employees AS employees1, employees AS employees2
WHERE employees1.reports_to = employees2.employee_id;
-- El presidente es Andrew Fuller

SELECT employee_number, first_name, last_name, reports_to
FROM employees 
WHERE reports_to = NULL; 
-- consulta simple para saber quien de los empleados no tiene nadie a quien reportar, osea que no tiene jefe, pero no sale. No se por qué



-- Ejercicio 5 Bonus
-- Selecciona todos los pedidos, tengan empresa asociada o no, y todas las empresas tengan pedidos asociados o no. Muestra el ID del pedido, el nombre de la empresa y la 
-- fecha del pedido (si existe).
SELECT customers.company_name AS CompanyName, orders.order_id AS OrderID, orders.order_date AS OrderDate
FROM customers
LEFT JOIN orders
USING (customer_id)
UNION
SELECT customers.company_name AS CompanyName, orders.order_id AS OrderID, orders.order_date AS OrderDate
FROM customers
RIGHT JOIN orders
USING (customer_id);


