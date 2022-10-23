
import 'package:booking_services_riverpod/app/route.dart';
import 'package:booking_services_riverpod/provider/current_booking_provider.dart';
import 'package:booking_services_riverpod/screen/booking_screen/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../app/constant.dart';
import '../model/booking_model.dart';

class CardBooking extends HookConsumerWidget {
  const CardBooking({
    required this.selectedDate,
    required this.b,
  });

  final Booking b;
  final ValueNotifier<DateTime> selectedDate;

  @override
  Widget build(BuildContext context,ref) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${b.pelanggan!.name}}",
                style: GoogleFonts.raleway(
                    fontSize: 15, fontWeight: FontWeight.bold)),
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
            Text("${b.tglBooking}",
                style: GoogleFonts.raleway(
                    fontSize: 15, fontWeight: FontWeight.bold)),
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
                    alignment: Alignment.centerRight,
                    child: Text(
                        "${NumberFormat.currency(locale: 'eu', symbol: 'IDR').format(b.total)}"))),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Column(
                children: [
                  ...b.detailBookings!
                      .map((e) => Container(
                              child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(Constant
                                                .baseWithoutURLToken +
                                            "static/${e.product!.imageUrl}"))),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(e.product!.name!),
                            ],
                          )))
                      .toList()
                ],
              ),
            ),
            selectedDate.value.day - DateTime.now().day >= 0
                ? Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              ref.watch(EditBookingStateProvider.notifier).state = b;
                              Navigator.of(context).pushNamed(editBookingRoute);
                            },
                            icon: Icon(Icons.edit_note_sharp)),
                        IconButton(onPressed: () {
                           ref.watch(BookingProvider.notifier).delete(b.id.toString(),selectedDate.value.toString(),);
                        }, icon: Icon(Icons.delete)),
                      ],
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
