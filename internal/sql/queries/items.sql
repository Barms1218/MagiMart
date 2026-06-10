-- name: EnchantItem :one
INSERT INTO items (
name,
effect,
damage,
item_type,
rental_fee,
maximum_uses,
remaining_uses ) VALUES (
$1, $2, $3, $4, $5, $6, $6
) RETURNING id, name, effect, damage, item_type, maximum_uses, remaining_uses;

-- name: RentItem :exec
INSERT INTO rentals (
item_id,
customer,
rental_fee) VALUES (
$1,
$2,
$3
);

-- name: UpdateRentalStatus :exec
UPDATE rentals
SET returned_at = CURRENT_TIMESTAMP, status = 'returned'
WHERE id = $1;

-- name: UpdateItemAStatus :exec
UPDATE items
SET loaned = $1, updated_at = CURRENT_TIMESTAMP
WHERE id = $2;
