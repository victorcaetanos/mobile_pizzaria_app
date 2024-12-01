import 'package:mobile_pizzaria_app/features/order/domain/entities/order.dart';
import 'package:mobile_pizzaria_app/features/order_item/domain/entities/order_item.dart';

abstract class IOrderRepo {
  Future<Order> getOrder(String orderId);
  Future<List<Order>> getOrders(String userId);
  Order empty();
  Future<void> createOrder(
    double total,
    double discount,
    String notes,
    List<OrderItem> items,
  );
  Future<void> updateOrder(Order order);
  Future<void> deleteOrder(String orderId);
}
