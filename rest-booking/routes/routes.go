package routes

import (
	"rest-booking/controllers"
	"rest-booking/middleware"

	"github.com/labstack/echo/v4"
)

func Init() *echo.Echo {
	e := echo.New()

	// e.PUT("/product", controllers.UpdateProduct)
	// e.POST("/productDelete", controllers.DeleteProduct)

	authRoutes := e.Group("/auth")
	{
		authRoutes.POST("/register", controllers.Register)
		authRoutes.POST("/login", controllers.CheckLogin)
		authRoutes.Static("/static", "file")

	}
	userRoutes := e.Group("/api/user", middleware.IsAuth)
	{
		userRoutes.GET("/products", controllers.FetchAllProduct)
		userRoutes.POST("/product", controllers.StoreProduct)
		userRoutes.POST("/productPhoto", controllers.UpdateProductWithImage)
		userRoutes.POST("/productwithoutPhoto", controllers.UpdateProductWithoutImage)
		userRoutes.POST("/productDelete", controllers.DeleteProduct)

		userRoutes.GET("/bookings", controllers.FetchAllBooking)
		userRoutes.GET("/booking/:tgl", controllers.FetchAllBookingFilter)
		userRoutes.POST("/booking", controllers.StoreBooking)
		userRoutes.POST("/Updatebooking", controllers.UpdateBoking)
		userRoutes.GET("/deleteBooking/:id", controllers.DeleteBooking)

		userRoutes.GET("/Pelanggan", controllers.FetchAllPelanggan)
		userRoutes.POST("/Pelanggan", controllers.StorePelanggan)
		userRoutes.POST("/PelangganUpdate", controllers.UpdatePelanggan)
		userRoutes.POST("/PelangganDelete", controllers.DeletePelanggan)

	}
	return e
}
