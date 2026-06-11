-- name: InsertItem :one
INSERT INTO items (
name,
effect,
damage,
item_type,
rental_fee,
maximum_uses,
remaining_uses ) VALUES (
$1, $2, $3, $4, $5, $6, $6
) RETURNING *;

-- name: InsertRental :exec
INSERT INTO rentals (
item_id,
customer,
rental_fee) VALUES (
$1,
$2,
$3);

-- name: ListItemsByType :many
SELECT * FROM items
WHERE remaining_uses > 0;

-- name: ListOverdueRentals :manyy
SELECT * FROM rentals
WHERE status = 'overdue';

-- name: ListItemsByPriceDesc :many
SELECT * FROM items
ORDER BY rental_free DESC;

-- name: ListItemsByPriceAsc :many
SELECT * FROM items
ORDER BY rental_free ASC;

-- name: ListActiveRentals :many
SELECT * FROM rentals
WHERE status = 'active' OR status = 'overdue';

-- name: ListRentalsByFeeDesc :many
SELECT * FROM rentals
ORDER BY rental_fee DESC;

-- name: ListRentalsByFeeAsc :many
SELECT * FROM rentals
ORDER BY rental_fee ASC;

-- name: UpdateRentalStatus :exec
UPDATE rentals
SET status = $1, 
returned_at = CURRENT_TIMESTAMP
WHEN status = 'returned'
ELSE returned_at
WHERE id = $2;

-- name: UpdateItemAStatus :exec
UPDATE items
SET status = $1, updated_at = CURRENT_TIMESTAMP
WHERE id = $2;

-- name: UpdateItemUses :exec
UPDATE items
SET remaining_uses = $1, updated_on = CURRENT_TIMESTAMP
WHERE id = $1;

-- name: UpdateItemLoaned :exec
UPDATE items
SET loaned = $1, updated_on = CURRENT_TIMESTAMP
WHERE id = $2

-- name: SetRentalsOverdue :many
UPDATE rentals
SET status = 'overdue' 
WHERE status = 'active' AND due_at < CURRENT_TIMESTAMP
returning *;
