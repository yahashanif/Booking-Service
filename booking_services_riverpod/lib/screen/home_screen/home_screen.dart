import 'dart:async';

import 'package:booking_services_riverpod/app/constant.dart';
import 'package:booking_services_riverpod/screen/home_screen/home_provider.dart';
import 'package:booking_services_riverpod/screen/list_pelanggan/list_provider.dart';
import 'package:booking_services_riverpod/screen/login_screen/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/route.dart';
import '../../provider/current_user_provider.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final banyak = useState<int>(0);
    final model = useState(ref.read(currentUserProvider.notifier).state!.model);

    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 243, 237, 237),
          body: RefreshIndicator(
            onRefresh: () async {
              ref
                  .watch(countProvider.notifier)
                  .count(tgl: DateFormat('yyyy-MM-dd').format(DateTime.now()));
              banyak.value = 0 + ref.read(countProvider.notifier).state;
            },
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.top,
                ),
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
                          shape: BoxShape.circle,
                          color: Colors.red,
                          image: DecorationImage(
                              image: NetworkImage(Constant.baseWithoutURLToken +
                                  "static/${model.value.profilPathUrl}"),
                              fit: BoxFit.cover),
                        ),
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
                      "Welcome ${model.value.username}",
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
                              child: Text(
                                "${banyak.value}",
                                style: GoogleFonts.poppins(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
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
                          // ref.read(PelangganListProvider.notifier).list();
                          // Timer(const Duration(seconds: 3), () {
                          Navigator.of(context).pushNamed(listPelangganRoute);
                          // });
                          // umumC.getPelanggan();
                          // Get.toNamed("/pelanggan");
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
                          Navigator.of(context).pushNamed(laporanBookingRoute);
                          // umumC.getBooking(DateFormat('yyyy-MM-dd').format(DateTime.now()));
                          // Get.toNamed("/laporan-booking");
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
                          Navigator.of(context).pushNamed(inputBookingRoute);
                          // umumC.getProduct();
                          // umumC.getPelanggan();
                          // Get.toNamed("/input-booking");
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
                        onTap: () {
                          ref.read(loginProvider.notifier).Logout();
                          Navigator.of(context).pushReplacementNamed(loginRoute);
                          // umumC.Logout();
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
            ),
          )),
    );
  }
}
