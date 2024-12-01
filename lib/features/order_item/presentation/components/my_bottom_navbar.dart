import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/home/presentation/cubits/navigation_cubit.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: _mapStateToIndex(state),
          onTap: (index) {
            _onItemTapped(context, index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Produtos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_document),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: 'Ajustes',
            ),
          ],
          iconSize: 30,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedItemColor: Theme.of(context).colorScheme.tertiary,
        );
      },
    );
  }

  int _mapStateToIndex(NavigationState state) {
    switch (state) {
      case NavigationState.produtos:
        return 0;
      case NavigationState.pedidos:
        return 1;
      case NavigationState.ajustes:
        return 2;
      default:
        return 0;
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    final cubit = context.read<NavigationCubit>();
    switch (index) {
      case 0:
        cubit.showProdutos();
        break;
      case 1:
        cubit.showPedidos();
        break;
      case 2:
        cubit.showAjustes();
        break;
    }
  }
}
