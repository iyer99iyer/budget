class CategoryModel {
  final String id;
  final String color;
  final String category;

  CategoryModel({this.id, this.color, this.category});

  Map<String, dynamic> toMap() {
    return {'id': id, 'color': color, 'category': category};
  }

  CategoryModel.fromFirestore(Map<String, dynamic> firestore)
      : id = firestore['id'],
        color = firestore['color'],
        category = firestore['category'];
}
