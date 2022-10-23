
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constant{

  static String baseURL = "http://192.168.43.151:9000/";
  static String baseURLToken = "${baseURL}api/user/";
  static String baseWithoutURLToken = "${baseURL}auth/";

 static String bearerName = "app-booking-service";

  void showSnackBarError(BuildContext context,String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.pink,
      content: Text('${message}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<String> getShared() async{
     final shared = await SharedPreferences.getInstance();
    final xmodel = jsonDecode(shared.get(Constant.bearerName).toString());
    String token = xmodel['token'];
    return token;
  }
}