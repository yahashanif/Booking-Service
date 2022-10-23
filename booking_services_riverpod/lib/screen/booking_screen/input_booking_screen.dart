import 'dart:async';

import 'package:booking_services_riverpod/app/constant.dart';
import 'package:booking_services_riverpod/model/booking_model.dart';
import 'package:booking_services_riverpod/screen/booking_screen/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../model/pelanggan_model.dart';
import '../../model/request_model.dart';
import '../../widget/header_widget.dart';
import '../list_pelanggan/list_provider.dart';
import 'booking_provider.dart';

class inputBookingPage extends HookConsumerWidget {
  const inputBookingPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final dropdownValuePelanggan = useState(Pelanggan());
    final isLoading = useState(false);
    final errorMessage = useState("");
    final dropdownValue = useState(Product());
    final selectedDate = useState(DateTime.now());
    final products = useState(<Product>[]);
    final arrSelectProduct = useState(<Product>[]);
    final pelanggans = useState(<Pelanggan>[]);
    useEffect(() {
      ref.read(PelangganListProvider.notifier).list();
      ref.read(ProductListProvider.notifier).list();
      return;
    }, []);
    // Listen Data Pelanggan
    ref.listen(PelangganListProvider, (previous, next) {
      print(next);
      if (next is PelangganListStateLoading) {
        isLoading.value = true;
      } else if (next is PelangganListStateError) {
        isLoading.value = false;
        errorMessage.value = next.message;
        Timer(const Duration(seconds: 3), () {
          errorMessage.value = "";
        });
      } else if (next is PelangganListStateDone) {
        isLoading.value = false;
        pelanggans.value = next.model;
        dropdownValuePelanggan.value = pelanggans.value.first;
      }
    });
    // Listen Data Product
    ref.listen(ProductListProvider, (previous, next) {
      print(next);
      if (next is ProductListStateLoading) {
        isLoading.value = true;
      } else if (next is ProductListStateError) {
        isLoading.value = false;
        errorMessage.value = next.message;
        Timer(const Duration(seconds: 3), () {
          errorMessage.value = "";
        });
      } else if (next is ProductListStateDone) {
        isLoading.value = false;
        products.value = next.model;
        print(products.value[1].name);
        dropdownValue.value = products.value.first;
      }
    });

    ref.listen(BookingProvider, (previous, next) {
      print(next);
      if (next is BookingProviderStateLoading) {
        isLoading.value = true;
      } else if (next is BookingProviderStateError) {
        isLoading.value = false;
        errorMessage.value = next.message;
        Timer(Duration(seconds: 3), () {
          errorMessage.value = "";
        });
        print(errorMessage);
      } else if (next is BookingProviderStateDone) {
        isLoading.value = false;
        ref.read(PelangganListProvider.notifier).list();
        Navigator.of(context).pop();
      }
    });

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
            HeaderWidget(title: "Booking"),
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
                  Container(
                    width: double.infinity,
                    child: DropdownButton<Pelanggan>(
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      hint: Text(dropdownValuePelanggan.value != null
                          ? dropdownValuePelanggan.value.name.toString()
                          : "Pilih Pelanggan"),
                      items: pelanggans.value
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name!),
                              ))
                          .toList(),
                      onChanged: (value) {
                        dropdownValuePelanggan.value = value!;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Pilih Produk",
                    style: GoogleFonts.raleway(
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: DropdownButton<Product>(
                      hint: Text("Pilih Produk"),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      items: products.value
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
                      onChanged: (value) {
                        dropdownValue.value = value! as Product;
                        arrSelectProduct.value.add(value);
                      },
                    ),
                  ),
                  Column(
                    children: [
                      ...arrSelectProduct.value
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
                                          if(arrSelectProduct.value.length == 1){
                                            arrSelectProduct.value.clear();
                                          }
                                          dropdownValue.value = element;

                                          arrSelectProduct.value.removeWhere(
                                            (e) => e.id == element.id,
                                          );
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
                  ),
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
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        "${DateFormat('EEEE, MMM d, ' 'yyyy').format(selectedDate.value)}",
                        style: GoogleFonts.poppins(fontSize: 15),
                      ))),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        print(selectedDate.value.day - DateTime.now().day);
                        if (arrSelectProduct.value.isEmpty) {
                          Constant()
                              .showSnackBarError(context, "Pilih Product");
                        } else if (selectedDate.value.day -
                                DateTime.now().day <=
                            0) {
                          Constant().showSnackBarError(
                              context, "Tanggal Harus Minimal H+1");
                        } else {
                          List<RProduct> r = arrSelectProduct.value
                              .map((element) => RProduct(id: element.id))
                              .toList();
                          List<DetailBookings2> dboo = r
                              .map((e) => DetailBookings2(product: e, qty: 1))
                              .toList();
                          ref.watch(BookingProvider.notifier).Input(
                              b: BookingRequest(
                                  detailBookings: dboo,
                                  idPelanggan: dropdownValuePelanggan.value.id,
                                  tglBooking: selectedDate.value.toString()));
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
                          "Input Data Booking",
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
