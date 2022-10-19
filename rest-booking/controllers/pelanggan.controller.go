package controllers

import (
	"net/http"
	"rest-booking/models"
	"strconv"

	"github.com/labstack/echo/v4"
)

func FetchAllPelanggan(c echo.Context) error {

	result, err := models.FetchAllPelanggan()

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": err.Error()})
	}
	return c.JSON(http.StatusOK, result)
}

func StorePelanggan(c echo.Context) error {
	var obj models.Pelanggan
	err := c.Bind(&obj)
	if err != nil {
		return c.String(http.StatusBadRequest, "bad request")
	}

	result, err := models.StorePelanggan(obj)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	return c.JSON(http.StatusOK, result)
}

func UpdatePelanggan(c echo.Context) error {
	var obj models.Pelanggan
	err := c.Bind(&obj)
	if err != nil {
		return c.String(http.StatusBadRequest, "bad request")
	}

	result, err := models.UpdatePelanggan(obj)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	return c.JSON(http.StatusOK, result)
}

func DeletePelanggan(c echo.Context) error {
	id := c.FormValue("id")

	idInt, err := strconv.Atoi(id)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	result, err := models.DeletePelanggan(idInt)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())

	}

	return c.JSON(http.StatusOK, result)
}
