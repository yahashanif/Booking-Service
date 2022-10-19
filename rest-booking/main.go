package main

import (
	"rest-booking/db"
	"rest-booking/routes"
)

func main() {
	db.Init()
	e := routes.Init()
	e.Start(":9000")
}
