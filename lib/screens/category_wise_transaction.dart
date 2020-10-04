import 'package:budget/Widgets/table_row_elements.dart';
import 'package:budget/Widgets/table_title_widget.dart';
import 'package:budget/database/firestore_services.dart';
import 'package:budget/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/transaction_model.dart';

class CategoryWiseTransaction extends StatefulWidget {
  @override
  _CategoryWiseTransactionState createState() =>
      _CategoryWiseTransactionState();
}

FireStoreServices fireStoreServices = FireStoreServices();

List<String> categoryList = [];

List<TransactionModel> transactions = [];

bool loading = true;

String currentCategory;

double totalAmount = 0;

class _CategoryWiseTransactionState extends State<CategoryWiseTransaction> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    getCategories();
  }

  getCategories() async {
    categoryList.clear();

    List<CategoryModel> categories = await fireStoreServices.getCategories();

    for (CategoryModel model in categories) {
      print(model.category);
      categoryList.add(model.category);
    }
    setState(() {
      loading = false;
      currentCategory = categoryList[0];
    });
    getCategoryTransaction(currentCategory);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Category Wise Transaction',
          style: kWhiteFontStyle,
        ),
        backgroundColor: kCategoryWiseTransaction,
      ),
      body: loading
          ? Center(child: Text('Loading'))
          : Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Category',
                          style: kBlackFontStyle.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                        DropdownButton(
                          onChanged: (value) {
                            setState(() {
                              currentCategory = value;
                            });
                            getCategoryTransaction(currentCategory);
                          },
                          value: currentCategory,
                          items: List.generate(
                            categoryList.length,
                            (index) {
                              return DropdownMenuItem<String>(
                                  value: categoryList[index],
                                  child: Text(
                                    categoryList[index],
                                    style: kBlackFontStyle.copyWith(
                                        fontSize: 18, letterSpacing: .5),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  transactions.isEmpty
                      ? Center(
                          child: Text(
                          'No Transaction For this Category',
                          style: kBlackFontStyle,
                        ))
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TableTitle(
                                  width: size.width * .15,
                                  title: 'Date',
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
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              height: size.height * .6,
                              decoration: BoxDecoration(
                                // color: kCategoryWiseTransaction,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListView(
                                children:
                                    List.generate(transactions.length, (index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black),
                                      color: Color(
                                          int.parse(transactions[index].color)),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TableRowElement(
                                          width: size.width * .005,
                                          title: '',
                                        ),
                                        TableRowElement(
                                          width: size.width * .22,
                                          title:
                                              '${transactions[index].date.toDate().day}/${transactions[index].date.toDate().month}',
                                        ),

                                        TableRowElement(
                                          width: size.width * .26,
                                          title: transactions[index].particular,
                                        ),
                                        TableRowElementNumber(
                                          width: size.width * .25,
                                          title: transactions[index]
                                              .amount
                                              .toStringAsFixed(0),
                                        ),

                                        // DeleteIcon(),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black),
                                color: kCategoryWiseTransaction,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Total',
                                    style: kWhiteFontStyle,
                                  ),
                                  SizedBox(
                                    width: 80,
                                  ),
                                  Text(
                                    '${totalAmount.toStringAsFixed(0)}/-',
                                    style: kWhiteFontStyle,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
    );
  }

  getCategoryTransaction(String category) async {
    totalAmount = 0;
    transactions.clear();

    transactions = await fireStoreServices.queryTransaction(category);

    setState(() {
      transactions = transactions;
    });

    if (transactions != null) {
      getTotalAmount();

      print(transactions.length);
    }
  }

  getTotalAmount() {
    for (TransactionModel t in transactions) {
      totalAmount += t.amount;
    }
  }
}
