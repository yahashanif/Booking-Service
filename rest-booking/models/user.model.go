package models

import (
	"database/sql"
	"fmt"
	"net/http"
	"rest-booking/db"
	"rest-booking/helper"

	"github.com/golang-jwt/jwt"
)

type User struct {
	Id            int    `json:"id"`
	Name          string `json:"name"`
	Username      string `json:"username"`
	Email         string `json:"email"`
	ProfilPathUrl string `json:"profil_path_url"`
	Level         string `json:"level"`
	Token         string `json:"token"`
}

type CheckLoginModel struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

func Register(user User, password string) (Response, error) {
	var res Response
	con := db.CreateCon()

	sqlStatement := "INSERT INTO `user` ( `name`, `username`, `email`, `password`, `profil_path_url`, `level`) VALUES ( ?, ?, ?, ?, ?, ?)"

	stmt, err := con.Prepare(sqlStatement)
	if err != nil {
		return res, err
	}
	hash, err := helper.HashPassword(password)
	if err != nil {
		return res, err
	}
	result, err := stmt.Exec(user.Name, user.Username, user.Email, hash, user.ProfilPathUrl, user.Level)

	if err != nil {
		return res, err
	}

	lastInsertID, err := result.LastInsertId()
	if err != nil {
		return res, err
	}

	res.Status = http.StatusOK
	res.Message = "Sukses Created User"
	res.Data = map[string]int64{
		"LastInsertID": lastInsertID,
	}

	return res, nil

}

func CheckLogin(username, password string) (Response, error) {
	var res Response
	var obj User

	var pwd string

	con := db.CreateCon()

	sqlStatement := "SELECT * FROM user WHERE username = ?"

	err := con.QueryRow(sqlStatement, username).Scan(
		&obj.Id, &obj.Name, &obj.Username, &obj.Email, &pwd, &obj.ProfilPathUrl, &obj.Level,
	)

	if err == sql.ErrNoRows {

		fmt.Println("Username Not Found")
		return res, err

	}
	fmt.Println(obj.Level)

	if obj.Level != "admin" {
		res.Status = http.StatusForbidden
		res.Message = "Anda Bukan Admin"
		return res, nil
	}

	if err != nil {
		fmt.Print("Query Error")
		return res, err
	}
	fmt.Println(password)

	fmt.Println(pwd)

	match, err := helper.CheckPasswordHash(password, pwd)
	fmt.Println(match)
	if !match {

		fmt.Println("Hash and password doesn't match")
		return res, err
	}
	token := jwt.New(jwt.SigningMethodHS256)
	claims := token.Claims.(jwt.MapClaims)

	claims["username"] = obj.Username
	claims["level"] = "application"

	t, err := token.SignedString([]byte("secret"))
	obj.Token = t

	res.Status = http.StatusOK
	res.Message = "Sukses Login"
	res.Data = obj

	return res, nil
}
