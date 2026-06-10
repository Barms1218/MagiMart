package main

import (
	"context"
	"log"

	"github.com/jackc/pgx/v5/pgxpool"
)

func main() {
	bgCtx := context.Background()
	connString := "postgres://shopkeeper:arcane_password_123@localhost:5432/pawnshop?sslmode=disablepostgres://shopkeeper:arcane_password_123@localhost:5432/pawnshop?sslmode=disable"

	dbConn, err := pgxpool.New(bgCtx, connString)
	if err != nil {
		log.Fatalf("Database connection error: %v", err)
	}

}
