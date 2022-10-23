import 'dart:async';

import 'package:booking_services_riverpod/app/constant.dart';
import 'package:booking_services_riverpod/screen/booking_screen/booking_provider.dart';
import 'package:booking_services_riverpod/widget/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../model/booking_model.dart';
import '../../widget/card_booking.dart';

class LaporanBookingPage extends HookConsumerWidget {
  const LaporanBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    print(arguments);
    final isLoading = useState(false);
    final errorMessage = useState("");
    final bookings = useState(<Booking>[]);
    final selectedDate = useState(DateTime.now());
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
        ref
            .watch(BookingProvider.notifier)
            .list(DateFormat('yyyy-MM-dd').format(selectedDate.value));
      }
   
    }

    useEffect(() {
      ref
          .read(BookingProvider.notifier)
          .list(DateFormat('yyyy-MM-dd').format(DateTime.now()));
      return;
    }, []);
    ref.listen(BookingProvider, (previous, next) {
      print(next);
      if (next is BookingProviderStateLoading) {
        isLoading.value = true;
      } else if (next is BookingProviderStateError) {
        isLoading.value = false;
        errorMessage.value = next.message;
        Timer(const Duration(seconds: 3), () {
          errorMessage.value = "";
        });
      } else if (next is BookingProviderStateDone) {
        isLoading.value = false;
        bookings.value = next.model;
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Column(
            children: [
              HeaderWidget(title: "Laporan Booking"),
              Container(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: Icon(Icons.filter_alt_rounded)),
                    Text(
                        "${DateFormat('EEE, MMM d, ' 'yyyy').format(selectedDate.value)}"),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Container(
                child: bookings.value.isEmpty
                    ? Center(
                        child: Text("Belum Ada Booking Service"),
                      )
                    : ListView(
                        children: [
                          ...bookings.value
                              .map((e) =>
                                  CardBooking(selectedDate: selectedDate,b: e,))
                              .toList()
                        ],
                      ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
