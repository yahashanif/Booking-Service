import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController ctrl;
  final TextInputType type;
  final int maxline;

  const CustomTextField(
      {required this.hintText,
      required this.isPassword,
      required this.ctrl,
      required this.type,
      required this.maxline});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: ctrl,
      obscureText: isPassword,
      keyboardType: type,
      maxLines: maxline,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: '${hintText}',
      ),
    );
  }
}
