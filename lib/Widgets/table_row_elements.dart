import 'package:budget/constant.dart';
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
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: kBlackFontStyle.copyWith(fontSize: 20),
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
        '$title/-',
        style: kBlackFontStyle.copyWith(fontSize: 22),
        textAlign: TextAlign.end,
      ),
    );
  }
}
