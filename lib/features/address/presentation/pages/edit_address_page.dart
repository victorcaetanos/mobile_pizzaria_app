import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/address/data/city_repo.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/address.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/city.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/components/city_dropdown_selector.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/components/main_address_button.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/cubits/address_cubit.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/cubits/address_state.dart';
import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/my_button.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/masked_text_field.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/my_text_field.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mobile_pizzaria_app/features/user/domain/entities/profile_user.dart';
import 'package:mobile_pizzaria_app/features/user/presentation/cubits/profile_cubit.dart';
import 'package:mobile_pizzaria_app/features/loading/pages/loading_page.dart';
import 'package:mobile_pizzaria_app/utils/utils.dart';

class EditAddressPage extends StatefulWidget {
  final Address address;
  final int index;

  const EditAddressPage({
    required this.address,
    required this.index,
    super.key,
  });

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final cepController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final streetController = TextEditingController();
  final houseNumberController = TextEditingController();
  final complementController = TextEditingController();

  AppUser? currentUser;
  MyCity? selectedCity;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final AuthCubit authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  void update() {
    final String cep = cepMaskFormatter.unmaskText(cepController.text);
    final String neighborhood = neighborhoodController.text;
    final String street = streetController.text;
    final String houseNumber = houseNumberController.text;
    final String complement = complementController.text;

    String errorMessage = _checkFields(
        cep, neighborhood, street, houseNumber, complement, selectedCity);
    if (errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
      return;
    }

    final AddressCubit addressCubit = context.read<AddressCubit>();

    final Address updatedAddress = Address(
      id: widget.address.id,
      cep: cep,
      street: street,
      houseNumber: houseNumber,
      neighborhood: neighborhood,
      complement: complement,
      isActive: true,
      city: selectedCity!,
      userId: currentUser?.id ?? '',
    );
    addressCubit.updateAddress(updatedAddress);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Endereço atualizado com sucesso!'),
      ),
    );
  }

  String _checkFields(
    String cep,
    String neighborhood,
    String street,
    String houseNumber,
    String complement,
    MyCity? city,
  ) {
    if (cep.isEmpty ||
        neighborhood.isEmpty ||
        street.isEmpty ||
        houseNumber.isEmpty ||
        complement.isEmpty) {
      return 'Todos os campos são obrigatórios';
    } else if (cep.length != 8) {
      return 'CEP deve ter 8 dígitos';
    } else if (neighborhood.length > 100) {
      return 'Bairro deve ter no máximo 100 dígitos';
    } else if (street.length > 100) {
      return 'Bairro deve ter no máximo 100 dígitos';
    } else if (houseNumber.length > 6) {
      return 'Número da casa deve ter no máximo 6 dígitos';
    } else if (complement.length > 50) {
      return 'Complemento deve ter no máximo 50 dígitos';
    } else if (city == null) {
      return 'Selecione uma cidade';
    }
    return '';
  }

  void setMainAddress() {
    final ProfileCubit profileCubit = context.read<ProfileCubit>();
    profileCubit.getUserProfile();
    ProfileUser currentProfileUser = profileCubit.currentProfileUser!;
    profileCubit.updateProfile(
      ProfileUser(
        user: currentProfileUser.user,
        role: currentProfileUser.role,
        isActive: currentProfileUser.isActive,
        selectedCardId: currentProfileUser.selectedCardId,
        selectedAddressId: widget.address.id,
        hasActiveCart: currentProfileUser.hasActiveCart,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Endereço definido com sucesso!'),
      ),
    );
  }

  @override
  void dispose() {
    cepController.dispose();
    neighborhoodController.dispose();
    streetController.dispose();
    houseNumberController.dispose();
    complementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      builder: (context, state) {
        if (state is AddressLoaded) {
          return _buildUpdatePage(state.addresses);
        } else if (state is AddressLoading) {
          return const LoadingPage();
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Endereço não encontrado"),
            ),
          );
        }
      },
      listener: (context, state) {
        if (state is AddressLoaded) {
          return Navigator.pop(context);
        }
      },
    );
  }

  Widget _buildUpdatePage(List<Address> addresses) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: const Text(
          'Endereço',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
      ),
      body: _buildEditAddressBody(),
    );
  }

  SafeArea _buildEditAddressBody() {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: ListView(
            children: [
              const SizedBox(height: 72.0),
              MaskedTextField(
                  controller: cepController
                    ..text = cepMaskFormatter.maskText(widget.address.cep),
                  hintText: 'CEP',
                  obscureText: false,
                  inputFormatters: [cepMaskFormatter],
                  keyboardType: TextInputType.text),
              const SizedBox(height: 16.0),
              MyTextField(
                  controller: neighborhoodController
                    ..text = widget.address.neighborhood,
                  hintText: 'Bairro',
                  obscureText: false,
                  keyboardType: TextInputType.text),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        controller: streetController
                          ..text = widget.address.street,
                        hintText: 'Rua',
                        obscureText: false,
                        keyboardType: TextInputType.text),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: MyTextField(
                        controller: houseNumberController
                          ..text = widget.address.houseNumber,
                        hintText: 'Número',
                        obscureText: false,
                        keyboardType: TextInputType.text),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              MyTextField(
                controller: complementController
                  ..text = widget.address.complement,
                hintText: 'Complemento',
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              DropdownCitySelector(
                cities: MyCityRepo().getMyCities(),
                selectedCity: widget.address.city,
                onCitySelected: (MyCity? city) {
                  setState(() {
                    selectedCity = city;
                  });
                },
              ),
              const SizedBox(height: 36.0),
              MyButton(
                onTap: update,
                text: 'Salvar',
              ),
              const SizedBox(height: 36.0),
              MainAddressButton(
                onTap: setMainAddress,
                text: 'Tornar Principal',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
