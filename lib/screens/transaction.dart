import 'package:budget/bottom_sheets/add_transaction.dart';
import 'package:budget/bottom_sheets/edit_transaction.dart';
import 'package:budget/constant.dart';
import 'package:budget/database/firestore_services.dart';
import 'package:budget/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

FireStoreServices fireStoreServices = FireStoreServices();

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transactions',
          style: kWhiteFontStyle,
        ),
        backgroundColor: kTransactionColor,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                ),
                //Titles
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     TableTitle(
                //       width: size.width * .15,
                //       title: 'Date',
                //     ),
                //     TableTitle(
                //       width: size.width * .25,
                //       title: 'Category',
                //     ),
                //     TableTitle(
                //       width: size.width * .25,
                //       title: 'Particular',
                //     ),
                //     TableTitle(
                //       width: size.width * .2,
                //       title: 'Amount',
                //     ),
                //     // TableTitle(
                //     //   width: size.width * .1,
                //     //   title: '',
                //     // ),
                //     // DeleteIcon(),
                //   ],
                // ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                  height: size.height * .7,
                  width: size.width * .9,
                  decoration: BoxDecoration(
                    //   // color: kTransactionColor,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('transaction')
                        .orderBy('date', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: Text('Loading'));
                      }
                      //
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return Center(child: Text("Loading"));
                      // }

                      return ListView(
                        children:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                          Timestamp date = document.data()['date'];

                          return GestureDetector(
                            onLongPress: () {
                              print(
                                  "${document.data()['particular']}, ${double.parse(document.data()['amount'].toString()).toStringAsFixed(0)}/- , ${document.data()['id']}");
                              TransactionModel transaction = TransactionModel(
                                id: document.data()['id'],
                                category: document.data()['category'],
                                particular: document.data()['particular'],
                                amount: double.parse(
                                    document.data()['amount'].toString()),
                              );
                              print(transaction.id);
                              _onLongButtonPressed(transaction);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black),
                                // color: Colors.white,
                                color:
                                    Color(int.parse(document.data()['color'])),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title: Text(
                                  "${document.data()['particular']}",
                                  style: kBlackFontStyle,
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Color(
                                      int.parse(document.data()['color'])),
                                  child: Text(
                                    '${date.toDate().day}/${date.toDate().month}',
                                    style:
                                        kBlackFontStyle.copyWith(fontSize: 18),
                                  ),
                                ),
                                subtitle: Text(
                                  '${document.data()['category']}',
                                  style: kBlackFontStyle.copyWith(
                                      fontSize: 20, color: Colors.grey),
                                ),
                                trailing: Text(
                                  "${double.parse(document.data()['amount'].toString()).toStringAsFixed(0)}/-",
                                  style: kBlackFontStyle,
                                ),
                              ),
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
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: kTransactionColor,
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

  _onLongButtonPressed(TransactionModel transactionModel) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: MediaQuery.of(context).size.height * .7,
            child: Container(
              child: EditTransaction(
                transactionModel: transactionModel,
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
}

// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// TableRowElement(
// width: size.width * .15,
// title:
// '${date.toDate().day}/${date.toDate().month}',
// ),
// TableRowElement(
// width: size.width * .25,
// title: document.data()['category'],
// ),
// TableRowElement(
// width: size.width * .25,
// title: document.data()['particular'],
// ),
// TableRowElementNumber(
// width: size.width * .2,
// title:
// "${double.parse(document.data()['amount'].toString()).toStringAsFixed(0)}/-",
// ),
// // DeleteIcon(),
// ],
// ),
