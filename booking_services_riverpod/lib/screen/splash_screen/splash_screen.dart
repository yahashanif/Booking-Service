import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import '../../app/constant.dart';
import '../../app/route.dart';
import '../../model/user_model.dart';
import '../../provider/current_user_provider.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        print("wahaha");
        final shared = await SharedPreferences.getInstance();
        final bearerString = shared.get(Constant.bearerName).toString();
        final xmodel = jsonDecode(bearerString);
        print(bearerString);
        Future.delayed(const Duration(seconds: 3), () {
          if (xmodel == null) {
            Navigator.of(context).pushReplacementNamed(loginRoute);
          } else {
            final loginDate = DateTime.parse(xmodel["date"]);
            print("loginDate : $loginDate");
            print(xmodel);
            final authModel = AuthModel(
              token: xmodel["token"],
              model: User(
                  email: xmodel["model"]["email"],
                  id: xmodel["model"]["id"],
                  level: xmodel["model"]["level"],
                  name: xmodel["model"]["name"],
                  profilPathUrl: xmodel["model"]["profil_path_url"],
                  username: xmodel["model"]["username"]),
            );
            ref.read(currentUserProvider.notifier).state = authModel;
                     Navigator.of(context).pushReplacementNamed(homeRoute);

          }
        });
        //   ref
        //       .read(loginProvider.notifier)
        //       .login(username: "dede", doctorID: "123", password: "xtrial123");
      });
    }, []);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Booking Services",
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              LottieBuilder(
                  lottie: AssetLottie("assets/lottie/logo_splash.json")),
            ],
          ),
        ),
      ),
    );
  }
}
