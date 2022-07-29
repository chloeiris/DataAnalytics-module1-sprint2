USE northwind;

# Ejercicio 1 
# Extraed los pedidos con el máximo "order_date" para cada empleado.
# Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. 
# Para eso nos pide que lo hagamos con una query correlacionada.


SELECT order_id, customer_id, employee_id, t1.order_date, required_date
FROM orders AS t1 
WHERE order_date >= ALL(
					SELECT MAX(t2.order_date)
					FROM orders AS t2
					WHERE t1.employee_id = t2.employee_id);
				

#EJERCICIO 2:
# Extraed el precio unitario (unit_price) de cada producto vendido.
# Supongamos que ahora nuestro jefe quiere un informe de los productos más vendidos y su precio unitario.
# De nuevo lo tendréis que hacer con queries correlacionadas.


SELECT DISTINCT (product_id), unit_price, quantity 
FROM order_details AS A1
GROUP BY A1.product_id
HAVING SUM(A1.quantity) >= ALL (
					SELECT SUM(A2.quantity)
                    FROM order_details AS A2
                    WHERE A1.product_id = A2.product_id);
                    
MAX UNIT PRICE




