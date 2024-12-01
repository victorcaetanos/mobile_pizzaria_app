import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/components/address_dismissable.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/components/address_display.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/components/create_address_button.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/cubits/address_cubit.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/cubits/address_state.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/pages/create_address_page.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/pages/edit_address_page.dart';
import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mobile_pizzaria_app/features/home/presentation/pages/home_page.dart';
import 'package:mobile_pizzaria_app/features/loading/pages/loading_page.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({super.key});

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  late final AddressCubit addressCubit = context.read<AddressCubit>();

  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    getAllAddresses();
  }

  void getAllAddresses() {
    final AuthCubit authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
    addressCubit.getAddressesByUserId(currentUser!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: const Text(
          'Endereços',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          if (state is AddressLoading) {
            return const LoadingPage();
          } else if (state is AddressLoaded) {
            if (state.addresses.isEmpty) {
              return SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24.0),
                        Text(
                          'Meus Endereços',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryFixedVariant,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        buildCreateButton(),
                      ],
                    ),
                  ),
                ),
              );
            }

            return SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24.0),
                      Text(
                        'Meus Endereços',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryFixedVariant,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Expanded(
                        flex: 1,
                        child: ListView.separated(
                          itemCount: state.addresses.length + 1,
                          itemBuilder: (context, index) {
                            if (index != state.addresses.length) {
                              final address = state.addresses[index];
                              return Dismissible(
                                background: const AddressDismissable(),
                                key: ValueKey<int>(int.tryParse(address.id)!),
                                onDismissed: (DismissDirection direction) {
                                  addressCubit
                                      .deleteAddress(state.addresses[index]);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Cartão deletado com sucesso'),
                                    ),
                                  );
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditAddressPage(
                                          address: address,
                                          index: index,
                                        ),
                                      ),
                                    );
                                  },
                                  child: AddressDisplay(
                                    address: address,
                                  ),
                                ),
                              );
                            } else {
                              return buildCreateButton();
                            }
                          },
                          separatorBuilder: (context, index) {
                            if (index == state.addresses.length - 1) {
                              return const SizedBox(height: 20.0);
                            }
                            return const SizedBox(height: 12.0);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: Text('Erro ao carregar endereço'),
            ),
          );
        },
      ),
    );
  }

  buildCreateButton() {
    return SizedBox(
      height: 200.0,
      child: CreateAddressButton(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateAddressPage(),
            ),
          );
        },
        text: 'Adicionar',
      ),
    );
  }
}
