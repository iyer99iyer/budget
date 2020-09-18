import 'package:budget/database/firestore_services.dart';
import 'package:budget/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

List<String> colorValues = ['0xFF99FF90', '0xFFC4C4C4', '0xFFF3E09B'];
List<String> categoryNames = ['Electrical', 'Plumbing', 'material'];

String color = '0xFFC4C4C4';
String categoryName;

final FireStoreServices fireStoreServices = FireStoreServices();

var uuid = Uuid();

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryFromFireStore();
  }

  getCategoryFromFireStore() async {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: size.width * .3,
                      child: Center(
                        child: Text(
                          'Color',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * .3,
                      child: Center(
                        child: Text(
                          'Category',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * .3,
                      child: Center(
                        child: Text(
                          'Action',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: List.generate(colorValues.length, (index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: size.width * .3,
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                width: 48,
                                height: 24,
                                color: Color(int.parse(colorValues[index])),
                              ),
                            ),
                          ),
                          Container(
                              width: size.width * .3,
                              child: Center(child: Text(categoryNames[index]))),
                          Container(
                            width: size.width * .3,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Icon(Icons.edit),
                                  ),
                                  Container(
                                    child: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onButtonPressed(),
        child: Icon(Icons.add),
      ),
    );
  }

  _onButtonPressed() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: MediaQuery.of(context).size.height * .62,
            child: Container(
              child: AddCategory(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }
}

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Color'),
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
                        color: Color(int.parse(colorValues[index])),
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
              Text('Category'),
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
                  decoration: InputDecoration(hintText: 'Category name'),
                ),
              )
            ],
          ),
          FlatButton(
            color: Colors.blue,
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
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
