import 'package:booking_service/app/data/models/pelanggan_model.dart';
import 'package:booking_service/app/data/models/request_model.dart';
import 'package:booking_service/app/modules/editbooking/controllers/editbooking_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controllers/umum_controller.dart';
import '../../../data/models/booking_model.dart';

class EditbookingView extends GetView<EditbookingController> {
    final umumC = Get.find<UmumController>();
  @override
  Widget build(BuildContext context) {
    var dropdownValuePelanggan = umumC.editBooking.value.pelanggan.obs;

    var dropdownValue =Product().obs;
    var selectedDate = DateTime.parse(umumC.editBooking.value.tglBooking.toString()).obs;
    var products = <Product>[].obs;
    umumC.editBooking.value.detailBookings!.map((element) => products.add(element.product!)).toList();
    _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value, // Refer step 1
        firstDate: DateTime(2022),
        lastDate: DateTime(2030),
      );
      if (picked != null &&
          picked != selectedDate &&
          picked != DateTime.now()) {
        selectedDate.value = picked;
      }
      // setState(() {
      // });
    }

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
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
                      "Booking",
                      style: GoogleFonts.raleway(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama Pelanggan",
                    style: GoogleFonts.raleway(
                      fontSize: 15,
                    ),
                  ),
                  Obx(() => Container(
                        width: double.infinity,
                        child: DropdownButton<Pelanggan>(
                          // Initial Value
                          // value: dropdownValuePelanggan.value ?? dropdownValuePelanggan.value,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          hint: Text(dropdownValuePelanggan.value != null ? dropdownValuePelanggan.value!.name.toString() : "Pilih Pelanggan") ,
                          // Array list of items
                          items: umumC.pelanggans.value
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name!),
                                  ))
                              .toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (value) {
                            dropdownValuePelanggan.value = value!;
                          },
                        ),
                      )),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Text(
                  //   "Type Produk",
                  //   style: GoogleFonts.raleway(
                  //     fontSize: 15,
                  //   ),
                  // ),
                  // Obx(() => Row(
                  //       children: [
                  //         Container(
                  //           child: Row(
                  //             children: [
                  //               Checkbox(
                  //                 value: type.value == "1" ? true : false,
                  //                 onChanged: (value) {
                  //                   type.value = "1";
                  //                 },
                  //               ),
                  //               Text("Spare Part")
                  //             ],
                  //           ),
                  //         ),
                  //         Container(
                  //           child: Row(
                  //             children: [
                  //               Checkbox(
                  //                 value: type.value == "2" ? true : false,
                  //                 onChanged: (value) {
                  //                   type.value = "2";
                  //                 },
                  //               ),
                  //               Text("Aksesoris")
                  //             ],
                  //           ),
                  //         ),
                  //         Container(
                  //           child: Row(
                  //             children: [
                  //               Checkbox(
                  //                 value: type.value == "3" ? true : false,
                  //                 onChanged: (value) {
                  //                   type.value = "3";
                  //                 },
                  //               ),
                  //               Text("Jasa")
                  //             ],
                  //           ),
                  //         )
                  //       ],
                  //     )),
                  SizedBox(
                    height: 20,
                  ),
                   Text(
                    "Pilih Produk",
                    style: GoogleFonts.raleway(
                      fontSize: 15,
                    ),
                  ),
                  Obx(() => Container(
                        width: double.infinity,
                        child: DropdownButton<Product>(
                          hint: Text("Pilih Produk"),
                          // Initial Value

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          // Array list of items
                          items: umumC.products
                              .map((element) => DropdownMenuItem(
                                    value: element,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(element.name!),
                                        Text(element.categories!.name!),
                                      ],
                                    ),
                                  ))
                              .toList(),

                          // After selecting the desired option,it will
                          onChanged: (value) {
                            dropdownValue.value = value!;
                            products.add(value);
                          },
                        ),
                      )),
                  Obx(() => Column(
                        children: [
                          ...products
                              .map((element) => Container(
                                  width: double.infinity,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(element.name!),
                                        InkWell(
                                            onTap: () {
                                              products.remove(element);
                                            },
                                            child: Icon(
                                              Icons.close,
                                              size: 10,
                                            ))
                                      ],
                                    ),
                                  )))
                              .toList()
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Center(
                            child: Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.black,
                            ),
                            Text(
                              "Pilih Tanggal",
                              style: GoogleFonts.raleway(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tanggal Booking",
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(() => Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        "${DateFormat('EEEE, MMM d, ' 'yyyy').format(selectedDate.value)}",
                        style: GoogleFonts.poppins(fontSize: 15),
                      )))),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        print(selectedDate.value.day - DateTime.now().day);
                        if (products.value.isEmpty) {
                          Get.snackbar(
                            "Field",
                            "Pilih Produk!",
                            colorText: Colors.white,
                            backgroundColor: Colors.red[300],
                            icon: Icon(Icons.warning, color: Colors.white),
                            snackPosition: SnackPosition.TOP,
                          );
                        } else if (selectedDate.value.day -
                                DateTime.now().day <=
                            0) {
                          Get.snackbar(
                            "Field",
                            "Tanggal Harus Minimal H+1",
                            colorText: Colors.white,
                            backgroundColor: Colors.red[300],
                            icon: Icon(Icons.warning, color: Colors.white),
                            snackPosition: SnackPosition.TOP,
                          );
                        } else {
                          List<RProduct> r = products
                              .map((element) => RProduct(id: element.id))
                              .toList();
                          List<DetailBookings2> dboo = r
                              .map((e) => DetailBookings2(product: e, qty: 1))
                              .toList();
                          umumC.updateBooking(BookingRequest(
                            detailBookings: dboo,
                            idPelanggan: dropdownValuePelanggan.value!.id,
                            tglBooking: selectedDate.value.toString(),
                          ),umumC.editBooking.value.id.toString());
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green),
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Center(
                            child: Text(
                          "Update Data Booking",
                          style: GoogleFonts.raleway(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      )),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
