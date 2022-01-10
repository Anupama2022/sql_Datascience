
use magist;
SELECT 
    COUNT(DISTINCT product_category_name),
    CASE
        WHEN
            product_category_name IN ('audio' , 'informatica_acessorios',
                'pcs',
                'cool_stuff',
                'eletronicos',
                'pc_gamer')
        THEN
            'tech'
        ELSE 'other'
    END AS tech
FROM
    products
GROUP BY tech;
    
SELECT 
    COUNT(DISTINCT product_category_name)
FROM
    products;
    
    
-- What’s the average price of the products being sold?    
    
SELECT 
    AVG(oi.price), MAX(oi.price)
FROM
    order_items oi;

    
SELECT 
    AVG(oi.price), MAX(oi.price)
FROM
    order_items oi
        JOIN
    products p USING (product_id)
WHERE
    p.product_category_name IN ('audio' , 'informatica_acessorios',
        'pcs',
        'cool_stuff',
        'eletronicos',
        'pc_gamer');
 
-- Are expensive tech products popular? *
SELECT 
    COUNT(DISTINCT product_id)
FROM
    order_items oi
        JOIN
    products p USING (product_id)
WHERE
    p.product_category_name IN ('audio' , 'informatica_acessorios',
        'pcs',
        'cool_stuff',
        'eletronicos',
        'pc_gamer')
        AND price > 500;
 
SELECT 
    COUNT(DISTINCT product_id)
FROM
    order_items oi
        JOIN
    products p USING (product_id);



-- How many products of these tech categories have been sold (within the time window of the database snapshot)? What percentage does that represent from the overall number of products sold?
SELECT 
    COUNT(DISTINCT order_id)
FROM
    orders o
        JOIN
    order_items oi USING (order_id)
        JOIN
    products p USING (product_id)
WHERE
    p.product_category_name IN ('audio' , 'informatica_acessorios',
        'pcs',
        'cool_stuff',
        'eletronicos',
        'pc_gamer');
		-- OR p.product_category_name LIKE 'consoles_games'; -- 14459 -- 14% tech products
        
SELECT 
    COUNT(DISTINCT order_id)
FROM
    order_items oi
        JOIN
    products p USING (product_id);
 -- AND price > 500;

-- How many sellers are there?

SELECT 
    COUNT(DISTINCT seller_id)
FROM
    order_items;

-- average monthly revenue

WITH seller_revenue AS (
SELECT oi.seller_id, YEAR(o.order_approved_at), MONTH(o.order_approved_at), round(avg(oi.price), 2) AS revenue
FROM orders o
JOIN order_items oi
    USING (order_id)
GROUP BY 1, 2, 3
order by  2, 3  DESC)

SELECT AVG(revenue)
FROM seller_revenue; -- 157


WITH seller_revenue AS (SELECT oi.seller_id, p.product_category_name, month(o.order_purchase_timestamp), YEAR(o.order_purchase_timestamp), avg(oi.price) AS revenue
FROM orders o

JOIN order_items oi
    USING (order_id)
JOIN  products p 
	using (product_id)
where 
  product_category_name IN ("audio", "informatica_acessorios", "pcs", "cool_stuff", "eletronicos", "pc_gamer")
       group by 1)

	SELECT AVG(revenue)
FROM seller_revenue; --  239


-- In relation to the delivery time
SELECT *
FROM orders;

-- What’s the average time between the order being placed and the product being delivered?

SELECT 
    AVG(DATEDIFF(order_delivered_customer_date,
            order_approved_at))
FROM
    orders;

-- How many orders are delivered on time vs orders delivered with a delay?

WITH shipment_date AS (SELECT 
    order_id, 
    order_purchase_timestamp, order_estimated_delivery_date,
    order_delivered_customer_date, order_status,
    CASE
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date ) < 1
        THEN 'OnTime'
        ELSE 'Late'
    END shipment
    FROM orders
    ORDER BY order_estimated_delivery_date)
    SELECT COUNT(order_id)
    FROM shipment_date 
    where shipment = 'OnTime'; -- 88476
    
    
    
    WITH shipment_date AS (SELECT 
    order_id, 
    order_purchase_timestamp, order_estimated_delivery_date,
    order_delivered_customer_date, order_status,
    CASE
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date ) < 1
        THEN 'OnTime'
        ELSE 'Late'
    END shipment
    FROM orders
    ORDER BY order_estimated_delivery_date)
    
    SELECT COUNT(order_id)
    FROM shipment_date
    where shipment = 'Late'; -- 10965
   
   SELECT COUNT(*),
    CASE	
         WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date ) < 1 THEN 'OnTime'
        ELSE 'Late'
    END shipment
FROM orders
-- WHERE order_status = 'Delivered'
GROUP BY shipment;
    
    
   -- Is there any pattern for delayed orders, e.g. big products being delayed more often?
   -- No 88% percentage of products were delivered on time, irrespective of the size
    
SELECT count(*),
CASE
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date ) < 0 THEN 'OnTime'
        ELSE 'Late'
    END shipment
FROM orders o
        JOIN
    order_items oi USING (order_id)
        JOIN
    products p USING (product_id)
    
WHERE p.product_weight_g > 5000 OR p.product_length_cm*p.product_width_cm*p.product_height_cm > 5000
GROUP BY shipment;

SELECT count(*),
CASE
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date ) < 1 THEN 'OnTime'
        ELSE 'Late'
    END shipment
FROM orders o
        JOIN
    order_items oi USING (order_id)
        JOIN
    products p USING (product_id)
    WHERE p.product_length_cm*p.product_width_cm*p.product_height_cm > 5000
GROUP BY shipment;

-- SELECT product_length_cm*product_width_cm*product_height_cm 
-- FROM products;
    
SELECT 
    COUNT(DISTINCT product_id)
FROM
    order_items oi
        JOIN
    products p USING (product_id)
WHERE
    p.product_category_name IN ('audio' , 'informatica_acessorios',
        'pcs',
        'cool_stuff',
        'eletronicos',
        'pc_gamer',
        'consoles_games')
        AND price > 500;
    
    