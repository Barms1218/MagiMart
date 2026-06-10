-- +goose Up

CREATE TYPE rental_status AS ENUM ('active', 'returned', 'overdue');
CREATE TABLE rentals (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	item_id UUID REFERENCES items(id) ON DELETE SET NULL,
	customer TEXT NOT NULL,
	rental_fee INTEGER NOT NULL,
	status rental_status NOT NULL DEFAULT 'active',
	rented_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
	due_at TIMESTAMPTZ NOT NULL DEFAULT (NOW() + INTERVAL '1 week'),
	returned_at TIMESTAMPTZ 
);

CREATE INDEX idx_rentals_status ON rentals(status);
CREATE INDEX idx_rentals_due_at ON rentals(due_at) WHERE status = 'active';

-- +goose Down
DROP TABLE transactions;
DROP TYPE rental_status;
