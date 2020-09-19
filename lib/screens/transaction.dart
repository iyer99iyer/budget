// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget/Widgets/table_row_elements.dart';
import 'package:budget/Widgets/table_title_widget.dart';
import 'package:budget/bottom_sheets/add_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(8),
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
                      width: size.width * .15,
                      title: 'Date',
                    ),
                    TableTitle(
                      width: size.width * .25,
                      title: 'Category',
                    ),
                    TableTitle(
                      width: size.width * .25,
                      title: 'Particular',
                    ),
                    TableTitle(
                      width: size.width * .2,
                      title: 'Amount',
                    ),
                    // TableTitle(
                    //   width: size.width * .1,
                    //   title: '',
                    // ),
                    // DeleteIcon(),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),

                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.black),
                //     color: Colors.green,
                //   ),
                //   padding: EdgeInsets.symmetric(vertical: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //
                //       TableRowElement(
                //         width: size.width * .15,
                //         title: '22/08',
                //       ),
                //
                //       TableRowElement(
                //         width: size.width * .25,
                //         title: 'Electrical',
                //       ),
                //       TableRowElement(
                //         width: size.width * .25,
                //         title: 'Material',
                //       ),
                //       TableRowElement(
                //         width: size.width * .2,
                //         title: '12,000',
                //       ),
                //       // DeleteIcon(),
                //     ],
                //   ),
                // ),
                Container(
                  height: size.height * .8,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('transaction')
                        .orderBy('date')
                        .limit(15)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return new ListView(
                        children:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                          Timestamp date = document.data()['date'];
                          print(
                              '${date.toDate().day} / ${date.toDate().month}|| ${date}');

                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Color(int.parse(document.data()['color'])),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TableRowElement(
                                  width: size.width * .15,
                                  title:
                                      '${date.toDate().day}/${date.toDate().month}',
                                ),
                                TableRowElement(
                                  width: size.width * .25,
                                  title: document.data()['category'],
                                ),
                                TableRowElement(
                                  width: size.width * .25,
                                  title: document.data()['particular'],
                                ),
                                TableRowElement(
                                  width: size.width * .2,
                                  title: document.data()['amount'].toString(),
                                ),
                                // DeleteIcon(),
                              ],
                            ),
                          );
                        }).toList(),
                      );
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
            height: MediaQuery.of(context).size.height * .7,
            child: Container(
              child: AddTransaction(),
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
