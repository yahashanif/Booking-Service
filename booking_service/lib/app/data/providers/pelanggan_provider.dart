import 'package:get/get.dart';

import '../models/pelanggan_model.dart';

class PelangganProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Pelanggan.fromJson(map);
      if (map is List)
        return map.map((item) => Pelanggan.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Pelanggan?> getPelanggan(int id) async {
    final response = await get('pelanggan/$id');
    return response.body;
  }

  Future<Response<Pelanggan>> postPelanggan(Pelanggan pelanggan) async =>
      await post('pelanggan', pelanggan);
  Future<Response> deletePelanggan(int id) async =>
      await delete('pelanggan/$id');
}
