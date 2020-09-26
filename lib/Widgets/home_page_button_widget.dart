import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageBigButton extends StatelessWidget {
  final Color color;
  final String text;
  final String imageLocation;

  const HomePageBigButton({
    Key key,
    this.color,
    this.text,
    this.imageLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: size.height * .25,
        width: size.width * .4,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 5.0,
              offset: Offset(
                4,
                10,
              ),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 100,
              child: Image(
                image: AssetImage(imageLocation),
              ),
            ),
            Text(
              text,
              style: GoogleFonts.patrickHandSc(
                fontSize: 22,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageLongButton extends StatelessWidget {
  final Color color;
  final String text;

  const HomePageLongButton({Key key, this.color, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: 70,
        width: size.width * .9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 5.0,
              offset: Offset(
                4,
                10,
              ),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.patrickHandSc(
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
