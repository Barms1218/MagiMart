-- +goose Up
CREATE TABLE items (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	name TEXT NOT NULL,
	effect TEXT NOT NULL,
	damage SMALLINT NOT NULL,
	item_type TEXT NOT NULL,
	rental_fee INTEGER NOT NULL,
	maximum_uses SMALLINT NOT NULL,
	remaining_uses SMALLINT NOT NULL,
	loaned BOOLEAN DEFAULT FALSE,
	created_on TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_on TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_item_status_ ON items(loaned);

-- +goose Down
DROP TABLE items;
