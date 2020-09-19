import 'package:flutter/material.dart';

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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
