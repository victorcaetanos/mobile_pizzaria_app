import 'package:mobile_pizzaria_app/features/order_item/domain/entities/order_item.dart';
import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';

abstract class IOrderItemRepo {
  OrderItem getOrderItem(String orderItemId);
  getOrderItems(String orderId);
  OrderItem empty();
  void createOrderItem(
    String orderId,
    String productId,
    int quantity,
    MySize size,
    double price,
  );
  void updateOrderItem(OrderItem orderItem);
  void deleteOrderItem(String orderItemId);
}
