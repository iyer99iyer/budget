import 'package:budget/bottom_sheets/add_category.dart';
import 'package:budget/bottom_sheets/edit_category.dart';
import 'package:budget/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/table_title_widget.dart';
import '../constant.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

List<String> categoryNames = ['Electrical', 'Plumbing', 'material'];

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
        backgroundColor: kCategoryColor,
        title: Text(
          'Add Category',
          style: GoogleFonts.patrickHandSc(
            fontSize: 24,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TableTitle(
                      width: size.width * .2,
                      title: 'Color',
                    ),
                    TableTitle(
                      width: size.width * .35,
                      title: 'Category',
                    ),
                    TableTitle(
                      width: size.width * .3,
                      title: 'Action',
                    ),
                  ],
                ),
                Container(
                  height: size.height * .8,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('category')
                        .orderBy('category')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading data... Please wait...');
                      } else {
                        return ListView(
                          children: snapshot.data.documents
                              .map<Widget>((DocumentSnapshot document) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              margin: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  //color
                                  Container(
                                    width: size.width * .2,
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        width: 48,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: Color(int.parse(
                                              document.data()['color'])),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //Category Name
                                  Container(
                                    padding: EdgeInsets.only(left: 30),
                                    width: size.width * .35,
                                    child: Text(
                                      document.data()['category'],
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.patrickHandSc(
                                        fontSize: 25,
                                        color: Colors.black,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * .3,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: kCategoryColor,
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              border: Border.all(
                                                  color: Colors.black),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                print(
                                                    "${document.data()['category']}, ${document.data()['color']} ");

                                                CategoryModel categoryModel =
                                                    CategoryModel(
                                                  id: document.data()['id'],
                                                  color:
                                                      document.data()['color'],
                                                  category: document
                                                      .data()['category'],
                                                );

                                                _onEditButtonPressed(
                                                    categoryModel);
                                              },
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                  ),
                                                  Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            padding: EdgeInsets.all(8),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ); //
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kCategoryColor,
        onPressed: () => _onButtonPressed(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _onEditButtonPressed(CategoryModel categoryModel) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: MediaQuery.of(context).size.height * .7,
            child: Container(
              child: EditCategory(
                categoryModel: categoryModel,
              ),
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

  _onButtonPressed() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: MediaQuery.of(context).size.height * .7,
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
