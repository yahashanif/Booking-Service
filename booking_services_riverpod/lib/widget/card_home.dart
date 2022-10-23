
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardHome extends StatelessWidget {
  final Function() onTap;
  final Icon icon;
  final String text;

  const CardHome({super.key, required this.onTap, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              text,
              style: GoogleFonts.raleway(
                  fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}