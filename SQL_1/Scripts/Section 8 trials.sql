USE magist;
 CREATE TABLE orders_with_category_plz_del
 SELECT order_items.product_id, products.product_category_name 
 FROM
     order_items
         JOIN
     products ON order_items.product_id = products.product_id;

CREATE TABLE tech_table
SELECT
    orders_with_category_plz_del , 
    CASE
        WHEN product_category_name IN ("audio", "informatica_acessorios", "pcs", "cool_stuff", "eletronicos", "pc_gamer") THEN "tech"
        ELSE "other"
    END AS "tech"
FROM orders_with_category_plz_del;

SELECT COUNT() FROM magist.tech_table
WHERE (tech = 'tech'); -- 14966

SELECT COUNT() from order_items; -- 112650

SELECT ROUND(AVG(order_items.price), 2) AS "average"
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id; -- 120,65

SELECT order_status, COUNT(order_status) FROM orders
group by order_status;

SELECT ROUND(AVG(order_items.price), 2) AS "average"
FROM order_items; -- 120,65
USE magist;
 -- CREATE TABLE orders_with_category_plz_del SELECT order_items., products.product_category_name FROM
     -- order_items
         -- JOIN
    --  products ON order_items.product_id = products.product_id;

CREATE TABLE tech_table
SELECT
    orders_with_category_plz_del.,
    CASE
        WHEN product_category_name IN ("audio", "informatica_acessorios", "pcs", "cool_stuff", "eletronicos", "pc_gamer") THEN "tech"
        ELSE "other"
    END AS "tech"
FROM orders_with_category_plz_del;

SELECT COUNT() FROM magist.tech_table
WHERE (tech = 'tech');
-- 14966

SELECT COUNT()
 from order_items; -- 112650

SELECT ROUND(AVG(order_items.price), 2) AS "average"
FROM order_items; -- 120,65