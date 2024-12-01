import 'package:bloc/bloc.dart';

enum NavigationState { produtos, pedidos, ajustes }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.produtos);

  void showProdutos() => emit(NavigationState.produtos);
  void showPedidos() => emit(NavigationState.pedidos);
  void showAjustes() => emit(NavigationState.ajustes);
}