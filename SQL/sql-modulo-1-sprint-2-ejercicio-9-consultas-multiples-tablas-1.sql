USE northwind;

#Ejercicio 1
# Pedidos por empresa en UK:
# Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la 
# que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK. Nos piden el ID del cliente y 
# el nombre de la empresa y el número de pedidos.
# Deberéis obtener una tabla similar a esta:

SELECT customers.customer_id, customers.company_name, COUNT(orders.order_id) 
FROM customers JOIN orders 
USING (customer_id) 
WHERE customers.country = 'UK' 
GROUP BY customers.customer_id 
ORDER BY customers.customer_id; 

# Ejercicio 2
# Productos pedidos por empresa en UK por año:
# Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han 
# decidido pedirnos una serie de consultas adicionales. La primera de ellas consiste en una query que nos 
# sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. Nos piden 
# concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para 
# ello hará falta hacer 2 joins.
SELECT customers.company_name, customers.customer_id, orders.customer_id, orders.order_date
FROM customers INNER JOIN orders
USING (customer_id);

SELECT orders.order_date, orders.order_id, order_details.order_id, SUM(order_details.quantity)
FROM orders INNER JOIN order_details
USING (order_id)
GROUP BY order_details.order_id;


# Ejercicio 3
# Mejorad la query anterior:
# Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que han pedido 
# por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen en 
# porcentajes, 15% nos sale como 0.15.
SELECT customers.company_name, customers.customer_id, orders.customer_id, orders.order_date
FROM customers INNER JOIN orders
USING (customer_id);

SELECT orders.order_date, orders.order_id, order_details.order_id, SUM(order_details.quantity * order_details.unit_price * order_details.discount) AS 'Pedido con Descuento'
FROM orders INNER JOIN order_details
USING (order_id)
WHERE order_details.discount <> 0
GROUP BY order_details.order_id; -- Me salen solo los pedidos que tienen descuento

SELECT orders.order_date, orders.order_id, order_details.order_id, SUM(order_details.quantity * order_details.unit_price) AS 'Precio sin Descuento',
CASE
	WHEN order_details.discount <> 0 THEN SUM((order_details.quantity * order_details.unit_price) * order_details.discount)
    END AS 'Precio con Descuento'
FROM orders INNER JOIN order_details
USING (order_id)
GROUP BY order_details.order_id;

-- codigo a parte -- No uso group by y sum porque hay units que no tienen discount y units que si tienen
SELECT *, unit_price * quantity AS 'Precio sin Descuento',
CASE
	WHEN discount <> 0 THEN (unit_price * quantity) * discount
    END AS 'Precio con Descuento'
FROM order_details;


# Ejercicio 4: BONUS: Pedidos que han realizado cada compañía y su fecha:
# Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, desde la central nos han pedido 
#una consulta que indique el nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha.
SELECT 


# Ejercicio 5: BONUS: Tipos de producto vendidos:
# Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y el nombre del producto,
# y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).
# Pista Necesitaréis usar 3 joins.


