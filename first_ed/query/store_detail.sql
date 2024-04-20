-- This is to show certain store details (items in the store)
-- param (store_id,)

WITH tmp AS (
	SELECT *
	FROM `store`
	WHERE store_id = %s
)
SELECT tmp.*, item.*
FROM tmp
JOIN item ON tmp.store_id = item.store_id
