-- This is to show a customer's ordering history
-- Parameters: (customer_id(int),)

USE `proj`;
SELECT o.order_id, o.order_time, o.order_status, i.item_name, oi.quantity
FROM (
    SELECT * FROM `order`
    WHERE customer_id = %s
) o
JOIN `order_item` oi ON o.order_id = oi.order_id
JOIN `item` i ON oi.item_id = i.item_id;


