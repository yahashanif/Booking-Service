package models

import (
	"fmt"
	"net/http"
	"rest-booking/db"
	"strconv"
)

type Booking struct {
	Id             int             `json:"id"`
	Pelanggan      Pelanggan       `json:"pelanggan"`
	TglBooking     string          `json:"tgl_booking"`
	DetailBookings []DetailBooking `json:detail_bookings`
	Total          float64         `json:"total"`
}

type DetailBooking struct {
	IdBooking int     `json:"id_booking"`
	Product   Product `json:"product"`
	Qty       int     `json:"qty"`
	Subtotal  float64 `json:"subtotal"`
}

type RequestBooking struct {
	DetailBookings []struct {
		Product struct {
			ID int64 `json:"id"`
		} `json:"product"`
		Qty int `json:"qty"`
	} `json:"detail_bookings"`
	IdPelanggan string `json:"id_pelanggan"`
	TglBooking  string `json:"tgl_booking"`
}

type UpdateRequestBooking struct {
	IDBooking      int `json:"id_booking"`
	DetailBookings []struct {
		Product struct {
			ID int64 `json:"id"`
		} `json:"product"`
		Qty int `json:"qty"`
	} `json:"detail_bookings"`
	IdPelanggan string `json:"id_pelanggan"`
	TglBooking  string `json:"tgl_booking"`
}

func FetchAllBooking() (Response, error) {
	var obj Booking

	var arrObj []Booking

	var res Response
	var detailBooking DetailBooking
	var p Pelanggan
	con := db.CreateCon()

	sqlStatement := "SELECT * FROM `booking`"

	rows, err := con.Query(sqlStatement)

	if err != nil {
		return res, err
	}
	n := 0
	for rows.Next() {
		n++
		var arrDetailBooking []DetailBooking

		err = rows.Scan(&obj.Id, &obj.Pelanggan.Id, &obj.TglBooking, &obj.Total)
		if err != nil {
			return res, err
		}

		sqlStatementPe := "Select * from pelanggan where id =" + strconv.Itoa(obj.Pelanggan.Id)
		fmt.Println(sqlStatementPe)
		rowsPelanggan, err := con.Query(sqlStatementPe)

		if err != nil {
			return res, err
		}
		for rowsPelanggan.Next() {
			err = rowsPelanggan.Scan(&p.Id, &p.Name, &p.NoHp, &p.Alamat)
			if err != nil {
				return res, err
			}
		}
		obj.Pelanggan = p

		sqlStatementDetails := "Select * from `detail_booking` where id_booking = " + strconv.Itoa(obj.Id)
		rowsDetails, err := con.Query(sqlStatementDetails)
		if err != nil {
			return res, err
		}

		for rowsDetails.Next() {
			var idProduct int
			err = rowsDetails.Scan(&detailBooking.IdBooking, &idProduct, &detailBooking.Qty, &detailBooking.Subtotal)
			if err != nil {
				return res, err
			}

			sqlStatementProduct := "Select products.id,products.name,categories.id,categories.name,products.stock,products.harga,products.image_url from products inner join categories on products.id_kat = categories.id where products.id=" + strconv.Itoa(idProduct)
			fmt.Println(sqlStatementProduct)
			con.QueryRow(sqlStatementProduct).Scan(&detailBooking.Product.Id, &detailBooking.Product.Name, &detailBooking.Product.Categories.Id, &detailBooking.Product.Categories.Name, &detailBooking.Product.Stock, &detailBooking.Product.Harga, &detailBooking.Product.ImageUrl)

			arrDetailBooking = append(arrDetailBooking, detailBooking)
		}
		obj.DetailBookings = arrDetailBooking
		fmt.Println(n)
		arrObj = append(arrObj, obj)
	}
	res.Status = http.StatusOK
	res.Message = "Success"
	res.Data = arrObj

	return res, nil

}
func FetchAllBookingFilter(tgl string) (Response, error) {
	var obj Booking

	var arrObj []Booking
	var p Pelanggan

	var res Response
	var detailBooking DetailBooking

	con := db.CreateCon()

	sqlStatement := "SELECT * FROM `booking` where tgl_booking ='" + tgl + "'"

	rows, err := con.Query(sqlStatement)

	if err != nil {
		return res, err
	}
	for rows.Next() {
		var arrDetailBooking []DetailBooking

		err = rows.Scan(&obj.Id, &obj.Pelanggan.Id, &obj.TglBooking, &obj.Total)
		if err != nil {
			return res, err
		}

		sqlStatementPe := "Select * from pelanggan where id =" + strconv.Itoa(obj.Pelanggan.Id)

		rowsPelanggan, err := con.Query(sqlStatementPe)

		if err != nil {
			return res, err
		}
		for rowsPelanggan.Next() {
			err = rowsPelanggan.Scan(&p.Id, &p.Name, &p.NoHp, &p.Alamat)
			if err != nil {
				return res, err
			}
		}
		obj.Pelanggan = p

		sqlStatementDetails := "Select * from `detail_booking` where id_booking = " + strconv.Itoa(obj.Id)
		rowsDetails, err := con.Query(sqlStatementDetails)
		if err != nil {
			return res, err
		}

		for rowsDetails.Next() {
			var idProduct int
			err = rowsDetails.Scan(&detailBooking.IdBooking, &idProduct, &detailBooking.Qty, &detailBooking.Subtotal)
			if err != nil {
				return res, err
			}

			sqlStatementProduct := "Select products.id,products.name,categories.id,categories.name,products.stock,products.harga,products.image_url from products inner join categories on products.id_kat = categories.id where products.id=" + strconv.Itoa(idProduct)
			fmt.Println(sqlStatementProduct)
			con.QueryRow(sqlStatementProduct).Scan(&detailBooking.Product.Id, &detailBooking.Product.Name, &detailBooking.Product.Categories.Id, &detailBooking.Product.Categories.Name, &detailBooking.Product.Stock, &detailBooking.Product.Harga, &detailBooking.Product.ImageUrl)

			arrDetailBooking = append(arrDetailBooking, detailBooking)
		}
		obj.DetailBookings = arrDetailBooking

		arrObj = append(arrObj, obj)
	}
	res.Status = http.StatusOK
	res.Message = "Success"
	res.Data = arrObj

	return res, nil

}

