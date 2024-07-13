class Category {
  String id;
  String name;
  int totalExpenses;
  String icon;
  int color;

  Category({
    required this.id,
    required this.name,
    required this.totalExpenses,
    required this.icon,
    required this.color,
  });
  Category copyWith({
    String? id,
    String? name,
    int? totalExpenses,
    String? icon,
    int? color,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
  static final empty = Category(
    id: '', 
    name: '', 
    totalExpenses: 0, 
    icon: '', 
    color: 0
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'totalExpenses': totalExpenses,
      'icon': icon,
      'color': color,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      totalExpenses: map['totalExpenses']?.toInt() ?? 0,
      icon: map['icon'] ?? '',
      color: map['color']?.toInt() ?? 0,
    );
  }
}
