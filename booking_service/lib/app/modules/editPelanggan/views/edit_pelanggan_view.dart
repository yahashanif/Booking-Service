import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/umum_controller.dart';
import '../../../data/models/pelanggan_model.dart';
import '../controllers/edit_pelanggan_controller.dart';

class EditPelangganView extends GetView<EditPelangganController> {
  @override
  Widget build(BuildContext context) {
    final umumC = Get.find<UmumController>();
    controller.nameC.text = umumC.editPelanggan.value.name!;
    controller.noHpC.text = umumC.editPelanggan.value.noHp!;
    controller.alamatC.text = umumC.editPelanggan.value.alamat!;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Edit Pelanggan",
                          style: GoogleFonts.raleway(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Pelanggan"),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: controller.nameC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Input Nama Pelanggan',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Nomor Hp Pelanggan"),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: controller.noHpC,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Input No Hp Pelanggan',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Alamat Pelanggan"),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: controller.alamatC,
                        maxLines: 4,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Input Alamat Pelanggan',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            if (controller.nameC.text.isEmpty) {
                              Get.snackbar(
                                "Field Required",
                                "Nama Harus Diinputkan",
                                colorText: Colors.white,
                                backgroundColor: Colors.red[300],
                                icon: Icon(Icons.warning, color: Colors.white),
                                snackPosition: SnackPosition.TOP,
                              );
                            } else if (controller.noHpC.text.isEmpty) {
                              Get.snackbar(
                                "Field Required",
                                "No Hp Harus Diinputkan",
                                colorText: Colors.white,
                                backgroundColor: Colors.red[300],
                                icon: Icon(Icons.warning, color: Colors.white),
                                snackPosition: SnackPosition.TOP,
                              );
                            } else if (controller.alamatC.text.isEmpty) {
                              Get.snackbar(
                                "Field Required",
                                "Alamat Harus Diinputkan",
                                colorText: Colors.white,
                                backgroundColor: Colors.red[300],
                                icon: Icon(Icons.warning, color: Colors.white),
                                snackPosition: SnackPosition.TOP,
                              );
                            } else {
                              umumC.updatePelanggan(Pelanggan(
                                  id: umumC.editPelanggan.value.id,
                                  name: controller.nameC.text,
                                  alamat: controller.alamatC.text,
                                  noHp: controller.noHpC.text));
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
                              "Update Data Pelanggan",
                              style: GoogleFonts.raleway(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
