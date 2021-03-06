import 'package:budget/constant.dart';
import 'package:budget/database/firestore_services.dart';
import 'package:budget/models/category_model.dart';
import 'package:budget/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

FireStoreServices fireStoreServices = FireStoreServices();
var uuid = Uuid();

List<String> categoryList = [];

Map<String, String> categoryMap = {};

bool loading = true;

String particularName;

String currentCategory;

double amount;

class _AddTransactionState extends State<AddTransaction> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    getCategories();
  }

  getCategories() async {
    categoryList.clear();
    categoryMap.clear();

    List<CategoryModel> categories = await fireStoreServices.getCategories();

    for (CategoryModel model in categories) {
      print(model.category);
      categoryList.add(model.category);

      categoryMap[model.category] = model.color;
    }
    setState(() {
      loading = false;
      currentCategory = categoryList[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            child: Center(
                child: Text(
              'Checking Categories',
              style: kBlackFontStyle,
            )),
          )
        : Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Add Category',
                  style: kBlackFontStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 24),
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
                          currentCategory = value;
                        });
                      },
                      value: currentCategory,
                      items: List.generate(
                        categoryList.length,
                        (index) {
                          return DropdownMenuItem<String>(
                            value: categoryList[index],
                            child: Text(
                              categoryList[index],
                              style:
                                  kBlackFontStyle.copyWith(letterSpacing: .5),
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
                      'Particular',
                      style: kBlackFontStyle,
                    ),
                    Container(
                      width: 120,
                      child: TextField(
                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            particularName = value;
                          });
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(hintText: 'Particular'),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Amount',
                      style: kBlackFontStyle,
                    ),
                    Container(
                      width: 120,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        onChanged: (value) {
                          setState(() {
                            amount = double.parse(value);
                          });
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(hintText: 'amount'),
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(12),
                          WhitelistingTextInputFormatter.digitsOnly,
                        ],
                      ),
                    )
                  ],
                ),
                FlatButton(
                  color: Color(0xFFBB3C3C),
                  onPressed: () async {
                    print('${amount.toStringAsFixed(2)}');

                    var transaction = TransactionModel(
                      id: uuid.v4(),
                      date: Timestamp.now(),
                      particular: particularName,
                      color: categoryMap[currentCategory],
                      amount: amount,
                      category: currentCategory,
                    );
                    fireStoreServices.addTransaction(transaction);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add Transaction',
                    style: kWhiteFontStyle,
                  ),
                ),
              ],
            ),
          );
  }
}
