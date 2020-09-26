import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TableTitle extends StatelessWidget {
  final double width;
  final String title;

  const TableTitle({Key key, this.width, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.patrickHandSc(
            fontSize: 17,
            color: Colors.black,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
