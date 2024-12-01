import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mobile_pizzaria_app/features/category/domain/entities/category.dart';
import 'package:mobile_pizzaria_app/features/order/domain/entities/order.dart';
import 'package:mobile_pizzaria_app/features/order/presentation/components/order_display.dart';
import 'package:mobile_pizzaria_app/features/order/presentation/cubits/order_cubit.dart';
import 'package:mobile_pizzaria_app/features/order/presentation/cubits/order_state.dart';
import 'package:mobile_pizzaria_app/features/order/presentation/pages/order_page.dart';
import 'package:mobile_pizzaria_app/features/user/presentation/cubits/profile_cubit.dart';
import 'package:mobile_pizzaria_app/features/loading/pages/loading_page.dart';

class OrderListPage extends StatefulWidget {
  final String title;
  const OrderListPage({super.key, required this.title});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  late OrderCubit orderCubit = context.read<OrderCubit>();
  late ProfileCubit profileCubit = context.read<ProfileCubit>();
  MyCategory? selectedCategory;

  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    getAllOrders();
  }

  void getAllOrders() {
    final AuthCubit authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
    orderCubit.getOrders(currentUser?.id ?? '-1');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading || state is OrderInitial) {
          return const LoadingPage();
        } else if (state is OrderLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              leading: Container(),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 24.0),
                      _buildProductListSection(state, context),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Erro ao carregar endereço'),
            ),
          );
        }
      },
    );
  }

  Expanded _buildProductListSection(OrderLoaded state, BuildContext context) {
    final currentOrders =
        state.orders.where((order) => order.status != 'finished').toList();
    final pastOrders =
        state.orders.where((order) => order.status == 'finished').toList();

    return Expanded(
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          if (currentOrders.isNotEmpty) ...[
            _buildSectionHeader(
                context, 'Pedidos em andamento', Icons.hourglass_top_outlined),
            ...currentOrders.map(
              (order) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildOrderDisplayItem(order, true),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
          if (pastOrders.isNotEmpty) ...[
            _buildSectionHeader(context, 'Historico de pedidos', Icons.history),
            ...pastOrders.map(
              (order) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _buildOrderDisplayItem(order, false),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(width: 8.0),
            Icon(icon),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDisplayItem(
    Order order,
    bool activeOrder,
  ) {
    return GestureDetector(
      child: OrderDisplay(
        order: order,
        activeOrder: activeOrder,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderPage(order: order),
          ),
        );
      },
    );
  }
}
