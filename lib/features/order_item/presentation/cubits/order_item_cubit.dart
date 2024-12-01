import 'package:bloc/bloc.dart';
import 'package:mobile_pizzaria_app/features/order_item/domain/entities/order_item.dart';
import 'package:mobile_pizzaria_app/features/order_item/domain/repos/iorder_item_repo.dart';
import 'package:mobile_pizzaria_app/features/order_item/presentation/cubits/order_item_state.dart';
import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';

class OrderItemCubit extends Cubit<OrderItemState> {
  final IOrderItemRepo orderItemRepo;

  OrderItemCubit({required this.orderItemRepo}) : super(OrderItemInitial());

  void getProduct(String orderItemId) {
    emit(OrderItemLoading());
    try {
      if (orderItemId.isEmpty || orderItemId == '-1') {
        final orderItem = orderItemRepo.empty();
        emit(OrderItemLoaded(orderItems: [orderItem]));
        return;
      }
      final orderItem = orderItemRepo.getOrderItem(orderItemId);
      emit(OrderItemLoaded(orderItems: [orderItem]));
    } catch (e) {
      emit(OrderItemError(message: e.toString()));
    }
  }

  void getOrderItems(String orderId) {
    emit(OrderItemLoading());
    try {
      final orderItems = orderItemRepo.getOrderItems(orderId);
      emit(OrderItemLoaded(orderItems: _sortOrderItems(orderItems)));
    } catch (e) {
      emit(OrderItemError(message: e.toString()));
    }
  }

  void createProduct(
    String orderId,
    String productId,
    int quantity,
    MySize size,
    double price,
  ) async {
    emit(OrderItemLoading());
    try {
      orderItemRepo.createOrderItem(
        orderId,
        productId,
        quantity,
        size,
        price,
      );
      getOrderItems(orderId);
    } catch (e) {
      emit(OrderItemError(message: e.toString()));
    }
  }

  void updateOrderItem(OrderItem orderItem) {
    emit(OrderItemLoading());
    try {
      orderItemRepo.updateOrderItem(orderItem);
      getOrderItems(orderItem.orderId);
    } catch (e) {
      emit(OrderItemError(message: e.toString()));
    }
  }

  void deleteOrderItem(OrderItem orderItem) {
    try {
      orderItemRepo.deleteOrderItem(orderItem.id);
      getOrderItems(orderItem.orderId);
    } catch (e) {
      emit(OrderItemError(message: e.toString()));
    }
  }

  List<OrderItem> _sortOrderItems(List<OrderItem> orderItems) {
    final sortedProducts = List.of(orderItems)
      ..sort((a, b) => a.id.compareTo(b.id));
    return sortedProducts;
  }
}
