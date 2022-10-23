import 'dart:async';

import 'package:booking_services_riverpod/app/route.dart';
import 'package:booking_services_riverpod/model/pelanggan_model.dart';
import 'package:booking_services_riverpod/screen/list_pelanggan/list_provider.dart';
import 'package:booking_services_riverpod/widget/card_pelanggan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widget/header_widget.dart';

class ListPelanggan extends HookConsumerWidget {
  const ListPelanggan({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isLoading = useState(false);
    final errorMessage = useState("");
    final pelanggan = useState(<Pelanggan>[]);

    useEffect(() {
    ref.read(PelangganListProvider.notifier).list();
    return;
    }, []);
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
        pelanggan.value = next.model;
        // print(pelanggan.value);
      }
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(inputPelangganRoute);
          // Get.toNamed("/input-pelanggan");
        },
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          children: [
            HeaderWidget(title: "List Pelanggan"),
            Expanded(
                child: isLoading.value == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : errorMessage.value != ""
                        ? Text(errorMessage.value)
                        : Container(
                            child: ListView(
                              children: [
                                ...pelanggan.value
                                    .map((e) => CardPelanggan(pelanggan: e))
                                    .toList()
                                // ...umumC.pelanggans.value.map((e) => CardPelanggan(pelanggan: e)).toList(),
                              ],
                            ),
                          ))
          ],
        ),
      )),
    );
  }
}
