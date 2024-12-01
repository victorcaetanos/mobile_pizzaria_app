import 'package:mobile_pizzaria_app/features/category/domain/entities/category.dart';
import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final MyCategory category;
  List<MySize> sizes;
  final bool isActive;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.sizes,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imagePath,
      'price': price,
      'category': category,
      'sizes': sizes,
      'is_active': isActive,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '-1',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imagePath: json['imageUrl'] ?? '',
      price: json['price'] ?? 0.0,
      category: json['category'] ?? '',
      sizes: json['sizes'] ?? [],
      isActive: json['is_active'] ?? false,
    );
  }
}
