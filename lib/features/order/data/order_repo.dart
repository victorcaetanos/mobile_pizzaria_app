import 'dart:async';
import 'package:mobile_pizzaria_app/features/address/data/address_repo.dart';
import 'package:mobile_pizzaria_app/features/card/data/card_repo.dart';
import 'package:mobile_pizzaria_app/features/order/domain/entities/order.dart';
import 'package:mobile_pizzaria_app/features/order/domain/repos/iorder_repo.dart';
import 'package:mobile_pizzaria_app/features/order_item/data/order_item_repo.dart';
import 'package:mobile_pizzaria_app/features/order_item/domain/entities/order_item.dart';
import 'package:mobile_pizzaria_app/features/user/data/profile_user_repo.dart';
import 'package:mobile_pizzaria_app/features/user/domain/entities/profile_user.dart';

class OrderRepo implements IOrderRepo {
  final List<Order> orders = [];
  final ProfileUserRepo userRepo = ProfileUserRepo();
  final Completer<void> _initializationCompleter = Completer<void>();

  OrderRepo() {
    _initializeOrders();
  }

  Future<void> _initializeOrders() async {
    if (orders.isEmpty) {
      final ProfileUser user =
          await userRepo.getProfileUser() ?? userRepo.empty();
      AddressRepo addressRepo = AddressRepo();
      CardRepo cardRepo = CardRepo();
      OrderItemRepo orderItemRepo = OrderItemRepo();
      orders.addAll([
        Order(
          id: '0',
          total: 100.0,
          discount: 0.0,
          user: user,
          notes: 'Sem cebola',
          status: 'making',
          address: addressRepo.getAddress('2'),
          card: cardRepo.getCard('1'),
          items: [
            orderItemRepo.getOrderItem('1'),
            orderItemRepo.getOrderItem('6'),
          ],
          isActive: true,
          createdAt: DateTime.now().subtract(const Duration(days: 4)),
        ),
        Order(
          id: '1',
          total: 100.0,
          discount: 0.0,
          user: user,
          notes: 'Sem Tomate',
          status: 'ordered',
          address: addressRepo.getAddress('1'),
          card: cardRepo.getCard('1'),
          items: [
            orderItemRepo.getOrderItem('1'),
            orderItemRepo.getOrderItem('2'),
            orderItemRepo.getOrderItem('3'),
          ],
          isActive: true,
          createdAt: DateTime.now(),
        ),
        Order(
          id: '2',
          total: 120.0,
          discount: 20.0,
          user: user,
          notes: '',
          status: 'finished',
          address: addressRepo.getAddress('2'),
          card: cardRepo.getCard('1'),
          items: [
            orderItemRepo.getOrderItem('4'),
            orderItemRepo.getOrderItem('5'),
          ],
          isActive: true,
          createdAt: DateTime.fromMillisecondsSinceEpoch(1721501200000),
        ),
        Order(
          id: '3',
          total: 150.0,
          discount: 10.0,
          user: user,
          notes: 'Queijo extra',
          status: 'finished',
          address: addressRepo.getAddress('3'),
          card: cardRepo.getCard('1'),
          items: [
            orderItemRepo.getOrderItem('6'),
            orderItemRepo.getOrderItem('7'),
            orderItemRepo.getOrderItem('8'),
            orderItemRepo.getOrderItem('9'),
          ],
          isActive: true,
          createdAt: DateTime.fromMillisecondsSinceEpoch(1727501200000),
        ),
      ]);
    }
    _initializationCompleter.complete();
  }

  Future<void> ensureInitialized() async {
    await _initializationCompleter.future;
  }

  @override
  Order empty() {
    return Order(
      id: '-1',
      total: 0.0,
      discount: 0.0,
      user: userRepo.empty(),
      notes: '',
      status: 'unknown',
      address: AddressRepo().empty(),
      card: CardRepo().empty(),
      items: List.empty(),
      isActive: true,
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  @override
  Future<Order> getOrder(String orderId) async {
    await ensureInitialized();
    try {
      return orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      throw Exception('Erro ao buscar pedido');
    }
  }

  @override
  Future<List<Order>> getOrders(String userId) async {
    await ensureInitialized();
    try {
      return orders
          .where(
              (order) => order.user.user.id == userId && order.isActive == true)
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar pedidos');
    }
  }

  @override
  Future<void> createOrder(
    double total,
    double discount,
    String notes,
    List<OrderItem> items,
  ) async {
    await ensureInitialized();
    try {
      final ProfileUser? user = await userRepo.getProfileUser();

      final order = Order(
        id: (orders.length + 1).toString(),
        total: total,
        discount: discount,
        user: user ?? userRepo.empty(),
        notes: notes,
        status: 'ordered',
        address: AddressRepo().getAddress(
          user?.selectedAddressId ?? '1',
        ),
        card: CardRepo().getCard(
          user?.selectedCardId ?? '1',
        ),
        items: items,
        isActive: true,
        createdAt: DateTime.now(),
      );

      orders.add(order);
    } catch (e) {
      throw Exception('Erro ao criar pedido');
    }
  }

  @override
  Future<void> updateOrder(Order order) async {
    await ensureInitialized();
    try {
      final index = orders.indexWhere((u) => u.id == order.id);

      if (index >= 0) {
        orders[index] = order;
      }
    } catch (e) {
      throw Exception('Erro ao atualizar pedido');
    }
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    await ensureInitialized();
    try {
      final index = orders.indexWhere((u) => u.id == orderId);

      if (index >= 0) {
        orders.removeAt(index);
      }
    } catch (e) {
      throw Exception('Erro ao deletar pedido');
    }
  }
}
