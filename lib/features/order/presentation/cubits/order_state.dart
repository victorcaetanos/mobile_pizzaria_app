import 'package:mobile_pizzaria_app/features/order/domain/entities/order.dart'; 

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;

  OrderLoaded({required this.orders});
}

class OrderError extends OrderState {
  final String message;

  OrderError({required this.message});
}
