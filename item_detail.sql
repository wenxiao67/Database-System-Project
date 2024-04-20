-- This is to show the certain item is included in which stores and the item details
-- Parameters: (item_name(string),)

use `proj`;
SELECT s.store_id, s.store_name, s.store_address, i.item_id, i.item_name, i.item_price, i.item_type, i.item_inventory
FROM (
    SELECT * FROM `item`
    WHERE item_name = '%s'
) i
JOIN `store` s ON i.store_id = s.store_id;
