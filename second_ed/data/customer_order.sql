-- This is to show a customer's ordering history
-- param (customer_id,)


SELECT o.customer_id, o.order_id, s.store_name, o.order_time, o.order_status
FROM (
    SELECT * FROM `order` WHERE customer_id = %s
) AS o
JOIN `store` AS s ON o.store_id = s.store_id;



