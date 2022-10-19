import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controllers/umum_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
    final umumC = Get.find<UmumController>();
    final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    umumC.getBooking(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    var banyak = umumC.bookings.length.obs;
    print(banyak);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 237, 237),
        body: SafeArea(
            child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${DateFormat('EEE, MMM d, ' 'yyyy').format(DateTime.now())}",
                    style: GoogleFonts.raleway(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red,image: DecorationImage(image: NetworkImage(baseURL+"auth/static/${umumC.user.value.profilPathUrl}"),fit: BoxFit.cover)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Welcome ${umumC.user.value.username} ",
                  style: GoogleFonts.raleway(
                      fontSize: 25, fontWeight: FontWeight.bold),
                )),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Booking Today",
                      style: GoogleFonts.raleway(
                          fontSize: 20,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 239, 233, 233)),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                        child: Center(
                          child:Obx(() =>  Text(
                            "${banyak}",
                            style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      umumC.getPelanggan();
                      Get.toNamed("/pelanggan");
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_search_rounded,
                            color: Colors.amber,
                            size: 60,
                          ),
                          Text(
                            "Pelanggan",
                            style: GoogleFonts.raleway(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      height: 150,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      umumC.getBooking(DateFormat('yyyy-MM-dd').format(DateTime.now()));
                      Get.toNamed("/laporan-booking");
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.data_exploration_rounded,
                            color: Colors.blue,
                            size: 60,
                          ),
                          Text(
                            "Data Booking",
                            style: GoogleFonts.raleway(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      height: 150,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      umumC.getProduct();
                      umumC.getPelanggan();
                      Get.toNamed("/input-booking");
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book_outlined,
                            color: Colors.green,
                            size: 60,
                          ),
                          Text(
                            "Booking",
                            style: GoogleFonts.raleway(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      height: 150,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      umumC.Logout();
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            color: Colors.red,
                            size: 60,
                          ),
                          Text(
                            "Exit",
                            style: GoogleFonts.raleway(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      height: 150,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )));
  }
}
