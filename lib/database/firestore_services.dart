import 'package:budget/models/category_model.dart';
import 'package:budget/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/transaction_model.dart';

class FireStoreServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTransaction(TransactionModel transactionModel) {
    return _db.collection('transaction').doc().set(transactionModel.toMap());
  }

  Future<void> addCategory(CategoryModel categoryModel) {
    return _db
        .collection('category')
        .doc(categoryModel.id)
        .set(categoryModel.toMap());
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categoryModels = [];

    await _db
        .collection('category')
        .orderBy('category')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                // print(CategoryModel.fromFirestore(doc.data()).color);
                categoryModels.add(CategoryModel.fromFirestore(doc.data()));
              })
            });
    return categoryModels;
  }

  Future<List<TransactionModel>> queryTransaction(String category) async {
    List<TransactionModel> transactionModels = [];

    await _db
        .collection('transaction')
        .where('category', isEqualTo: category)
        .orderBy('date', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(TransactionModel.fromFirestore(doc.data()).amount);
                transactionModels
                    .add(TransactionModel.fromFirestore(doc.data()));
              })
            });
    return transactionModels;
  }

  // Future<void> addTransaction(TransactionModel transactionModel) {
  //   return _db.collection('category').doc().set(transactionModel.toMap());
  // }
}
