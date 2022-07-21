USE northwind;

#1 ejercicio 
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

# EJERCICIO 2
# Productos pedidos por empresa en UK por año:
# Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han 
# decidido pedirnos una serie de consultas adicionales. La primera de ellas consiste en una query que nos 
# sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. Nos piden 
# concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para 
# ello hará falta hacer 2 joins.


