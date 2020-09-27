import 'package:budget/constant.dart';
import 'package:budget/database/firestore_services.dart';
import 'package:budget/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

List<String> colorValues = [
  '0xFF99FF90',
  '0xFFC4C4C4',
  '0xFFF3E09B',
  '0xFFffc1f3',
  '0xFFfce2ce',
  '0xFFf9f7d9',
  '0xFFcffffe',
];
String color = '0xFFC4C4C4';
String categoryName;

final FireStoreServices fireStoreServices = FireStoreServices();

var uuid = Uuid();

class _AddCategoryState extends State<AddCategory> {
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
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      categoryName = value;
                    });
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Category name',
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            color: Color(0xFF2F5A9B),
            onPressed: () {
              print('$color $categoryName');
              var category = CategoryModel(
                id: uuid.v4(),
                color: color,
                category: categoryName,
              );
              fireStoreServices.addCategory(category);
              Navigator.pop(context);
            },
            child: Text(
              'Add Category',
              style: kWhiteFontStyle,
            ),
          ),
        ],
      ),
    );
  }
}
