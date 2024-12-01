import 'dart:convert';

import 'package:mobile_pizzaria_app/features/address/data/address_repo.dart';
import 'package:mobile_pizzaria_app/features/card/data/card_repo.dart';
import 'package:mobile_pizzaria_app/features/cart/domain/entities/cart.dart';
import 'package:mobile_pizzaria_app/features/cart/domain/repos/icart_repo.dart';
import 'package:mobile_pizzaria_app/features/order_item/domain/entities/order_item.dart';
import 'package:mobile_pizzaria_app/features/user/data/profile_user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo implements ICartRepo {
  static const String _cartKey = 'cart';
  final ProfileUserRepo userRepo = ProfileUserRepo();

  @override
  Cart empty() {
    return Cart(
      total: 0.0,
      discount: 0.0,
      user: userRepo.empty(),
      notes: '',
      address: AddressRepo().empty(),
      card: CardRepo().empty(),
      items: [],
      isActive: true,
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  @override
  Future<Cart> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(_cartKey);
    if (cartJson == null) return empty();

    final cartMap = jsonDecode(cartJson);
    return Cart(
      total: cartMap['total'],
      discount: cartMap['discount'],
      user: await userRepo.getProfileUser() ?? userRepo.empty(),
      notes: cartMap['notes'],
      address: AddressRepo().getAddress(cartMap['addressId']),
      card: CardRepo().getCard(cartMap['cardId']),
      items: (cartMap['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      isActive: cartMap['isActive'],
      createdAt: DateTime.parse(cartMap['createdAt']),
    );
  }

  @override
  Future<void> updateCart(Cart cart) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = jsonEncode({
      'total': cart.total,
      'discount': cart.discount,
      'notes': cart.notes,
      'addressId': cart.address.id,
      'cardId': cart.card.id,
      'items': cart.items.map((item) => item.toJson()).toList(),
      'isActive': cart.isActive,
      'createdAt': cart.createdAt.toIso8601String(),
    });
    await prefs.setString(_cartKey, cartJson);
  }

  @override
  Future<void> deleteCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
