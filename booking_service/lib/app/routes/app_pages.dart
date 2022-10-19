import 'package:get/get.dart';

import 'package:booking_service/app/modules/editPelanggan/bindings/edit_pelanggan_binding.dart';
import 'package:booking_service/app/modules/editPelanggan/views/edit_pelanggan_view.dart';
import 'package:booking_service/app/modules/editbooking/bindings/editbooking_binding.dart';
import 'package:booking_service/app/modules/editbooking/views/editbooking_view.dart';
import 'package:booking_service/app/modules/home/bindings/home_binding.dart';
import 'package:booking_service/app/modules/home/views/home_view.dart';
import 'package:booking_service/app/modules/inputBooking/bindings/input_booking_binding.dart';
import 'package:booking_service/app/modules/inputBooking/views/input_booking_view.dart';
import 'package:booking_service/app/modules/inputPelanggan/bindings/input_pelanggan_binding.dart';
import 'package:booking_service/app/modules/inputPelanggan/views/input_pelanggan_view.dart';
import 'package:booking_service/app/modules/laporanBooking/bindings/laporan_booking_binding.dart';
import 'package:booking_service/app/modules/laporanBooking/views/laporan_booking_view.dart';
import 'package:booking_service/app/modules/login/bindings/login_binding.dart';
import 'package:booking_service/app/modules/login/views/login_view.dart';
import 'package:booking_service/app/modules/pelanggan/bindings/pelanggan_binding.dart';
import 'package:booking_service/app/modules/pelanggan/views/pelanggan_view.dart';
import 'package:booking_service/splash_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashPage(),
    ),
    GetPage(
      name: _Paths.PELANGGAN,
      page: () => PelangganView(),
      binding: PelangganBinding(),
    ),
    GetPage(
      name: _Paths.INPUT_PELANGGAN,
      page: () => InputPelangganView(),
      binding: InputPelangganBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PELANGGAN,
      page: () => EditPelangganView(),
      binding: EditPelangganBinding(),
    ),
    GetPage(
      name: _Paths.INPUT_BOOKING,
      page: () => InputBookingView(),
      binding: InputBookingBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN_BOOKING,
      page: () => LaporanBookingView(),
      binding: LaporanBookingBinding(),
    ),
    GetPage(
      name: _Paths.EDITBOOKING,
      page: () => EditbookingView(),
      binding: EditbookingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
