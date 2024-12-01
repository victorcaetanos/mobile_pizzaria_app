import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/my_button.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/masked_text_field.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/my_text_field.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/cubits/card_cubit.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/cubits/card_state.dart';
import 'package:mobile_pizzaria_app/features/loading/pages/loading_page.dart';
import 'package:mobile_pizzaria_app/utils/utils.dart';

class CreateCardPage extends StatefulWidget {
  const CreateCardPage({super.key});

  @override
  State<CreateCardPage> createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  final cardNameController = TextEditingController();
  final cpfController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expireDateController = TextEditingController();
  final cvvController = TextEditingController();

  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final AuthCubit authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  void create() {
    final String cardName = cardNameController.text;
    final String cpf = cpfMaskFormatter.unmaskText(cpfController.text);
    final String cardNumber =
        cardMaskFormatter.unmaskText(cardNumberController.text);
    final String expireDate = expireDateController.text;
    final String cvv = cvvMaskFormatter.unmaskText(cvvController.text);

    String errorMessage =
        _checkFields(cardName, cpf, cardNumber, expireDate, cvv);
    if (errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
      return;
    }

    final CardCubit cardCubit = context.read<CardCubit>();

    cardCubit.createCard(
      cardName,
      cardNumber,
      cpf,
      expireDate,
      cvv,
      currentUser?.id ?? '',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cartão criado com sucesso!'),
      ),
    );
  }

  String _checkFields(
    String cardName,
    String cpf,
    String cardNumber,
    String expireDate,
    String cvv,
  ) {
    if (cardName.isEmpty ||
        cpf.isEmpty ||
        cardNumber.isEmpty ||
        expireDate.isEmpty ||
        cvv.isEmpty) {
      return 'Todos os campos são obrigatórios';
    } else if (cpf.length != 11) {
      return 'CPF deve ter 11 dígitos';
    } else if (cardNumber.length < 16) {
      return 'Número do cartão deve ter no minimo 16 dígitos';
    } else if (cardNumber.length > 19) {
      return 'Número do cartão deve ter no máximo 19 dígitos';
    } else if (expireDate.length != 7) {
      return 'Data deve ser escrita em MM/AAAA';
    } else if (cvv.length != 3) {
      return 'CVV deve ter 3 dígitos';
    }
    return '';
  }

  @override
  void dispose() {
    cardNameController.dispose();
    cpfController.dispose();
    cardNumberController.dispose();
    expireDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardCubit, CardState>(
      builder: (context, state) {
        if (state is CardLoaded) {
          return _buildCreatePage();
        } else if (state is CardLoading) {
          return const LoadingPage();
        } else {
          return Scaffold(
            body: Center(
              child: Text("Cartão não criado $state"),
            ),
          );
        }
      },
      listener: (context, state) {
        if (state is CardLoaded) {
          return Navigator.pop(context);
        }
      },
    );
  }

  Widget _buildCreatePage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: const Text(
          'Registre seu Cartão',
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
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ListView(
              children: [
                const SizedBox(height: 72.0),
                MyTextField(
                  controller: cardNameController,
                  hintText: 'Nome do Cartão',
                  obscureText: false,
                        keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 16.0),
                MaskedTextField(
                  controller: cpfController,
                  hintText: 'CPF',
                  obscureText: false,
                  inputFormatters: [cpfMaskFormatter],
                        keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                MaskedTextField(
                  controller: cardNumberController,
                  hintText: 'Número do Cartão',
                  obscureText: false,
                  inputFormatters: [cardMaskFormatter],
                        keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: MaskedTextField(
                        controller: expireDateController,
                        hintText: 'Data de Validade',
                        obscureText: false,
                        inputFormatters: [dateMaskFormatter],
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: MaskedTextField(
                        controller: cvvController,
                        hintText: 'CVV',
                        obscureText: false,
                        inputFormatters: [cvvMaskFormatter],
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36.0),
                MyButton(
                  onTap: create,
                  text: 'Criar',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
