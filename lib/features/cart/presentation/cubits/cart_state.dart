import 'package:mobile_pizzaria_app/features/cart/domain/entities/cart.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Cart cart;

  CartLoaded({required this.cart});
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}
