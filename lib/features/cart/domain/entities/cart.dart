import 'dart:ffi';

import 'package:mobile_pizzaria_app/features/address/data/address_repo.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/address.dart';
import 'package:mobile_pizzaria_app/features/card/data/card_repo.dart';
import 'package:mobile_pizzaria_app/features/card/domain/entities/card.dart';
import 'package:mobile_pizzaria_app/features/order_item/domain/entities/order_item.dart';
import 'package:mobile_pizzaria_app/features/user/data/profile_user_repo.dart';
import 'package:mobile_pizzaria_app/features/user/domain/entities/profile_user.dart';

class Cart {
  final ProfileUser user;
  final String notes;
  final Address address;
  final MyCard card;
  final List<OrderItem> items;
  final bool isActive;
  final DateTime createdAt;

  Cart({
    required this.user,
    required this.notes,
    required this.address,
    required this.card,
    required this.items,
    required this.isActive,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'notes': notes,
      'address': address,
      'card': card,
      'items': items,
      'is_active': isActive,
      'created_at': createdAt,
    };
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      user: json['user'] ?? ProfileUserRepo().empty(),
      notes: json['notes'] ?? '',
      address: json['address'] ?? AddressRepo().empty(),
      card: json['card'] ?? CardRepo().empty(),
      items: json['items'] ?? List.empty(),
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'],
    );
  }

  Cart copyWith({
    ProfileUser? user,
    String? notes,
    Address? address,
    MyCard? card,
    List<OrderItem>? items,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Cart(
      user: user ?? this.user,
      notes: notes ?? this.notes,
      address: address ?? this.address,
      card: card ?? this.card,
      items: items ?? this.items,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  double total() {
    return items.fold(0, (sum, item) => sum + item.price);
  }

  double totalDiscount() {
    return items.fold(0, (sum, item) => sum + item.discount);
  }

  double totalMinusDiscount() {
    return total() - totalDiscount();
  }
}
