import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController usernameC;
  late TextEditingController passC;

  @override
  void onInit() {
    super.onInit();
    usernameC = TextEditingController();
    passC = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    usernameC.dispose();
    passC.dispose();
  }
}
