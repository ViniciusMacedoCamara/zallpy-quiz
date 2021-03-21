import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NetworkErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'assets/img/dino.png',
            color: Colors.white,
          ),
        ),
        Text(
          'Oops',
          style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xff7AFF98)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Looks like you don\'t',
            style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff7AFF98)),
          ),
        ),
        Text(
          'have internet connection.',
          style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff7AFF98)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 76, 0, 0),
          child: Text(
            'Made with ❤ by Vinicius Macedo Camara',
            style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
