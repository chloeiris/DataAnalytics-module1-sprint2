USE northwind;


# Ejercicio 1:
# Extraed información de los productos "Beverages"
# En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar 
# un tipo de producto. En concreto, tienen especial interés por los productos con categoría "Beverages".
# Devuelve el ID del producto, el nombre del producto y su ID de categoría.
 
SELECT product_id, product_name, category_id
FROM products 
WHERE category_id IN (
	SELECT category_id 
    FROM categories
    WHERE category_name = 'Beverages');


# Ejercicio 2:
# Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país.
# Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría 
# dirigirse a estos países para buscar proveedores adicionales.

SELECT country
FROM customers 
WHERE country NOT IN (
	SELECT country
    FROM suppliers)
GROUP BY country;


# Ejercicio 3:
# Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
# Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto 
# "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido. 

SELECT orders.order_id, customers.company_name
FROM customers JOIN orders
ON customers.customer_id = orders.customer_id
HAVING orders.order_id IN (
					SELECT order_id 
					FROM orders
					WHERE order_id IN (
									SELECT order_id
									FROM order_details
									WHERE quantity > 20 AND product_id = 6))
ORDER BY orders.order_id;


#Ejercicio 4:
#Extraed los 10 productos más caros
#Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.
#Los resultados esperados de esta query son:

-- Sin subconsulta correlacionada
SELECT product_name AS 'Ten Most Expensive Products', unit_price AS 'Unit Price'
FROM products
ORDER BY unit_price DESC
LIMIT 10;

-- Con subconsulta correlacionada
SELECT product_name AS 'Ten Most Expensive Products', unit_price AS 'Unit Price'
FROM products AS p1
WHERE p1.unit_price > ANY (SELECT unit_price
						FROM products AS p2)
ORDER BY unit_price DESC
LIMIT 10;


#BONUS:
#Qué producto es más popular
#Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.

SELECT products.product_id, products.product_name AS 'Product Name', SUM(order_details.quantity) AS 'Total Quantity'
FROM products JOIN order_details
WHERE products.product_id = order_details.product_id
GROUP BY products.product_id
HAVING products.product_id IN (SELECT product_id
								FROM order_details AS o1
								GROUP BY product_id
								HAVING SUM(quantity) >= ALL (SELECT SUM(quantity)         
															FROM order_details AS o2
															GROUP BY product_id));
                                                            
	


