import 'package:booking_service/page/cardPelanggan.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/umum_controller.dart';
import '../controllers/pelanggan_controller.dart';

class PelangganView extends GetView<PelangganController> {
  @override
  Widget build(BuildContext context) {
  final umumC = Get.find<UmumController>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          Get.toNamed("/input-pelanggan");
        },
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back_ios)),
                    Spacer(),
                    Text(
                      "List Pelanggan",
                      style: GoogleFonts.raleway(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Obx(() => Container(
              child: ListView(
                children: [
                  ...umumC.pelanggans.value.map((e) => CardPelanggan(pelanggan: e)).toList(),
                ],
              ),
            )))
          ],
        ),
      )),
    );
  }
}

