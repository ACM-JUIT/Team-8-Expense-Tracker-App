import 'package:basecode/model/category_model.dart';

class Expense {
  int amount;
  Category category;
  DateTime date;
  String id;
  String description;

  Expense({
    required this.amount,
    required this.category,
    required this.date,
    required this.id,
    required this.description,
  });

  static final empty = Expense(
    id: '',
    category: Category.empty,
    date: DateTime.now(),
    amount: 0,
    description: ''
  );

  Expense copyWith({
    int? amount,
    Category? category,
    DateTime? date,
    String? id,
    String? description,
  }) {
    return Expense(
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category.toMap(),
      'date': date.millisecondsSinceEpoch,
      'id': id,
      'description': description,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      amount: map['amount']?.toInt() ?? 0,
      category: Category.fromMap(map['category']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      id: map['id'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
