-- This is to show certain store details (items in the store)
-- param (store_id,)


SELECT `item`.item_id, `item`.item_name, `item`.item_price, `item`.item_type, `item`.item_inventory
FROM `item`
WHERE store_id = %s;
