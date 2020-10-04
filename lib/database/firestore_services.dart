import 'package:budget/models/category_model.dart';
import 'package:budget/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/transaction_model.dart';

class FireStoreServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTransaction(TransactionModel transactionModel) {
    return _db
        .collection('transaction')
        .doc(transactionModel.id)
        .set(transactionModel.toMap());
  }

  Future<void> editTransaction(TransactionModel transactionModel) async {
    print('in database ## ${transactionModel.id}');
    return _db
        .collection('transaction')
        .doc(transactionModel.id)
        .update({
          'category': transactionModel.category,
          'particular': transactionModel.particular,
          'amount': transactionModel.amount
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteTransaction(transactionID) async {
    print('in database ## $transactionID}');
    return _db
        .collection('transaction')
        .doc(transactionID)
        .delete()
        .then((value) => print("transaction Deleted"))
        .catchError((error) => print("Failed to delete Transaction : $error"));
  }

  Future<void> addCategory(CategoryModel categoryModel) {
    return _db
        .collection('category')
        .doc(categoryModel.id)
        .set(categoryModel.toMap());
  }

  Future<void> editCategory(CategoryModel categoryModel) async {
    return _db
        .collection('category')
        .doc(categoryModel.id)
        .update(
            {'category': categoryModel.category, 'color': categoryModel.color})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<String> getCategoryDocID(String category) async {
    String docID;
    await _db
        .collection('category')
        .where('category', isEqualTo: category)
        .get()
        .then((QuerySnapshot querySnapshot) {
      docID = querySnapshot.docs[0].data()['id'];
    });
    return docID;
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
