import 'dart:convert';

import 'package:booking_services_riverpod/model/pelanggan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/constant.dart';
import 'base_repository.dart';

class PelangganRepository extends BaseRepository {
  PelangganRepository({required super.dio});

  Future<List<Pelanggan>> listPelanggan() async {
       final shared = await SharedPreferences.getInstance();
    final xmodel = jsonDecode(shared.get(Constant.bearerName).toString());
    String token = xmodel['token'];
    final resp = await gets(
        services: "${Constant.baseURLToken}Pelanggan",
        token:
            "${token}");
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
       final shared = await SharedPreferences.getInstance();
    final xmodel = jsonDecode(shared.get(Constant.bearerName).toString());
    String token = xmodel['token'];
    final body = {"name": p.name, "no_hp": p.noHp, "alamat": p.alamat};
    final service = "${Constant.baseURLToken}Pelanggan";
    print(service);
    final resp = await post(
      body: body,
      service: service,
      token:
          "${token}",
    );
    print(resp.toString());
    if (resp['status'] == "200") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> EditPelanggan(Pelanggan p) async {
       final shared = await SharedPreferences.getInstance();
    final xmodel = jsonDecode(shared.get(Constant.bearerName).toString());
    String token = xmodel['token'];
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
      token:
          "${token}",
    );
    print(resp.toString());
    if (resp['status'] == "200") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> DeletePelanggan(String id) async {
       final shared = await SharedPreferences.getInstance();
    final xmodel = jsonDecode(shared.get(Constant.bearerName).toString());
    String token = xmodel['token'];
    final service = "${Constant.baseURLToken}PelangganDelete/"+id;
     final body = <String,dynamic>{};
     
    final resp = await post(
      
      body: body,
      service: service,
      token:
          "${token}",
    );
    print(body);
    if (resp['status'] == "200") {
      return true;
    } else {
      return false;
    }
  }
}
