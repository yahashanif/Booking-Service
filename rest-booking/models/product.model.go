package models

import (
	"fmt"
	"net/http"
	"rest-booking/db"
)

type Product struct {
	Id         int        `json:"id"`
	Name       string     `json:"name"`
	Categories Categories `json:"categories"`
	Stock      int        `json:"stock"`
	Harga      float64    `json:"harga"`
	ImageUrl   string     `json:"image_url"`
}

type Categories struct {
	Id   int    `json:"id"`
	Name string `json:"name"`
}

func FetchAllProduct() (Response, error) {
	var obj Product

	var arrobj []Product

	var res Response

	con := db.CreateCon()

	sqlStatement := "SELECT products.id, products.name, categories.id as id_kat, categories.name as name_kat, products.stock, products.harga,products.image_url FROM products inner join categories on products.id_kat = categories.id"

	rows, err := con.Query(sqlStatement)

	if err != nil {
		return res, err
	}

	for rows.Next() {
		err = rows.Scan(&obj.Id, &obj.Name, &obj.Categories.Id, &obj.Categories.Name, &obj.Stock, &obj.Harga, &obj.ImageUrl)
		if err != nil {
			return res, err
		}
		arrobj = append(arrobj, obj)
	}

	res.Status = http.StatusOK
	res.Message = "Success"
	res.Data = arrobj

	return res, nil
}

func StoreProduct(product Product) (Response, error) {
	var res Response

	con := db.CreateCon()
	fmt.Println(product)

	sqlStatement := "INSERT INTO `products` ( `name`, `id_kat`, `stock`, `harga`, `image_url`) VALUES ( ?, ?, ?, ?, ?);"

	stmt, err := con.Prepare(sqlStatement)
	if err != nil {
		return res, err
	}

	result, err := stmt.Exec(product.Name, product.Categories.Id, product.Stock, product.Harga, product.ImageUrl)
	if err != nil {
		return res, err
	}

	lastInsertedID, err := result.LastInsertId()
	if err != nil {
		return res, err

	}

	res.Status = http.StatusOK
	res.Message = "Success"
	res.Data = map[string]int64{
		"last_inserted_id": lastInsertedID,
	}

	return res, nil

}

func UpdateProduct(product Product) (Response, error) {
	var res Response

	con := db.CreateCon()
	fmt.Println(product)

	sqlStatement := "UPDATE `products` SET `name` = ?, `id_kat` = ?, `stock` = ?, `harga` = ?, `image_url` = ? WHERE `products`.`id` = ?"

	stmt, err := con.Prepare(sqlStatement)

	if err != nil {
		return res, err
	}

	result, err := stmt.Exec(product.Name, product.Categories.Id, product.Stock, product.Harga, product.ImageUrl, product.Id)
	if err != nil {
		return res, err
	}

	rowsAffected, err := result.RowsAffected()

	if err != nil {
		return res, err
	}

	res.Status = http.StatusOK
	res.Message = "Success"
	res.Data = map[string]int64{
		"rows_affected": rowsAffected,
	}

	return res, nil

}

func DeleteProduct(id int) (Response, error) {
	var res Response

	con := db.CreateCon()

	sqlStatement := "DELETE FROM products WHERE id = ?"

	stmt, err := con.Prepare(sqlStatement)

	if err != nil {
		return res, err

	}

	result, err := stmt.Exec(id)

	if err != nil {
		return res, err
	}

	rowsAffected, err := result.RowsAffected()

	if err != nil {
		return res, err
	}

	res.Status = http.StatusOK
	res.Message = "Success"
	res.Data = map[string]int64{
		"row_Affected": rowsAffected,
	}

	return res, nil
}
