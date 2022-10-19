import 'package:get/get.dart';

import '../controllers/laporan_booking_controller.dart';

class LaporanBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanBookingController>(
      () => LaporanBookingController(),
    );
  }
}
