import 'package:mobile_pizzaria_app/features/order_item/domain/entities/order_item.dart'; 

abstract class OrderItemState {}

class OrderItemInitial extends OrderItemState {}

class OrderItemLoading extends OrderItemState {}

class OrderItemLoaded extends OrderItemState {
  final List<OrderItem> orderItems;

  OrderItemLoaded({required this.orderItems});
}

class OrderItemError extends OrderItemState {
  final String message;

  OrderItemError({required this.message});
}
