import 'package:budget/database/firestore_services.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class EditCategory extends StatefulWidget {
  final String category;
  final String color;

  const EditCategory({Key key, this.category, this.color}) : super(key: key);

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

final FireStoreServices fireStoreServices = FireStoreServices();

class _EditCategoryState extends State<EditCategory> {
  String color = '0xFFC4C4C4';
  String preCategoryName;
  String categoryName;

  TextEditingController text = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    color = widget.color;
    preCategoryName = widget.category;
    categoryName = widget.category;
    print(categoryName);
    setState(() {
      text.text = widget.category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Add Category',
            style: kBlackFontStyle.copyWith(
                fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Color',
                style: kBlackFontStyle,
              ),
              DropdownButton(
                onChanged: (value) {
                  setState(() {
                    color = value;
                  });
                },
                value: color,
                items: List.generate(
                  colorValues.length,
                  (index) {
                    return DropdownMenuItem<String>(
                      value: colorValues[index],
                      child: Container(
                        padding: EdgeInsets.all(8),
                        width: 48,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Color(int.parse(colorValues[index])),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Category',
                style: kBlackFontStyle,
              ),
              Container(
                width: 120,
                child: TextField(
                  controller: text,
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      categoryName = value;
                    });
                    print(categoryName);
                  },
                  textAlign: TextAlign.center,
                  style: kBlackFontStyle,
                  decoration: InputDecoration(
                    hintText: 'Category name',
                    hintStyle: kBlackFontStyle.copyWith(color: Colors.grey),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              FlatButton(
                color: Color(0xFF2F5A9B),
                onPressed: () {
                  print('$color $categoryName');

                  print(categoryName);

                  fireStoreServices.EditCategory(
                      categoryName, color, preCategoryName);
                  Navigator.pop(context);
                },
                child: Text(
                  'Edit',
                  style: kWhiteFontStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
