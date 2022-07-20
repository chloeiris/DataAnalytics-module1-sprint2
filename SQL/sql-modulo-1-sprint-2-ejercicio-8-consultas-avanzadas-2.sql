USE northwind;

-- Ejercicio 1
-- Desde logística nos piden el número de pedidos y la máxima cantidad de 
-- carga de entre los mismos (freight) que han sido enviados por cada empleado (mostrando el ID de empleado en cada caso
SELECT COUNT(`order_id`) AS NumerodePedidos, MAX(freight), `employee_id`
FROM orders
GROUP BY `employee_id`;

-- Ejercicio 2
-- Una vez han revisado los datos de la consulta anterior, nos han pedido afinar un poco más el "disparo". 
-- En el resultado anterior se han incluido muchos pedidos cuya fecha de envío estaba vacía, 
-- por lo que tenemos que mejorar la consulta en este aspecto. También nos piden que ordenemos los resultados según el ID de empleado para que la visualización sea más sencilla.
SELECT COUNT(`order_id`) AS NumerodePedidos, MAX(freight), `employee_id`
FROM orders
WHERE `shipped_date`!= 0
GROUP BY `employee_id`
ORDER BY `employee_id`;

-- Ejercicio 3
-- El siguiente paso en el análisis de los pedidos va a consistir en conocer mejor la distribución de los mismos según las fechas. 
-- Por lo tanto, tendremos que generar una consulta que nos saque el número de pedidos para cada día, mostrando de manera separada el día (DAY()), el mes (MONTH()) y el año (YEAR()).
SELECT COUNT(`order_id`) AS NumerodePedidos, DAY(`shipped_date`), MONTH(`shipped_date`), YEAR(`shipped_date`)
FROM orders
WHERE `shipped_date`IS NOT NULL
GROUP BY `shipped_date`
ORDER BY `shipped_date`;

-- Ejercicio 4
-- La consulta anterior nos muestra el número de pedidos para cada día concreto, pero esto es demasiado detalle. 
-- Genera una modificación de la consulta anterior para que agrupe los pedidos por cada mes concreto de cada año.
SELECT COUNT(`order_id`) AS NumerodePedidos, MONTH(`shipped_date`), YEAR(`shipped_date`)
FROM orders
WHERE `shipped_date`IS NOT NULL
GROUP BY MONTH(`shipped_date`)
ORDER BY `shipped_date`;
