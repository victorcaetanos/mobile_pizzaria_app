import 'package:mobile_pizzaria_app/features/cart/domain/entities/cart.dart';

abstract class ICartRepo {
  Future<Cart> getCart();
  Cart empty();
  Future<void> updateCart(Cart cart);
  Future<void> deleteCart();
}
