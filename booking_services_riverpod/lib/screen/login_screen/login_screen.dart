import 'package:booking_services_riverpod/app/constant.dart';
import 'package:booking_services_riverpod/app/route.dart';
import 'package:booking_services_riverpod/screen/login_screen/login_provider.dart';
import 'package:booking_services_riverpod/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final ctrlUsername = useTextEditingController();
    final ctrlPass = useTextEditingController();
    final isLoading = useState(false);
    final errorMessage = useState("");
    final isPasswordObscured = useState<bool>(true);

    ref.listen(loginProvider, (previous, next) {
      print(next);
      if (next is LoginStateLoading) {
        isLoading.value = true;
      } else if (next is LoginStateError) {
        isLoading.value = false;
        print(next.message);
        errorMessage.value = next.message;
      } else if (next is LoginStateDone) {
        isLoading.value = false;
        Navigator.of(context).pushReplacementNamed(homeRoute);
      }
    });

    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Login",
            style: GoogleFonts.raleway(
              fontSize: 30,
            ),
          )),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
              hintText: "Username",
              isPassword: false,
              ctrl: ctrlUsername,
              type: TextInputType.name,
              maxline: 1),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
              hintText: "*****",
              isPassword: isPasswordObscured.value,
              ctrl: ctrlPass,
              type: TextInputType.text,
              maxline: 1),
          SizedBox(
            height: 20,
          ),
          isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : TextButton(
                  onPressed: () {
                    if (ctrlUsername.text.isEmpty || ctrlPass.text.isEmpty) {
                      Constant().showSnackBarError(
                          context, "Username Atau Password Tidak Boleh Kosong");
                    } else {
                      ref.read(loginProvider.notifier).login(
                          username: ctrlUsername.text, password: ctrlPass.text);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green,
                    ),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      "Login",
                      style: GoogleFonts.raleway(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ))
        ],
      ),
    ));
  }
}
