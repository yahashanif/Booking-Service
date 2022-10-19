package controllers

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"rest-booking/db"
	"rest-booking/models"
	"strconv"

	"github.com/labstack/echo/v4"
)

func FetchAllProduct(c echo.Context) error {

	result, err := models.FetchAllProduct()

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": err.Error()})
	}
	return c.JSON(http.StatusOK, result)
}

func StoreProduct(c echo.Context) error {
	var obj models.Product
	// err := c.Bind(&obj)
	// if err != nil {
	// 	return c.String(http.StatusBadRequest, "bad request")
	// }
	name := c.FormValue("name")
	idCategori := c.FormValue("id_categori")
	stock := c.FormValue("stock")
	harga := c.FormValue("harga")
	var imageUrl string
	form, err := c.MultipartForm()
	if err != nil {
		return err
	}
	files := form.File["files"]

	for _, file := range files {
		// Source
		src, err := file.Open()
		if err != nil {
			return err
		}
		defer src.Close()

		// Destination
		dst, err := os.Create("file/" + file.Filename)
		imageUrl = file.Filename
		if err != nil {
			return err
		}
		defer dst.Close()

		// Copy
		if _, err = io.Copy(dst, src); err != nil {
			return err
		}

	}
	obj.Name = name
	obj.Categories.Id, _ = strconv.Atoi(idCategori)
	obj.Stock, _ = strconv.Atoi(stock)
	obj.Harga, _ = strconv.ParseFloat(harga, 64)
	obj.ImageUrl = imageUrl
	result, err := models.StoreProduct(obj)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}
	return c.JSON(http.StatusOK, result)
}

func UpdateProductWithImage(c echo.Context) error {
	var obj models.Product
	con := db.CreateCon()
	id := c.FormValue("id")
	var imagename string
	sqlStatementCek := "Select image_url from products where id=" + id
	con.QueryRow(sqlStatementCek).Scan(&imagename)
	// err := c.Bind(&obj)
	// if err != nil {
	// 	return c.String(http.StatusBadRequest, "bad request")
	// }
	name := c.FormValue("name")
	idCategori := c.FormValue("id_categori")
	stock := c.FormValue("stock")
	harga := c.FormValue("harga")
	var imageUrl string
	form, err := c.MultipartForm()
	if err != nil {
		return err
	}
	files := form.File["files"]

	for _, file := range files {
		// Source
		src, err := file.Open()
		if err != nil {
			return err
		}
		defer src.Close()

		// Destination
		dst, err := os.Create("file/" + file.Filename)
		imageUrl = file.Filename
		if err != nil {
			return err
		}
		defer dst.Close()

		// Copy
		if _, err = io.Copy(dst, src); err != nil {
			return err
		}

	}
	os.Remove("file/" + imagename)
	obj.Id, _ = strconv.Atoi(id)
	obj.Name = name
	obj.Categories.Id, _ = strconv.Atoi(idCategori)
	obj.Stock, _ = strconv.Atoi(stock)
	obj.Harga, _ = strconv.ParseFloat(harga, 64)
	obj.ImageUrl = imageUrl
	result, err := models.UpdateProduct(obj)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}
	return c.JSON(http.StatusOK, result)
}
func UpdateProductWithoutImage(c echo.Context) error {
	var obj models.Product
	con := db.CreateCon()
	id := c.FormValue("id")
	var imagename string
	sqlStatementCek := "Select image_url from products where id=" + id
	fmt.Println(sqlStatementCek)
	con.QueryRow(sqlStatementCek).Scan(&imagename)
	// err := c.Bind(&obj)
	// if err != nil {
	// 	return c.String(http.StatusBadRequest, "bad request")
	// }
	name := c.FormValue("name")
	idCategori := c.FormValue("id_categori")
	stock := c.FormValue("stock")
	harga := c.FormValue("harga")
	obj.Id, _ = strconv.Atoi(id)
	obj.Name = name
	obj.Categories.Id, _ = strconv.Atoi(idCategori)
	obj.Stock, _ = strconv.Atoi(stock)
	obj.Harga, _ = strconv.ParseFloat(harga, 64)
	obj.ImageUrl = imagename
	result, err := models.UpdateProduct(obj)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}
	return c.JSON(http.StatusOK, result)
}

func DeleteProduct(c echo.Context) error {
	id := c.FormValue("id")

	idInt, err := strconv.Atoi(id)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	result, err := models.DeleteProduct(idInt)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())

	}

	return c.JSON(http.StatusOK, result)
}
