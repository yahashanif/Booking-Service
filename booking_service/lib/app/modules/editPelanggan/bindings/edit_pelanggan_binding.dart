import 'package:get/get.dart';

import '../controllers/edit_pelanggan_controller.dart';

class EditPelangganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPelangganController>(
      () => EditPelangganController(),
    );
  }
}
