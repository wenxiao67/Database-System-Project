-- This is to show a customer's ordering history
-- param (customer_id,)

WITH tmp AS (
    SELECT *
    FROM `order`
    WHERE customer_id = %s
)
SELECT tmp.*, customer.*
FROM tmp
JOIN customer ON tmp.customer_id = customer.customer_id;



