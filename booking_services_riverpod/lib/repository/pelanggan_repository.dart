import 'dart:convert';

import 'package:booking_services_riverpod/model/pelanggan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/constant.dart';
import 'base_repository.dart';

class PelangganRepository extends BaseRepository {
  PelangganRepository({required super.dio});

  Future<List<Pelanggan>> listPelanggan() async {
    String token = "";
    await Constant().getShared().then((value) {
      print(value);
      token = value;
    });
    final resp = await gets(
        services: "${Constant.baseURLToken}Pelanggan", token: "${token}");
    List<Pelanggan> result = List.empty(growable: true);
    if (resp["data"] == null) {
      result = [];
    } else {
      resp["data"].forEach((e) {
        final model = Pelanggan.fromJson(e);
        result.add(model);
      });
    }
    return result;
  }

  Future<bool> inputPelanggan(Pelanggan p) async {
    String token = "";
    await Constant().getShared().then((value) {
      print(value);
      token = value;
    });
    final body = {"name": p.name, "no_hp": p.noHp, "alamat": p.alamat};
    final service = "${Constant.baseURLToken}Pelanggan";
    print(service);
    final resp = await post(
      body: body,
      service: service,
      token: "${token}",
    );
    print(resp.toString());
    if (resp['status'] == "200") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> EditPelanggan(Pelanggan p) async {
    String token = "";
    await Constant().getShared().then((value) {
      print(value);
      token = value;
    });
    final body = {
      "id": int.parse(p.id.toString()),
      "name": p.name,
      "no_hp": p.noHp,
      "alamat": p.alamat
    };
    final service = "${Constant.baseURLToken}PelangganUpdate";
    print(body);
    final resp = await post(
      body: body,
      service: service,
      token: "${token}",
    );
    print(resp.toString());
    if (resp['status'] == "200") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> DeletePelanggan(String id) async {
    String token = "";
    await Constant().getShared().then((value) {
      print(value);
      token = value;
    });
    final service = "${Constant.baseURLToken}PelangganDelete/" + id;
    final body = <String, dynamic>{};

    final resp = await post(
      body: body,
      service: service,
      token: "${token}",
    );
    print(body);
    if (resp['status'] == "200") {
      return true;
    } else {
      return false;
    }
  }
}
