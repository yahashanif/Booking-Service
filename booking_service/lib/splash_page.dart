
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'app/controllers/umum_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
  final umumC = Get.find<UmumController>();

     Future.delayed(const Duration(seconds: 5), () {
     
        umumC.CheckLogin();
    });
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Booking Services",style: GoogleFonts.poppins(fontSize: 30,fontWeight: FontWeight.bold),),
              LottieBuilder(lottie: AssetLottie("assets/lottie/logo_splash.json")),
            ],
          ),
        ),
      ),
    );
  }
}