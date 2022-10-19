import 'package:get/get.dart';

import '../controllers/input_pelanggan_controller.dart';

class InputPelangganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputPelangganController>(
      () => InputPelangganController(),
    );
  }
}
