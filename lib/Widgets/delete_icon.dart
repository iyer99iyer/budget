import 'package:flutter/material.dart';

class DeleteIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * .1,
      child: Icon(
        Icons.cancel,
        color: Colors.red,
      ),
    );
  }
}
