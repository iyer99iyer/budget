import 'package:budget/bottom_sheets/add_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/table_title_widget.dart';

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
                    TableTitle(
                      width: size.width * .3,
                      title: 'Color',
                    ),
                    TableTitle(
                      width: size.width * .3,
                      title: 'Category',
                    ),
                    TableTitle(
                      width: size.width * .3,
                      title: 'Action',
                    ),
                  ],
                ),
                Container(
                  height: 180,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('category')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading data... Please wait...');
                      } else {
                        return ListView(
                          children: snapshot.data.documents
                              .map<Widget>((DocumentSnapshot document) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: size.width * .3,
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        width: 48,
                                        height: 24,
                                        color: Color(int.parse(
                                            document.data()['color'])),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: size.width * .3,
                                      child: Center(
                                          child: Text(
                                              document.data()['category']))),
                                  Container(
                                    width: size.width * .3,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
