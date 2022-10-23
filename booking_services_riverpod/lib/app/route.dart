import 'package:booking_services_riverpod/screen/booking_screen/edit_booking_screen.dart';
import 'package:booking_services_riverpod/screen/booking_screen/input_booking_screen.dart';
import 'package:booking_services_riverpod/screen/booking_screen/laporan_booking_screen.dart';
import 'package:booking_services_riverpod/screen/home_screen/home_screen.dart';
import 'package:booking_services_riverpod/screen/list_pelanggan/list_pelanggan.dart';
import 'package:booking_services_riverpod/screen/login_screen/login_screen.dart';
import 'package:booking_services_riverpod/screen/pelanggan_screen/edit_pelanggan_screen.dart';
import 'package:booking_services_riverpod/screen/pelanggan_screen/input_pelanggan_screen.dart';
import 'package:booking_services_riverpod/screen/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

const splashRoute = "/splasgh";
const loginRoute = "/login";
const homeRoute = "/home";
const inputPelangganRoute = "/input-pelanggan";
const editPelangganRoute = "/edit-pelanggan";
const listPelangganRoute = "/list-pelanggan";
const inputBookingRoute = "/input-booking";
const editBookingRoute = "/edit-booking";
const laporanBookingRoute = "/laporan-booking";

class AppRoute {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    if (settings.name == homeRoute) {
      return MaterialPageRoute(
        builder: (context) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
                padding: const EdgeInsets.all(0),
              ),
              child: const HomeScreen());
        },
      );
    }
     if (settings.name == listPelangganRoute) {
      return MaterialPageRoute(
        builder: (context) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
                padding: const EdgeInsets.all(0),
              ),
              child: const ListPelanggan());
        },
      );
    }
     if (settings.name == inputPelangganRoute) {
      return MaterialPageRoute(
        builder: (context) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
                padding: const EdgeInsets.all(0),
              ),
              child: const InputPelangganPage());
        },
      );
    }
     if (settings.name == editPelangganRoute) {
      return MaterialPageRoute(
        builder: (context) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
                padding: const EdgeInsets.all(0),
              ),
              child: const EditPelangganPage());
        },
      );
    }
     if (settings.name == inputBookingRoute) {
      return MaterialPageRoute(
        builder: (context) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
                padding: const EdgeInsets.all(0),
              ),
              child: const inputBookingPage());
        },
      );
    }
     if (settings.name == laporanBookingRoute) {
      return MaterialPageRoute(
        builder: (context) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
                padding: const EdgeInsets.all(0),
              ),
              child: const LaporanBookingPage());
        },
      );
    }
     if (settings.name == editBookingRoute) {
      return MaterialPageRoute(
        builder: (context) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
                padding: const EdgeInsets.all(0),
              ),
              child: const EditBookingPage());
        },
      );
    }
     if (settings.name == loginRoute) {
      return MaterialPageRoute(
        builder: (context) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
                padding: const EdgeInsets.all(0),
              ),
              child: const LoginPage());
        },
      );
    }
     //default Route
    return MaterialPageRoute(builder: (context) {
      return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
            padding: const EdgeInsets.all(0),
          ),
          child: const SplashScreen());
    });
  }
}
