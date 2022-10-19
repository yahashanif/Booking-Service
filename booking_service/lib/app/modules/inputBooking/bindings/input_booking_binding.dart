import 'package:get/get.dart';

import '../controllers/input_booking_controller.dart';

class InputBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputBookingController>(
      () => InputBookingController(),
    );
  }
}
