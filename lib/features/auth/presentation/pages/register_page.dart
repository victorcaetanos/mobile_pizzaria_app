import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/my_button.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/masked_text_field.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/my_text_field.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mobile_pizzaria_app/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;

  const RegisterPage({
    super.key,
    required this.togglePages,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() {
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String phone = phoneMaskFormatter.unmaskText(phoneController.text);
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    final AuthCubit authCubit = context.read<AuthCubit>();

    String errorMessage = _checkFields(
        firstName, lastName, phone, email, password, confirmPassword);
    if (errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
      return;
    }

    authCubit.register(email, password, firstName, lastName, phone);
  }

  String _checkFields(
    String firstName,
    String lastName,
    String phone,
    String email,
    String password,
    String confirmPassword,
  ) {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return 'Todos os campos são obrigatórios';
    } else if (phone.length < 8) {
      return 'Telefone deve ter no minimo 8 dígitos';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Email inválido';
    } else if (password.length < 8) {
      return 'Senha deve ter no minimo 8 dígitos';
    } else if (password != confirmPassword) {
      return 'As senhas informadas estão diferentes';
    }
    return '';
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ListView(
              children: [
                const SizedBox(height: 9.0),
                Image.asset(
                  'assets/icons/pizzaria_logo1.png',
                  width: 240,
                  height: 240,
                  fit: BoxFit.contain,
                  semanticLabel: 'Pizzeria Logo',
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Criar uma nova conta',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                        controller: firstNameController,
                        hintText: 'Nome',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(width: 9.0),
                    Expanded(
                      child: MyTextField(
                        controller: lastNameController,
                        hintText: 'Sobrenome',
                        obscureText: false,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                MaskedTextField(
                  controller: phoneController,
                  hintText: 'Telefone',
                  obscureText: false,
                  inputFormatters: [phoneMaskFormatter],
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12.0),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12.0),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 12.0),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Repita a senha',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 36.0),
                MyButton(
                  onTap: register,
                  text: 'Cadastre-se',
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Já possui uma conta?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
                TextButton(
                  onPressed: widget.togglePages,
                  child: Text(
                    'Entre agora!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
