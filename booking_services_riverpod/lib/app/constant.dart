
import 'package:flutter/material.dart';

class Constant{

  static String baseURL = "http://10.234.222.163:9000/";
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
}