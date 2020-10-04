import 'package:budget/database/firestore_services.dart';
import 'package:budget/models/category_model.dart';
import 'package:budget/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant.dart';

class EditTransaction extends StatefulWidget {
  final TransactionModel transactionModel;

  const EditTransaction({Key key, this.transactionModel}) : super(key: key);

  @override
  _EditTransactionState createState() => _EditTransactionState();
}

FireStoreServices fireStoreServices = FireStoreServices();

List<String> categoryList = [];

Map<String, String> categoryMap = {};

bool loading = true;

String particularName;
String preParticularName;

String currentCategory;

double amount;
double preAmount;

TextEditingController particularText = TextEditingController();
TextEditingController amountText = TextEditingController();

class _EditTransactionState extends State<EditTransaction> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    getCategories();

    preParticularName = widget.transactionModel.particular;
    preAmount = widget.transactionModel.amount;

    setState(() {
      currentCategory = widget.transactionModel.category;
      particularText.text = widget.transactionModel.particular;
      amountText.text = widget.transactionModel.amount.toString();
    });
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
                  'Edit Transaction',
                  style: kBlackFontStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Category',
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
                        controller: particularText,
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
                        controller: amountText,
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
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      color: Colors.green,
                      onPressed: () async {
                        // print('${amount.toStringAsFixed(2)}');

                        var transaction = TransactionModel(
                          id: widget.transactionModel.id,
                          particular: particularName == null
                              ? preParticularName
                              : particularName,
                          amount: amount == null ? preAmount : amount,
                          category: currentCategory,
                        );

                        print(
                            '${transaction.amount}, ${transaction.particular}');

                        fireStoreServices.editTransaction(transaction);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Edit Transaction',
                        style: kWhiteFontStyle,
                      ),
                    ),
                    FlatButton(
                      color: kTransactionColor,
                      onPressed: () {
                        fireStoreServices
                            .deleteTransaction(widget.transactionModel.id);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Delete',
                        style: kWhiteFontStyle,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
  }
}
