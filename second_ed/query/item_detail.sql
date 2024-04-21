-- This is to show the certain item is included in which stores and the item details
-- Parameters: (item_search(string),)

use `proj`;
SET @item_search = '%s';
SELECT i.item_name, s.store_name, s.store_id, s.store_address, i.item_id, i.item_price, i.item_type, i.item_inventory
FROM (
    SELECT * FROM `item`
    WHERE item_name = @item_search OR item_type = @item_search
) i
JOIN `store` s ON i.store_id = s.store_id;
