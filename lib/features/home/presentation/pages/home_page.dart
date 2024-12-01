import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/order/presentation/pages/order_list_page.dart';
import 'package:mobile_pizzaria_app/features/product/presentation/components/my_bottom_navbar.dart';
import 'package:mobile_pizzaria_app/features/home/presentation/cubits/navigation_cubit.dart';
import 'package:mobile_pizzaria_app/features/product/presentation/pages/product_options_page.dart';
import 'package:mobile_pizzaria_app/features/setting/presentation/pages/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          switch (state) {
            case NavigationState.produtos:
              return const OptionsPage(title: '');
            case NavigationState.pedidos:
              return const OrderListPage(title: 'Pedidos');
            case NavigationState.ajustes:
              return const SettingsPage(title: 'Configurações');
            default:
              return const OptionsPage(title: '');
          }
        },
      ),
      bottomNavigationBar: const MyNavBar(),
    );
  }
}
