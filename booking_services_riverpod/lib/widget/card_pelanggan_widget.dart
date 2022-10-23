import 'package:booking_services_riverpod/app/route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/pelanggan_model.dart';
import '../provider/current_pelanggan_provider.dart';
import '../screen/list_pelanggan/list_provider.dart';

class CardPelanggan extends HookConsumerWidget {
  final Pelanggan pelanggan;

  const CardPelanggan({required this.pelanggan});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.amber,
      ),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Center(
              child: Text(
                "${pelanggan.id}",
                style: GoogleFonts.poppins(
                    color: Colors.amber, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${pelanggan.name}",
                        style: GoogleFonts.raleway(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 1,
                        color: Colors.blueGrey,
                        width: double.infinity,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${pelanggan.noHp}",
                          style: GoogleFonts.raleway(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Container(
                        height: 1,
                        color: Colors.blueGrey,
                        width: double.infinity,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${pelanggan.alamat}",
                          style: GoogleFonts.raleway(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Container(
                        height: 1,
                        color: Colors.blueGrey,
                        width: double.infinity,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    ref.watch(EditPelangganStateProvider.notifier).state =
                        pelanggan;
                    Navigator.of(context).pushNamed(editPelangganRoute);
                  },
                  icon: Icon(Icons.edit_square)),
              SizedBox(
                height: 20,
              ),
              IconButton(
                  onPressed: () {
                    print(pelanggan.id);
                    ref
                        .watch(PelangganListProvider.notifier)
                        .delete(pelanggan.id.toString());
                  },
                  icon: Icon(Icons.delete)),
            ],
          )
        ],
      ),
    );
  }
}
