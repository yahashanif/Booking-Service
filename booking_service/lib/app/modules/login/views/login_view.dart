import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/umum_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final umumC = Get.find<UmumController>();
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Login",
            style: GoogleFonts.raleway(
              fontSize: 30,
            ),
          )),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.usernameC,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Username',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.passC,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '*****',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                if (controller.usernameC.text.isEmpty ||
                    controller.passC.text.isEmpty) {
                  Get.snackbar(
                    "Failed",
                    "Username Atau Password Tidak Boleh Kosong",
                    colorText: Colors.white,
                    backgroundColor: Colors.red[300],
                    icon: Icon(Icons.warning, color: Colors.white),
                    snackPosition: SnackPosition.TOP,
                  );
                } else {
                  umumC.Login(controller.usernameC.text, controller.passC.text);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green,
                ),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Center(
                    child: Text(
                  "Login",
                  style: GoogleFonts.raleway(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ))
        ],
      ),
    ));
  }
}
