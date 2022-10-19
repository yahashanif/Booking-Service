import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/controllers/umum_controller.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final umumC = Get.put(UmumController(), permanent: true);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
