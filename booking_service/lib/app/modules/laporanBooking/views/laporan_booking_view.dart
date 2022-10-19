import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../../controllers/umum_controller.dart';
import '../controllers/laporan_booking_controller.dart';

class LaporanBookingView extends GetView<LaporanBookingController> {
  @override
  Widget build(BuildContext context) {
    final umumC = Get.find<UmumController>();
    var selectedDate = DateTime.now().obs;
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
        umumC.getBooking(DateFormat('yyyy-MM-dd').format(selectedDate.value));
      }
      // setState(() {
      // });
    }

    return Scaffold(
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
                        "Laporan Booking",
                        style: GoogleFonts.raleway(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: Icon(Icons.filter_alt_rounded)),
                    Obx(() => Text(
                        "${DateFormat('EEE, MMM d, ' 'yyyy').format(selectedDate.value)}"))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Container(
                child: Obx(() => umumC.bookings.value.isEmpty
                    ? Center(
                        child: Text("Belum Ada Booking Service"),
                      )
                    : ListView(
                        children: [
                          ...umumC.bookings.value
                              .map((e) => Card(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${e.pelanggan!.name}}",
                                              style: GoogleFonts.raleway(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.blueGrey,
                                            width: double.infinity,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("${e.tglBooking}",
                                              style: GoogleFonts.raleway(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.blueGrey,
                                            width: double.infinity,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              width: double.infinity,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                      "${NumberFormat.currency(locale: 'eu', symbol: 'IDR').format(e.total)}"))),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                ...e.detailBookings!
                                                    .map((e) => Container(
                                                            child: Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 30,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                image: DecorationImage(image: NetworkImage(baseURL+"auth/static/${e.product!.imageUrl}"))
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(e.product!
                                                                .name!),
                                                          ],
                                                        )))
                                                    .toList()
                                              ],
                                            ),
                                          ),
                                          selectedDate.value.day - DateTime.now().day >= 0 ?
                                          Container(
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      umumC.editBooking.value = e;
                                                      Get.toNamed("/editbooking");
                                                    },
                                                    icon: Icon(
                                                        Icons.edit_note_sharp)),
                                                IconButton(
                                                    onPressed: () {
                                                      umumC.DeleteBooking(e.id!);
                                                      umumC.getBooking(DateFormat('yyyy-MM-dd').format(selectedDate.value));
                                                    },
                                                    icon: Icon(Icons.delete)),
                                              ],
                                            ),
                                          ) : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList()
                        ],
                      )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
