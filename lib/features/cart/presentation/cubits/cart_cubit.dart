import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/address.dart';
import 'package:mobile_pizzaria_app/features/card/domain/entities/card.dart';
import 'package:mobile_pizzaria_app/features/cart/domain/repos/icart_repo.dart';
import 'package:mobile_pizzaria_app/features/cart/presentation/cubits/cart_state.dart';
import 'package:mobile_pizzaria_app/features/order_item/domain/entities/order_item.dart';
import 'package:mobile_pizzaria_app/features/product/domain/entities/product.dart';
import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';

class CartCubit extends Cubit<CartState> {
  final ICartRepo cartRepo;

  CartCubit({required this.cartRepo}) : super(CartInitial());

  void getCart() async {
    emit(CartLoading());
    try {
      final cart = await cartRepo.getCart();
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void updateCartItem(
    Product product,
    MySize size,
  ) async {
    log('Before CartLoading updateCartItem');
    emit(CartLoading());
    log('After CartLoading updateCartItem');
    try {
      final cart = await cartRepo.getCart();
      final updatedItems = List<OrderItem>.from(cart.items);
      final existingItemIndex = updatedItems.indexWhere(
        (item) => item.product.id == product.id && item.size.id == size.id,
      );

      if (existingItemIndex != -1) {
        final existingItem = updatedItems[existingItemIndex];
        final updatedItem = existingItem.copyWith(
          quantity: existingItem.quantity + 1,
        );
        updatedItems[existingItemIndex] = updatedItem;
      } else {
        final newItem = OrderItem(
          id: '',
          orderId: '',
          product: product,
          quantity: 1,
          size: size,
          price: product.price,
          discount: 0.0,
          isActive: true,
        );
        updatedItems.add(newItem);
      }

      final updatedCart = cart.copyWith(items: updatedItems);
      await cartRepo.updateCart(updatedCart);
    log('After CartLoaded ${updatedCart.toJson()}');
      emit(CartLoaded(cart: updatedCart));
    log('After CartLoaded updateCartItem');
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void updateCart(
    Address address,
    MyCard card,
    String notes,
  ) async {
    emit(CartLoading());
    try {
      final cart = await cartRepo.getCart();
      final updatedCart = cart.copyWith(address: address);
      await cartRepo.updateCart(updatedCart);
      emit(CartLoaded(cart: updatedCart));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void deleteProduct() async {
    try {
      await cartRepo.deleteCart();
      getCart();
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
