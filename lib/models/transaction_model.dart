class TransactionModel {
  final String id;
  final String color;
  final DateTime date;
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
}
