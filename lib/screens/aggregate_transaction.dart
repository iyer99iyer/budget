import 'package:budget/constant.dart';
import 'package:budget/models/aggregate_transaction_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/table_row_elements.dart';
import '../Widgets/table_title_widget.dart';
import '../database/firestore_services.dart';
import '../models/category_model.dart';
import '../models/transaction_model.dart';

class AggregateTransaction extends StatefulWidget {
  @override
  _AggregateTransactionState createState() => _AggregateTransactionState();
}

FireStoreServices fireStoreServices = FireStoreServices();

List<String> categoryList = [];

List<TransactionModel> transactions = [];

List<AggregateTransactionModel> aggregated = [];

String currentColor;

bool noTransaction = true;

double finalTotalAmount;

bool loading = true;

class _AggregateTransactionState extends State<AggregateTransaction> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategories();
  }

  getCategories() async {
    categoryList.clear();
    aggregated.clear();
    finalTotalAmount = 0;

    List<CategoryModel> categories = await fireStoreServices.getCategories();

    if (categories != null) {
      setState(() {
        noTransaction = false;
      });

      for (CategoryModel model in categories) {
        print(model.category);
        categoryList.add(model.category);
      }

      for (String category in categoryList) {
        await getCategoryTransaction(category);
      }

      for (AggregateTransactionModel a in aggregated) {
        // print('${a.category} : ${a.totalAmount}');
        finalTotalAmount += a.totalAmount;
        print(
            '**************color: ${a.color} category: ${a.category}, totalAmount: ${a.totalAmount}************');
      }
    } else {
      setState(() {
        noTransaction = true;
      });
    }
  }

  getCategoryTransaction(String category) async {
    transactions.clear();

    transactions = await fireStoreServices.queryTransaction(category);

    setState(() {
      transactions = transactions;
    });

    if (transactions != null) {
      double totalAmount = getTotalAmount();

      print(transactions.length);

      print(
          'category: $category, totalAmount: $totalAmount, color: $currentColor');

      aggregated.add(AggregateTransactionModel(
          category: category, totalAmount: totalAmount, color: currentColor));
    }
  }

  double getTotalAmount() {
    double totalAmount = 0;

    currentColor = transactions[0].color;

    for (TransactionModel t in transactions) {
      totalAmount += t.amount;
    }
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aggregate Transaction',
          style: kWhiteFontStyle,
        ),
        backgroundColor: kAggregateTransaction,
        centerTitle: true,
      ),
      body: noTransaction
          ? Center(child: Text('+ Please add transaction'))
          : Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      TableTitle(
                        width: size.width * .48,
                        title: 'Category',
                      ),
                      TableTitle(
                        width: size.width * .475,
                        title: 'Amount',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: size.height * .6,
                    child: ListView(
                      children: List.generate(aggregated.length, (index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Color(int.parse(aggregated[index].color)),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TableRowElement(
                                width: size.width * .48,
                                title: aggregated[index].category,
                              ),

                              TableRowElementNumber(
                                width: size.width * .3,
                                title: aggregated[index]
                                    .totalAmount
                                    .toStringAsFixed(0),
                              ),
                              TableRowElement(
                                width: size.width * .15,
                                title: '',
                              ),
                              // DeleteIcon(),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${finalTotalAmount.toStringAsFixed(0)}/-',
                          style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
