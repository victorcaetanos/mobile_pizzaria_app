import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/address/data/city_repo.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/city.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/components/city_dropdown_selector.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/cubits/address_cubit.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/cubits/address_state.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/my_button.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/masked_text_field.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/my_text_field.dart';
import 'package:mobile_pizzaria_app/features/user/presentation/cubits/profile_cubit.dart';
import 'package:mobile_pizzaria_app/features/loading/pages/loading_page.dart';
import 'package:mobile_pizzaria_app/utils/utils.dart';

class CreateAddressPage extends StatefulWidget {
  const CreateAddressPage({super.key});

  @override
  State<CreateAddressPage> createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage> {
  final cepController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final streetController = TextEditingController();
  final houseNumberController = TextEditingController();
  final complementController = TextEditingController();

  MyCity? selectedCity;

  void create() {
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

    final ProfileCubit profileCubit = context.read<ProfileCubit>();
    final AddressCubit addressCubit = context.read<AddressCubit>();

    addressCubit.createAddress(
      cep,
      street,
      houseNumber,
      complement,
      neighborhood,
      profileCubit.currentProfileUser?.user.id ?? '',
      selectedCity!,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Endereço criado com sucesso!'),
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
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        if (state is AddressLoaded) {
          return _buildCreatePage(context);
        } else if (state is AddressLoading) {
          return const LoadingPage();
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Endereço não criado"),
            ),
          );
        }
      },
    );
  }

  Scaffold _buildCreatePage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: const Center(
          child: Text(
            'Registre seu Cartão',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
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
      body: _buildCreateAddressBody(),
    );
  }

  SafeArea _buildCreateAddressBody() {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: ListView(
            children: [
              const SizedBox(height: 72.0),
              MaskedTextField(
                controller: cepController,
                hintText: 'CEP',
                obscureText: false,
                inputFormatters: [cepMaskFormatter],
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              MyTextField(
                controller: neighborhoodController,
                hintText: 'Bairro',
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: streetController,
                      hintText: 'Rua',
                      obscureText: false,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: MyTextField(
                      controller: houseNumberController,
                      hintText: 'Número',
                      obscureText: false,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              MyTextField(
                controller: complementController,
                hintText: 'Complemento',
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16.0),
              DropdownCitySelector(
                cities: MyCityRepo().getMyCities(),
                selectedCity: null,
                onCitySelected: (MyCity? city) {
                  setState(() {
                    selectedCity = city;
                  });
                },
              ),
              const SizedBox(height: 36.0),
              MyButton(
                onTap: create,
                text: 'Salvar',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
