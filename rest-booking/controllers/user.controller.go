package controllers

import (
	"io"
	"net/http"
	"os"
	"rest-booking/helper"
	"rest-booking/models"

	"github.com/labstack/echo/v4"
)

func Register(c echo.Context) error {
	var user models.User
	name := c.FormValue("name")
	username := c.FormValue("username")
	email := c.FormValue("email")
	level := c.FormValue("level")
	password := c.FormValue("password")

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

	user.Name = name
	user.Username = username
	user.Email = email
	user.Level = level
	user.ProfilPathUrl = imageUrl

	result, err := models.Register(user, password)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"message": err.Error(),
		})
	}
	return c.JSON(http.StatusOK, result)
}

func CheckLogin(c echo.Context) error {
	var obj models.CheckLoginModel
	err := c.Bind(&obj)
	if err != nil {
		return c.String(http.StatusBadRequest, "bad request")
	}

	res, err := models.CheckLogin(obj.Username, obj.Password)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"messageww": err.Error(),
		})
	}

	return c.JSON(http.StatusOK, res)
}

func GenerateHashPassword(c echo.Context) error {
	password := c.Param("password")

	hash, _ := helper.HashPassword(password)

	return c.JSON(http.StatusOK, hash)
}
