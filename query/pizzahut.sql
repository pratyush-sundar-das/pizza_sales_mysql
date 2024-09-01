-- Retrieve the total number of orders placed.
SELECT COUNT(order_id) AS total_orders
FROM orders;

-- Calculate the total revenue generated from pizza sales.
SELECT ROUND(SUM(orders_details.quantity * pizzas.price),2) AS totals_sales
FROM orders_details
JOIN pizzas ON pizzas.pizza_id = orders_details.pizza_id;

-- Identify the highest-priced pizza.

SELECT pizza_types.name, pizzas.price
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.

SELECT pizzas.size, count(orders_details.order_details_id) as order_count
FROM pizzas JOIN orders_details
ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size order by order_count DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.

SELECT pizza_types.name, SUM(orders_details.quantity) AS QUANTITY
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN orders_details
ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT pizza_types.category, SUM(orders_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

-- Determine the distribution of orders by hour of the day.

SELECT HOUR(order_time) as HOUR, COUNT(order_id) AS order_count
FROM orders
GROUP BY HOUR;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT ROUND(AVG(quantity), 0) AS avg_pizza_ordered_per_day
FROM
(SELECT orders.order_date AS date,
SUM(orders_details.quantity) AS quantity
FROM orders
JOIN orders_details ON orders.order_id = orders_details.order_id
GROUP BY date
) AS order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.name, SUM(orders_details.quantity * pizzas.price) AS revenue
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;









