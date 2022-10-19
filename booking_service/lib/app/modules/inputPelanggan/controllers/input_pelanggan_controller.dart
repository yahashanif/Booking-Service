import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputPelangganController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController noHpC;
  late TextEditingController alamatC;

  @override
  void onInit() {
    super.onInit();
    nameC = TextEditingController();
    noHpC = TextEditingController();
    alamatC = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    nameC.dispose();
    noHpC.dispose();
    alamatC.dispose();
  }

  
}
