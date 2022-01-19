final String tableProducts = 'products';

class ProductFields {
  static final List<String> values = [
    /// Add all fields
    id, title, description, time
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Product {
  final int? id;
  // final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  const Product({
    this.id,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Product copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Product fromJson(Map<String, Object?> json) => Product(
    id: json[ProductFields.id] as int?,
    title: json[ProductFields.title] as String,
    description: json[ProductFields.description] as String,
    createdTime: DateTime.parse(json[ProductFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    ProductFields.id: id,
    ProductFields.title: title,
    ProductFields.description: description,
    ProductFields.time: createdTime.toIso8601String(),
  };
}
