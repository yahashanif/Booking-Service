package helper

import (
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	return string(bytes), err
}
func CheckPasswordHash(password, hash string) (bool, error) {
	ps, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	fmt.Println(ps)
	if err != nil {
		return false, err
	}
	err = bcrypt.CompareHashAndPassword([]byte(ps), []byte(password))
	if err != nil {
		return false, err
	}

	return true, nil
}
