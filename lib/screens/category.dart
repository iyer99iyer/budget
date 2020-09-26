import 'package:budget/bottom_sheets/add_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: Color(0xFF2F5A9B),
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
                                    width: size.width * .35,
                                    child: Center(
                                      child: Text(
                                        document.data()['category'],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.patrickHandSc(
                                          fontSize: 20,
                                          color: Colors.black,
                                          letterSpacing: 1.5,
                                        ),
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
        backgroundColor: Color(0xFF2F5A9B),
        onPressed: () => _onButtonPressed(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
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
