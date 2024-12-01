import 'dart:async';

import 'package:mobile_pizzaria_app/features/order_item/domain/entities/order_item.dart';
import 'package:mobile_pizzaria_app/features/order_item/domain/repos/iorder_item_repo.dart';
import 'package:mobile_pizzaria_app/features/product/data/product_repo.dart';
import 'package:mobile_pizzaria_app/features/size/data/size_repo.dart';
import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';

class OrderItemRepo implements IOrderItemRepo {
  final List<OrderItem> orderItems = [];
  final Completer<void> _initializationCompleter = Completer<void>();

  OrderItemRepo() {
    _initializeOrderItems();
  }

  Future<void> _initializeOrderItems() async {
    if (orderItems.isEmpty) {
      ProductRepo productRepo = ProductRepo();
      MySizeRepo sizeRepo = MySizeRepo();
      orderItems.addAll([
        OrderItem(
          id: '1',
          orderId: '1',
          product: productRepo.getProduct('1'),
          quantity: 2,
          size: sizeRepo.getMySize('1'),
          price: 2.00,
          discount: 0.0,
          isActive: true,
        ),
        OrderItem(
          id: '2',
          orderId: '1',
          product: productRepo.getProduct('3'),
          quantity: 1,
          size: sizeRepo.getMySize('2'),
          price: 4.00,
          discount: 0.0,
          isActive: true,
        ),
        OrderItem(
          id: '3',
          orderId: '1',
          product: productRepo.getProduct('3'),
          quantity: 3,
          size: sizeRepo.getMySize('3'),
          price: 6.00,
          discount: 0.0,
          isActive: true,
        ),
        OrderItem(
          id: '4',
          orderId: '1',
          product: productRepo.getProduct('2'),
          quantity: 1,
          size: sizeRepo.getMySize('3'),
          price: 6.00,
          discount: 0.0,
          isActive: true,
        ),
        OrderItem(
          id: '5',
          orderId: '1',
          product: productRepo.getProduct('8'),
          quantity: 4,
          size: sizeRepo.getMySize('6'),
          price: 6.00,
          discount: 0.0,
          isActive: true,
        ),
        OrderItem(
          id: '6',
          orderId: '1',
          product: productRepo.getProduct('7'),
          quantity: 1,
          size: sizeRepo.getMySize('5'),
          price: 6.00,
          discount: 0.0,
          isActive: true,
        ),
        OrderItem(
          id: '7',
          orderId: '1',
          product: productRepo.getProduct('6'),
          quantity: 1,
          size: sizeRepo.getMySize('1'),
          price: 6.00,
          discount: 0.0,
          isActive: true,
        ),
        OrderItem(
          id: '8',
          orderId: '1',
          product: productRepo.getProduct('4'),
          quantity: 1,
          size: sizeRepo.getMySize('2'),
          price: 6.00,
          discount: 0.0,
          isActive: true,
        ),
        OrderItem(
          id: '9',
          orderId: '1',
          product: productRepo.getProduct('5'),
          quantity: 1,
          size: sizeRepo.getMySize('2'),
          price: 6.00,
          discount: 0.0,
          isActive: true,
        ),
      ]);
    }
    _initializationCompleter.complete();
  }

  Future<void> ensureInitialized() async {
    await _initializationCompleter.future;
  }

  @override
  OrderItem empty() {
    return OrderItem(
      id: '-1',
      orderId: '-1',
      product: ProductRepo().empty(),
      quantity: 0,
      size: MySizeRepo().empty(),
      price: 0.0,
      discount: 0.0,
      isActive: true,
    );
  }

  @override
  OrderItem getOrderItem(String orderItemId) {
    try {
      return orderItems.firstWhere((orderItem) => orderItem.id == orderItemId);
    } catch (e) {
      throw Exception('Erro ao buscar item do pedido');
    }
  }

  @override
  List<OrderItem> getOrderItems(String orderId) {
    try {
      return orderItems
          .where((orderItem) =>
              orderItem.orderId == orderId && orderItem.isActive == true)
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar itens do pedido');
    }
  }

  @override
  void createOrderItem(
    String orderId,
    String productId,
    int quantity,
    MySize size,
    double price,
  ) async {
    try {
      final orderItem = OrderItem(
        id: (orderItems.length + 1).toString(),
        orderId: orderId,
        product: ProductRepo().getProduct(productId),
        quantity: quantity,
        size: size,
        price: price,
        discount: 0.0,
        isActive: true,
      );

      orderItems.add(orderItem);
    } catch (e) {
      throw Exception('Erro ao criar item do pedido');
    }
  }

  @override
  void updateOrderItem(OrderItem orderItem) {
    try {
      final index = orderItems.indexWhere((u) => u.id == orderItem.id);

      if (index >= 0) {
        orderItems[index] = orderItem;
      }
    } catch (e) {
      throw Exception('Erro ao atualizar item do pedido');
    }
  }

  @override
  void deleteOrderItem(String orderItemId) {
    try {
      final index = orderItems.indexWhere((u) => u.id == orderItemId);

      if (index >= 0) {
        orderItems.removeAt(index);
      }
    } catch (e) {
      throw Exception('Erro ao deletar item do pedido');
    }
  }
}
