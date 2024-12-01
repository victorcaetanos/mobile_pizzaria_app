import 'package:bloc/bloc.dart';
import 'package:mobile_pizzaria_app/features/order/domain/entities/order.dart';
import 'package:mobile_pizzaria_app/features/order/domain/repos/iorder_repo.dart';
import 'package:mobile_pizzaria_app/features/order/presentation/cubits/order_state.dart';
import 'package:mobile_pizzaria_app/features/order_item/domain/entities/order_item.dart';

class OrderCubit extends Cubit<OrderState> {
  final IOrderRepo orderRepo;

  OrderCubit({required this.orderRepo}) : super(OrderInitial());

  void getOrder(String orderId) async {
    emit(OrderLoading());
    try {
      if (orderId.isEmpty || orderId == '-1') {
        final order = orderRepo.empty();
        emit(OrderLoaded(orders: [order]));
        return;
      }
      final order = await orderRepo.getOrder(orderId);
      emit(OrderLoaded(orders: [order]));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  void getOrders(String userId) async {
    emit(OrderLoading());
    try {
      final orders = await orderRepo.getOrders(userId);
      emit(OrderLoaded(orders: _sortOrder(orders)));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  void getOrdersByUserId(String userId) async {
    emit(OrderLoading());
    try {
      final orders = await orderRepo.getOrders(userId);
      emit(OrderLoaded(orders: _sortOrder(orders)));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  void createOrder(
    double total,
    double discount,
    String notes,
    List<OrderItem> items,
    String userId,
  ) async {
    emit(OrderLoading());
    try {
      await orderRepo.createOrder(
        total,
        discount,
        notes,
        items,
      );
      getOrders(userId);
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  void updateOrder(Order order) async {
    emit(OrderLoading());
    try {
      await orderRepo.updateOrder(order);
      getOrders(order.user.user.id);
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  void deleteProduct(Order order) async {
    try {
      await orderRepo.deleteOrder(order.id);
      getOrders(order.user.user.id);
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }

  List<Order> _sortOrder(List<Order> orders) {
    final sortedProducts = List.of(orders)
      ..sort((a, b) => b.id.compareTo(a.id));
    return sortedProducts;
  }
}
