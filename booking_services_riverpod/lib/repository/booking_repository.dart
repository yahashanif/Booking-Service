import 'dart:convert';

import 'package:booking_services_riverpod/app/constant.dart';
import 'package:booking_services_riverpod/model/booking_model.dart';
import 'package:booking_services_riverpod/repository/base_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/request_model.dart';

class BookingRepository extends BaseRepository {
  BookingRepository({required super.dio});

  Future<List<Booking>> listBooking({required String tgl}) async {
    String token = "";
    await Constant().getShared().then((value) {
      print(value);
      token = value;
    });
    // final shared = await SharedPreferences.getInstance();
    final param = tgl;
    final resp = await gets(
        services: Constant.baseURLToken + "booking",
        param: param,
        token: token);
    // print(resp);
    List<Booking> result = List.empty(growable: true);
    if (resp["data"] == null) {
      result = [];
    } else {
      resp["data"].forEach((e) {
        final model = Booking.fromJson(e);
        print(model.total);
        result.add(model);
      });
    }
    return result;
  }

  Future<List<Product>> listProduct() async {
    String token = "";
    await Constant().getShared().then((value) {
      print(value);
      token = value;
    });
    final resp =
        await gets(services: Constant.baseURLToken + "products", token: token);
    // print(resp);
    List<Product> result = List.empty(growable: true);
    if (resp["data"] == null) {
      result = [];
    } else {
      resp["data"].forEach((e) {
        final model = Product.fromJson(e);
        result.add(model);
      });
    }
    return result;
  }

  Future<bool> inputBooking(BookingRequest b) async {
    String token = "";
    await Constant().getShared().then((value) {
      print(value);
      token = value;
    });
    final body = b.toJson();

    final service = "${Constant.baseURLToken}booking";
    print(service);
    final resp = await post(
      body: body,
      service: service,
      token: token,
    );
    print(resp.toString());
    if (resp['status'] == "200") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> DeleteBooking(String id) async {
    String token = "";
    await Constant().getShared().then((value) {
      print(value);
      token = value;
    });
    final service = "${Constant.baseURLToken}deleteBooking";
    final body = <String, dynamic>{};

    final resp = await gets(
      param: id,
      token: token,
      services: service,
    );
    print(body);
    if (resp['status'] == "200") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editBooking(BookingRequest b, String id) async {
    String token = "";
    await Constant().getShared().then((value) {
      print(value);
      token = value;
    });
    final body = b.toJson2(int.parse(id));
    final service = "${Constant.baseURLToken}Updatebooking";
    print(service);
    final resp = await post(
      body: body,
      service: service,
      token: token,
    );
    print(resp.toString());
    if (resp['status'] == "200") {
      return true;
    } else {
      return false;
    }
  }
}
