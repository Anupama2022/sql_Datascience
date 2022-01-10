use magist;

SELECT *
FROM products;

CREATE TABLE with_price_del
SELECT products.product_id, products.product_category_name, price

FROM products
JOIN order_items ON products.product_id = order_items.product_id
WHERE price > 4000
group by product_category_name
order by price DESC;


select COUNT(seller_id)
from sellers;

SELECT *
FROM product_category_name_translation;
USE magist;
CREATE TABLE ti_delete_plz 
SELECT product_category_name_translation.product_category_name_english , products.product_category_name, product_id, COUNT(product_category_name_english)
FROM product_category_name_translation
 JOIN products ON product_category_name_translation.product_category_name = products.product_category_name

 GROUP BY product_category_name_english;
 
 
SELECT *,
  CASE
		WHEN product_category_name IN ("audio", "informatica_acessorios", "pcs", "cool_stuff", "eletronicos", "pc_gamer") THEN "tech"
		ELSE "other"
	END AS "tech"
    FROM ti_delete_plz;
    

   
SELECT *
FROM with_price_del;

SELECT *
FROM  ti_delete_plz;

SELECT *
FROM  ti_delete_plz
JOIN with_price_del USING (product_id);


SELECT ti_delete_plz.product_id, with_price_del.product_category_name, price

FROM ti_delete_plz
JOIN with_price_del ON ti_delete_plz.product_id = with_price_del.product_id
-- WHERE price > 1000
group by product_category_name
order by price DESC;