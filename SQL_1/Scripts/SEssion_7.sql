USE magist;

SELECT COUNT(*) AS orders_count
FROM orders;


SELECT 
    order_status, 
    COUNT(*) AS orders
FROM
    orders
GROUP BY order_status;

SELECT 
    YEAR(order_purchase_timestamp) AS year_,
    MONTH(order_purchase_timestamp) AS month_,
    COUNT(customer_id)
FROM
    orders
GROUP BY year_ , month_
ORDER BY year_ , month_;

SELECT 
    COUNT(DISTINCT product_id) AS products_count
FROM
    products;
    
    SELECT 
    product_category_name, 
    COUNT(product_id) AS n_products
FROM
    products
GROUP BY product_category_name
ORDER BY COUNT(product_id) DESC;

SELECT *
FROM products;


SELECT 
	count(DISTINCT product_id) AS n_products
FROM
	order_items;
    
   SELECT 
    
    MIN(price) AS cheapest, 
    MAX(price) AS expensive, AVG(price)
FROM 
	order_items;
    -- group by seller_id
    
    SELECT 
	MAX(payment_value) as highest,
    MIN(payment_value) as lowest
FROM
	order_payments;
    
    
    
    SELECT order_id, product_id, COUNT(DISTINCT product_id)
    from order_items;
    
    SELECT *
    from order_items;