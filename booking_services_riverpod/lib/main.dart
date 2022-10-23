import 'package:booking_services_riverpod/app/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Booking Service',
      theme: ThemeData(
        fontFamily: "Inter",
      ),
      initialRoute: splashRoute,
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}