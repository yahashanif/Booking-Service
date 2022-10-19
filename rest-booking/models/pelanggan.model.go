package models

import (
	"net/http"
	"rest-booking/db"
)

type Pelanggan struct {
	Id     int    `json:"id"`
	Name   string `json:"name"`
	NoHp   string `json:"no_hp"`
	Alamat string `json:"alamat"`
}

func FetchAllPelanggan() (Response, error) {
	var obj Pelanggan

	var arrobj []Pelanggan

	var res Response

	con := db.CreateCon()

	sqlStatement := "SELECT * FROM pelanggan"

	rows, err := con.Query(sqlStatement)
	defer rows.Close()

	if err != nil {
		return res, err
	}

	for rows.Next() {
		err = rows.Scan(&obj.Id, &obj.Name, &obj.NoHp, &obj.Alamat)
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

func StorePelanggan(pelanggan Pelanggan) (Response, error) {
	var res Response

	con := db.CreateCon()

	sqlStatement := "INSERT pelanggan (name,no_hp, alamat) VALUES (?,?,?)"

	stmt, err := con.Prepare(sqlStatement)
	if err != nil {
		return res, err
	}

	result, err := stmt.Exec(pelanggan.Name, pelanggan.NoHp, pelanggan.Alamat)
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

func UpdatePelanggan(pelanggan Pelanggan) (Response, error) {
	var res Response

	con := db.CreateCon()

	sqlStatement := "UPDATE pelanggan SET name = ?, no_hp = ?, alamat = ? WHERE id = ? "

	stmt, err := con.Prepare(sqlStatement)

	if err != nil {
		return res, err
	}

	result, err := stmt.Exec(pelanggan.Name, pelanggan.NoHp, pelanggan.Alamat, pelanggan.Id)
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

func DeletePelanggan(id int) (Response, error) {
	var res Response

	con := db.CreateCon()

	sqlStatement := "DELETE FROM pelanggan WHERE id = ?"

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
