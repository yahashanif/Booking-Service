
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({ required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20,top: MediaQuery.of(context).viewPadding.top),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            InkWell(
                onTap: () {
                  // Get.back();
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios)),
            Spacer(),
            Text(
              "${title}",
              style: GoogleFonts.raleway(
                  fontSize: 15, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
