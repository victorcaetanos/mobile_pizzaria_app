import 'package:bloc/bloc.dart';
import 'package:mobile_pizzaria_app/features/cart/domain/repos/icart_repo.dart';
import 'package:mobile_pizzaria_app/features/cart/presentation/cubits/cart_state.dart';
import 'package:mobile_pizzaria_app/features/product/domain/entities/product.dart';
import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';

class CartCubit extends Cubit<CartState> {
  final ICartRepo cartRepo;

  CartCubit({required this.cartRepo}) : super(CartInitial());

  void getCart() async {
    emit(CartLoading());
    try {
      final cart = cartRepo.empty();
      emit(CartLoaded(cart: cart));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void updateCart(
    Product product,
    MySize size,
  ) async {
    emit(CartLoading());
    try {
      emit(CartLoaded(cart: cartRepo.empty()));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void deleteProduct() async {
    try {
      await cartRepo.deleteCart();
      getCart();
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
