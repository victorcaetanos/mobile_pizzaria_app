import 'package:mobile_pizzaria_app/features/address/data/address_repo.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/address.dart';
import 'package:mobile_pizzaria_app/features/card/data/card_repo.dart';
import 'package:mobile_pizzaria_app/features/card/domain/entities/card.dart';
import 'package:mobile_pizzaria_app/features/order_item/domain/entities/order_item.dart';
import 'package:mobile_pizzaria_app/features/user/data/profile_user_repo.dart';
import 'package:mobile_pizzaria_app/features/user/domain/entities/profile_user.dart';

class Order {
  final String id;
  final double total;
  final double discount;
  final ProfileUser user;
  final String notes;
  final String status;
  final Address address;
  final MyCard card;
  final List<OrderItem> items;
  final bool isActive;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.total,
    required this.discount,
    required this.user,
    required this.notes,
    required this.status,
    required this.address,
    required this.card,
    required this.items,
    required this.isActive,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'discount': discount,
      'user': user,
      'notes': notes,
      'status': status,
      'address': address,
      'card': card,
      'items': items,
      'is_active': isActive,
      'created_at': createdAt,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '-1',
      total: json['total'] ?? 0.0,
      discount: json['discount'] ?? 0.0,
      user: json['user'] ?? ProfileUserRepo().empty(),
      notes: json['notes'] ?? '',
      status: json['status'] ?? 'unknown',
      address: json['address'] ?? AddressRepo().empty(),
      card: json['card'] ?? CardRepo().empty(),
      items: json['items'] ?? List.empty(),
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'],
    );
  }
}