func StoreBoking(booking RequestBooking) (Response, error) {
	var res Response
	con := db.CreateCon()

	sqlStatement := "INSERT INTO `booking` ( `id_pelanggan`, `tgl_booking`, `total`) VALUES (?,?, NULL)"

	stmt, err := con.Prepare(sqlStatement)
	if err != nil {
		return res, err
	}

	result, err := stmt.Exec(booking.IdPelanggan, booking.TglBooking)
	if err != nil {
		return res, err
	}

	lastInsertedID, err := result.LastInsertId()
	if err != nil {
		return res, err

	}
	var total float64
	for _, v := range booking.DetailBookings {
		var product Product
		sqlStatementproduct := "SELECT products.id, products.name, categories.id as id_kat, categories.name as name_kat, products.stock, products.harga,products.image_url FROM products inner join categories on products.id_kat = categories.id where products.id = " + strconv.Itoa(int(v.Product.ID))
		con.QueryRow(sqlStatementproduct).Scan(&product.Id, &product.Name, &product.Categories.Id, &product.Categories.Name, &product.Stock, &product.Harga, &product.ImageUrl)
		subtotal := float64(v.Qty) * float64(product.Harga)
		sqlStatementDetail := "INSERT INTO `detail_booking` (`id_booking`, `id_product`, `qty`, `subtotal`) VALUES (?, ?, ?, ?);"
		stmt, err := con.Prepare(sqlStatementDetail)
		if err != nil {
			return res, err
		}
		var stoklama int
		sqlstokcek := "select stock from products where id=" + strconv.Itoa(int(v.Product.ID))
		con.QueryRow(sqlstokcek).Scan(&stoklama)
		sqlUpdateTotal := "UPDATE `products` SET `stock` = '" + strconv.Itoa(stoklama-v.Qty) + "' WHERE `products`.`id` =  " + strconv.Itoa(int(v.Product.ID))
		fmt.Println(strconv.Itoa(stoklama - v.Qty))
		_, err = con.Exec(sqlUpdateTotal)
		if err != nil {
			return res, err
		}

		_, err = stmt.Exec(lastInsertedID, v.Product.ID, v.Qty, subtotal)
		if err != nil {
			return res, err
		}
		total += subtotal
	}
	Stotal := fmt.Sprintf("%f", total)
	sqlUpdateTotal := "UPDATE `booking` SET `total` = " + Stotal + " WHERE `booking`.`id` = " + strconv.Itoa(int(lastInsertedID))

	_, err = con.Exec(sqlUpdateTotal)
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

func UpdateBoking(booking UpdateRequestBooking) (Response, error) {
	var res Response

	con := db.CreateCon()
	fmt.Println(booking)

	sqlStatementDetaildelete := "DELETE from detail_booking where id_booking = " + strconv.Itoa(booking.IDBooking)
	con.Exec(sqlStatementDetaildelete)
	sqlStatement := "UPDATE `booking` SET `id_pelanggan` = ?, `tgl_booking` = ?, `total` = NULL WHERE `booking`.`id` = ?"

	stmt, err := con.Prepare(sqlStatement)
	if err != nil {
		return res, err
	}

	stmt.Exec(booking.IdPelanggan, booking.TglBooking, booking.IDBooking)

	lastInsertedID := booking.IDBooking

	var total float64
	for _, v := range booking.DetailBookings {
		var product Product
		sqlStatementproduct := "SELECT products.id, products.name, categories.id as id_kat, categories.name as name_kat, products.stock, products.harga,products.image_url FROM products inner join categories on products.id_kat = categories.id where products.id = " + strconv.Itoa(int(v.Product.ID))
		con.QueryRow(sqlStatementproduct).Scan(&product.Id, &product.Name, &product.Categories.Id, &product.Categories.Name, &product.Stock, &product.Harga, &product.ImageUrl)
		subtotal := float64(v.Qty) * float64(product.Harga)
		sqlStatementDetail := "INSERT INTO `detail_booking` (`id_booking`, `id_product`, `qty`, `subtotal`) VALUES (?, ?, ?, ?);"
		stmt, err := con.Prepare(sqlStatementDetail)
		if err != nil {
			return res, err
		}
		_, err = stmt.Exec(lastInsertedID, v.Product.ID, v.Qty, subtotal)
		if err != nil {
			return res, err
		}
		total += subtotal
	}
	Stotal := fmt.Sprintf("%f", total)
	sqlUpdateTotal := "UPDATE `booking` SET `total` = " + Stotal + " WHERE `booking`.`id` = " + strconv.Itoa(int(lastInsertedID))

	_, err = con.Exec(sqlUpdateTotal)
	if err != nil {
		return res, err
	}
	res.Status = http.StatusOK
	res.Message = "Success"
	res.Data = map[string]int{
		"last_inserted_id": lastInsertedID,
	}

	return res, nil

}

func DeleteBooking(id int) (Response, error) {

	var res Response

	con := db.CreateCon()

	sqlStatement := "DELETE FROM booking WHERE id = ?"

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

	sqlStatementDelete := "DELETE FROM detail_booking where id_booking = ?"
	stmt, err = con.Prepare(sqlStatementDelete)

	if err != nil {
		return res, err

	}

	_, err = stmt.Exec(id)

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
