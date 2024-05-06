-- This is to show order_details
-- Within a specific order, we can display all the item details
-- param (order_id,)

use `proj`;

SELECT `order`.`order_id`, `item`.`item_name`,`order_item`.`item_id`,`store`.`store_name`,
    `order_item`.`quantity`,`order`.`customer_id`,
    `order`.`order_time`,`order`.`order_status`,
    `item`.`item_price`,`item`.`item_type`,`item`.`item_inventory`
FROM `order_item`
LEFT JOIN `order`
ON `order_item`.`order_id` = `order`.`order_id`
RIGHT JOIN `item`
ON `order_item`.`item_id` = `item`.`item_id`
INNER JOIN `store`
ON `order_item`.`store_id` = `store`.`store_id`
WHERE `order`.`order_id` = %s
