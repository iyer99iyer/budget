import 'package:budget/models/category_model.dart';
import 'package:budget/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTransaction(TransactionModel transactionModel) {
    return _db.collection('transaction').doc().set(transactionModel.toMap());
  }

  Future<void> addCategory(CategoryModel categoryModel) {
    return _db.collection('category').doc().set(categoryModel.toMap());
  }

  Future<List<CategoryModel>> getCategories() {}
}