class TransactionModel {
  final int id;
  final DateTime date;
  final String category;
  final String particular;
  final double amount;

  TransactionModel(
      {this.id, this.date, this.category, this.amount, this.particular});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'category': category,
      'particular': particular,
      'amount': amount
    };
  }
}
