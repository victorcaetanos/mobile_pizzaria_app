import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/address.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/cubits/address_cubit.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/cubits/address_state.dart';
import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mobile_pizzaria_app/features/card/domain/entities/card.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/cubits/card_cubit.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/cubits/card_state.dart';
import 'package:mobile_pizzaria_app/features/cart/domain/entities/cart.dart';
import 'package:mobile_pizzaria_app/features/cart/presentation/components/address_dropdown_selector.dart';
import 'package:mobile_pizzaria_app/features/cart/presentation/components/card_dropdown_selector.dart';
import 'package:mobile_pizzaria_app/features/cart/presentation/components/cart_display.dart';
import 'package:mobile_pizzaria_app/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:mobile_pizzaria_app/features/cart/presentation/cubits/cart_state.dart';
import 'package:mobile_pizzaria_app/features/user/presentation/cubits/profile_cubit.dart';
import 'package:mobile_pizzaria_app/features/loading/pages/loading_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartCubit cartCubit = context.read<CartCubit>();
  late ProfileCubit profileCubit = context.read<ProfileCubit>();
  late AddressCubit addressCubit = context.read<AddressCubit>();
  late CardCubit cardCubit = context.read<CardCubit>();

  final TextEditingController observationsController = TextEditingController();

  Address? selectedAddress;
  MyCard? selectedCard;
  String notes = '';

  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    getAllOrders();
  }

  void getAllOrders() {
    final AuthCubit authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
    cartCubit.getCart();
    cardCubit.getCardsByUserId(currentUser?.id ?? '-1');
    addressCubit.getAddressesByUserId(currentUser?.id ?? '-1');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading || state is CartInitial) {
          return const LoadingPage();
        } else if (state is CartLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
              title: const Text(
                'Sacola',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView(
                    children: [
                      const SizedBox(height: 24.0),
                      Center(
                        child: Text(
                          'Itens na sacola',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CartDisplay(cart: state.cart),
                      const SizedBox(height: 16),
                      _buildNotesTextField(),
                      const SizedBox(height: 16),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Endereço de Entrega'),
                      ),
                      _buildAddressDropdown(),
                      const SizedBox(height: 16),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Forma de Pagamento'),
                      ),
                      _buildCardDropdown(),
                      const SizedBox(height: 20),
                      _buildMakeOrderButton(context),
                      const SizedBox(height: 16),
                      _buildClearCartButton(context),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Erro ao carregar o carinho'),
            ),
          );
        }
      },
    );
  }

  TextField _buildNotesTextField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Observações',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      onChanged: (value) => notes = value,
      controller: observationsController,
    );
  }

  BlocBuilder<AddressCubit, AddressState> _buildAddressDropdown() {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        if (state is AddressLoaded) {
          return DropdownAddressSelector(
            addresses: state.addresses,
            selectedAddress: selectedAddress,
            onAddressSelected: (address) => setState(
              () => selectedAddress = address,
            ),
          );
        }
        return DropdownAddressSelector(
          addresses: const [],
          selectedAddress: selectedAddress,
          onAddressSelected: (address) => setState(
            () => selectedAddress = address,
          ),
        );
      },
    );
  }

  BlocBuilder<CardCubit, CardState> _buildCardDropdown() {
    return BlocBuilder<CardCubit, CardState>(
      builder: (context, state) {
        if (state is CardLoaded) {
          return DropdownCardSelector(
            cards: state.cards,
            selectedCard: selectedCard,
            onCardSelected: (card) => setState(
              () => selectedCard = card,
            ),
          );
        }
        return DropdownCardSelector(
          cards: const [],
          selectedCard: selectedCard,
          onCardSelected: (card) => setState(
            () => selectedCard = card,
          ),
        );
      },
    );
  }

  GestureDetector _buildClearCartButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle cart clearing
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Limpar sacola',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildMakeOrderButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'Fazer pedido',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
