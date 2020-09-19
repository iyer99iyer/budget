import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableRowElement extends StatelessWidget {
  final double width;
  final String title;

  const TableRowElement({Key key, this.width, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class TableRowElementNumber extends StatelessWidget {
  final double width;
  final String title;

  const TableRowElementNumber({Key key, this.width, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }
}
