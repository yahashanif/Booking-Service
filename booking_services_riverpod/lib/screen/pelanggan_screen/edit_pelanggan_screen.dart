import 'dart:async';

import 'package:booking_services_riverpod/app/constant.dart';
import 'package:booking_services_riverpod/model/pelanggan_model.dart';
import 'package:booking_services_riverpod/screen/list_pelanggan/list_provider.dart';
import 'package:booking_services_riverpod/screen/pelanggan_screen/pelanggan_provider.dart';
import 'package:booking_services_riverpod/widget/custom_textfield.dart';
import 'package:booking_services_riverpod/widget/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/current_pelanggan_provider.dart';

class EditPelangganPage extends HookConsumerWidget {
  const EditPelangganPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final p = ref.read(EditPelangganStateProvider.notifier).state;
    final isLoading = useState<bool>(false);
    final errorMessage = useState("");
    final ctrlName = useTextEditingController(text: p!.name);
    final ctrlNoHp = useTextEditingController(text: p.noHp);
    final ctrlAlamat = useTextEditingController(text: p.alamat);

    ref.listen(PelangganProvider, (previous, next) {
      print(next);
      if (next is PelangganStateLoading) {
        isLoading.value = true;
      } else if (next is PelangganStateError) {
        isLoading.value = false;
        errorMessage.value = next.message;
        Timer(Duration(seconds: 3), () {
          errorMessage.value = "";
        });
        print(errorMessage);
      } else if (next is PelangganStateDone) {
        isLoading.value = false;
        ref.read(PelangganListProvider.notifier).list();
        Navigator.of(context).pop();
      }
    });
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(title: "Edit Pelanggan"),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Pelanggan"),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          hintText: 'Edit Nama Pelanggan',
                          isPassword: false,
                          ctrl: ctrlName,
                          type: TextInputType.name,
                          maxline: 1),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Nomor Hp Pelanggan"),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          hintText: 'Edit No Hp Pelanggan',
                          isPassword: false,
                          ctrl: ctrlNoHp,
                          type: TextInputType.number,
                          maxline: 1),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Alamat Pelanggan"),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          hintText: 'Edit Alamat Pelanggan',
                          isPassword: false,
                          ctrl: ctrlAlamat,
                          type: TextInputType.multiline,
                          maxline: 4),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            if (ctrlName.text == "") {
                              Constant().showSnackBarError(
                                  context, "Field Nama Tidak Boleh Kosong");
                            } else if (ctrlNoHp.text == "") {
                              Constant().showSnackBarError(context,
                                  "Field No Hp Pelanggan Tidak Boleh Kosong");
                            } else if (ctrlAlamat.text == "") {
                              Constant().showSnackBarError(
                                  context, "Field Alamat Tidak Boleh Kosong");
                            } else {
                              ref.watch(PelangganProvider.notifier).Edit(
                                  p: Pelanggan(
                                      id: p.id,
                                      alamat: ctrlAlamat.text,
                                      name: ctrlName.text,
                                      noHp: ctrlNoHp.text));
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
                              "Edit Data Pelanggan",
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
            if (errorMessage.value != "") EditPelangganError()
          ],
        ),
      )),
    );
  }
}

class EditPelangganError extends StatelessWidget {
  const EditPelangganError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100,
        // color: Constant.background.withOpacity(0.5),
        child: Center(
          child: Text("Opp Ada Yang Salah"),
        ));
  }
}
