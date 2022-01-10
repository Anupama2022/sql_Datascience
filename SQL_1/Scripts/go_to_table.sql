create table go_to_tableau AS (
SELECT 
    oi.seller_id,
    order_approved_at,
    -- YEAR(order_approved_at) AS my_year,
    -- MONTH(order_approved_at) AS my_month,
    op.payment_value as revenue
FROM
    orders o
        JOIN
    order_items oi ON o.order_id = oi.order_id
    JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY seller_id);