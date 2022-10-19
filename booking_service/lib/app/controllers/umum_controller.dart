import 'dart:convert';

import 'package:booking_service/app/data/models/pelanggan_model.dart';
import 'package:booking_service/app/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../data/models/booking_model.dart';
import '../data/models/request_model.dart';

String baseURL = "http://192.168.43.151:9000/";

class UmumController extends GetxController {
  var pelanggans = <Pelanggan>[].obs;
  var bookings = <Booking>[].obs;
  var products = <Product>[].obs;
  var editPelanggan = Pelanggan().obs;
  var list1 = <Product>[].obs;
  var list2 = <Product>[].obs;
  var list3 = <Product>[].obs;
  var editBooking = Booking().obs;
  var user = User().obs;
  final box = GetStorage();
  var token = "".obs;

  void getPelanggan() async {
    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer ${token.value}"
    };
    pelanggans.clear();
    var url = baseURL + "api/user/Pelanggan";
    var response = await http.get(Uri.parse(url), headers: header);
    List<Pelanggan> list = [];
    var data = jsonDecode(response.body);
    List dataList = data['data'] as List;
    print(response.body);

    if (response.statusCode == 200) {
      list = dataList.map((e) => Pelanggan.fromJson(e)).toList();
      list.map((e) => pelanggans.add(e)).toList();
    }
    print(list);
  }

  void getProduct() async {
    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer ${token.value}"
    };
    products.clear();
    var url = baseURL + "api/user/products";
    var response = await http.get(Uri.parse(url), headers: header);
    List<Product> list = [];
    var data = jsonDecode(response.body);
    List dataList = data['data'] as List;
    print(response.body);

    if (response.statusCode == 200) {
      list = dataList.map((e) => Product.fromJson(e)).toList();
      list.map((e) => products.add(e)).toList();
      // list1.value = products.map((element) => element).where((element) => element.categories!.id == 1).toList();
      // list2.value = products.map((element) => element).where((element) => element.categories!.id == 2).toList();
    }
    print(list);
  }

  void inputPelanggan(Pelanggan p) async {
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token.value}"
    };
    var url = baseURL + "api/user/Pelanggan";
    var body = jsonEncode(p.toJson());
    print(body);
    var response = await http.post(Uri.parse(url), headers: header, body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      getPelanggan();
      Get.back();
    } else {
      Get.snackbar("Failed", "Gagal Menambahkan Data");
    }
  }

  void updatePelanggan(Pelanggan p) async {
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token.value}"
    };
    var url = baseURL + "api/user/PelangganUpdate";
    var body = jsonEncode(p.toJson2());
    print(body);
    var response = await http.post(Uri.parse(url), headers: header, body: body);
    print(response.body);
    if (response.statusCode == 200) {
      getPelanggan();
      Get.back();
    } else {
      Get.snackbar("Failed", "Gagal Update Data");
    }
  }

  void DeletePelanggan(int id) async {
    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer ${token.value}"
    };
    var url = baseURL + "api/user/PelangganDelete";
    var response = await http
        .post(Uri.parse(url), headers: header, body: {"id": id.toString()});
    print(response.body);
    if (response.statusCode == 200) {
      getPelanggan();
    } else {
      Get.snackbar("Failed", "Gagal Hapus Data");
    }
  }

  void getBooking(String tgl) async {
    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer ${token.value}"
    };
    bookings.clear();
    var url = baseURL + "api/user/booking/" + tgl;
    var response = await http.get(Uri.parse(url), headers: header);
    List<Booking> list = [];
    var data = jsonDecode(response.body);
    List dataList = data['data'] as List;
    print(response.body);
    print(url);

    if (response.statusCode == 200) {
      list = dataList.map((e) => Booking.fromJson(e)).toList();
      list.map((e) => bookings.add(e)).toList();
    }
    print(list);
  }

  void inputBooking(BookingRequest b) async {
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token.value}"
    };

    var url = baseURL + "api/user/booking";
    var body = jsonEncode(b.toJson());
    print(body);
    var response = await http.post(Uri.parse(url), headers: header, body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      getBooking(DateFormat('yyyy-MM-dd').format(DateTime.now()));
      Get.back();
    } else {
      Get.snackbar("Failed", "Gagal Menambahkan Data");
    }
  }

  void updateBooking(BookingRequest b, String id) async {
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${token.value}"
    };

    var url = baseURL + "api/user/Updatebooking";
    var body = jsonEncode(b.toJson2(int.parse(id)));
    print(body);
    var response = await http.post(Uri.parse(url), headers: header, body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      getBooking(DateFormat('yyyy-MM-dd').format(DateTime.now()));
      Get.back();
    } else {
      Get.snackbar("Failed", "Gagal Menambahkan Data");
    }
  }

  void DeleteBooking(int id) async {
    var header = {
      "Accept": "application/json",
      "Authorization": "Bearer ${token.value}"
    };
    var url = baseURL + "api/user/deleteBooking/" + id.toString();
    print(url);
    var response = await http.get(Uri.parse(url), headers: header);
    print(response.body);
    if (response.statusCode == 200) {
      getPelanggan();
    } else {
      Get.snackbar("Failed", "Gagal Hapus Data");
    }
  }

  void Login(String username, String pass) async {
    var header = {
      "Accept": "application/json",
    };
    var url = baseURL + "auth/login";
    print(url);
    var response = await http.post(Uri.parse(url),
        headers: header, body: {"username": username, "password": pass});
    var data = jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var datauser = data['data']['data'];
      user.value = User.fromJson(datauser);
      box.write("login", true);
      box.write("token", data['token']);
      box.write("user", user.value);
      Get.offAllNamed("/home");
    } else {
      Get.snackbar(
        "Failed",
        "Gagal Login",
        colorText: Colors.white,
        backgroundColor: Colors.red[300],
        icon: Icon(Icons.warning, color: Colors.white),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void CheckLogin() {
    print(box.read("user"));
    if (box.read("login") == true) {
      token.value = box.read("token");
      user.value = User.fromJson(box.read("user"));
      Get.offAllNamed("/home");
    } else {
      Get.toNamed("/login");
    }
  }

  void Logout() {
    box.remove("login");
    box.remove("user");
    box.remove("token");
    box.write("login", false);
    Get.offAllNamed("/login");
  }
}
