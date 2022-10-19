package controllers

import (
	"fmt"
	"net/http"
	"rest-booking/models"
	"strconv"

	"github.com/labstack/echo/v4"
)

func FetchAllBooking(c echo.Context) error {

	result, err := models.FetchAllBooking()

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": err.Error()})
	}
	return c.JSON(http.StatusOK, result)
}

func FetchAllBookingFilter(c echo.Context) error {
	tgl := c.Param("tgl")
	fmt.Println(tgl)
	result, err := models.FetchAllBookingFilter(tgl)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": err.Error()})
	}
	return c.JSON(http.StatusOK, result)
}

func StoreBooking(c echo.Context) error {
	var obj models.RequestBooking

	err := c.Bind(&obj)
	fmt.Println(obj.DetailBookings)
	if err != nil {
		return c.String(http.StatusBadRequest, "bad request")
	}
	result, err := models.StoreBoking(obj)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": err.Error()})
	}
	return c.JSON(http.StatusOK, result)
}
func UpdateBoking(c echo.Context) error {
	var obj models.UpdateRequestBooking

	err := c.Bind(&obj)
	fmt.Println(obj.DetailBookings)
	if err != nil {
		return c.String(http.StatusBadRequest, "bad request")
	}
	result, err := models.UpdateBoking(obj)

	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"message": err.Error()})
	}
	return c.JSON(http.StatusOK, result)
}

func DeleteBooking(c echo.Context) error {
	id := c.Param("id")
	fmt.Print(id)

	idInt, err := strconv.Atoi(id)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	result, err := models.DeleteBooking(idInt)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())

	}

	return c.JSON(http.StatusOK, result)
}
