import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/address/data/address_repo.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/cubits/address_cubit.dart';
import 'package:mobile_pizzaria_app/features/auth/data/auth_repo.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_state.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/pages/auth_page.dart';
import 'package:mobile_pizzaria_app/features/card/data/card_repo.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/cubits/card_cubit.dart';
import 'package:mobile_pizzaria_app/features/cart/data/cart_repo.dart';
import 'package:mobile_pizzaria_app/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:mobile_pizzaria_app/features/home/presentation/cubits/navigation_cubit.dart';
import 'package:mobile_pizzaria_app/features/home/presentation/pages/home_page.dart';
import 'package:mobile_pizzaria_app/features/order/data/order_repo.dart';
import 'package:mobile_pizzaria_app/features/order/presentation/cubits/order_cubit.dart';
import 'package:mobile_pizzaria_app/features/order_item/data/order_item_repo.dart';
import 'package:mobile_pizzaria_app/features/order_item/presentation/cubits/order_item_cubit.dart';
import 'package:mobile_pizzaria_app/features/product/data/product_repo.dart';
import 'package:mobile_pizzaria_app/features/product/presentation/cubits/product_cubit.dart';
import 'package:mobile_pizzaria_app/features/user/data/profile_user_repo.dart';
import 'package:mobile_pizzaria_app/features/user/presentation/cubits/profile_cubit.dart';
import 'package:mobile_pizzaria_app/features/loading/pages/loading_page.dart';
import 'package:mobile_pizzaria_app/themes/light_mode.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthRepo authRepo = AuthRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),
        BlocProvider(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ProfileCubit(profileRepo: ProfileUserRepo())..checkProfile(),
        ),
        BlocProvider(
          create: (context) => CardCubit(cardRepo: CardRepo()),
        ),
        BlocProvider(
          create: (context) => AddressCubit(addressRepo: AddressRepo()),
        ),
        BlocProvider(
          create: (context) => ProductCubit(productRepo: ProductRepo()),
        ),
        BlocProvider(
          create: (context) => OrderCubit(orderRepo: OrderRepo()),
        ),
        BlocProvider(
          create: (context) => OrderItemCubit(orderItemRepo: OrderItemRepo()),
        ),
        BlocProvider(
          create: (context) => CartCubit(cartRepo: CartRepo()),
        ),
      ],
      child: MaterialApp(
        title: 'Pizza App',
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is Unauthenticated) {
              return const AuthPage();
            }
            if (authState is Authenticated) {
              return const HomePage();
            } else {
              return const LoadingPage();
            }
          },
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message.replaceFirstMapped(
                        'Exception: Failed to sign in: Exception:', (m) => ''),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
