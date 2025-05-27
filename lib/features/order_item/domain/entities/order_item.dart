
import 'package:mobile_pizzaria_app/features/product/data/product_repo.dart';
import 'package:mobile_pizzaria_app/features/product/domain/entities/product.dart';
import 'package:mobile_pizzaria_app/features/size/data/size_repo.dart';
import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';

class OrderItem {
  final String id; 
  final String orderId;
  final Product product;
  final int quantity;
  final MySize size;
  final double price;
  final double discount;
  final bool isActive;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.product,
    required this.quantity,
    required this.size,
    required this.price,
    required this.discount,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'product': product,
      'quantity': quantity,
      'size': size,
      'price': price,
      'discount': discount,
      'is_active': isActive,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ?? '-1',
      orderId: json['order_id'] ?? '-1',
      product: json['product'] ?? ProductRepo().empty(),
      quantity: json['quantity'] ?? 0,
      size: json['size'] ?? MySizeRepo().empty(),
      price: json['price'] ?? 0.0,
      discount: json['discount'] ?? 0,
      isActive: json['is_active'] ?? false,
    );
  }

  OrderItem copyWith({
    String? id,
    String? orderId,
    Product? product,
    int? quantity,
    MySize? size,
    double? price,
    double? discount,
    bool? isActive,
  }) {
    return OrderItem(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      isActive: isActive ?? this.isActive,
    );
  }
}
