import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String color;
  final Timestamp date;
  final String category;
  final String particular;
  final double amount;

  TransactionModel(
      {this.id,
      this.date,
      this.category,
      this.amount,
      this.particular,
      this.color});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'category': category,
      'particular': particular,
      'amount': amount,
      'color': color
    };
  }

  TransactionModel.fromFirestore(Map<String, dynamic> firestore)
      : id = firestore['id'],
        date = firestore['date'],
        category = firestore['category'],
        amount = firestore['amount'],
        particular = firestore['particular'],
        color = firestore['color'];
}
