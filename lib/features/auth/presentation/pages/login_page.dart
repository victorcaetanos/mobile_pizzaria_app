import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/my_button.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/my_text_field.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mobile_pizzaria_app/utils/utils.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;

  const LoginPage({
    super.key,
    required this.togglePages,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final String email = emailController.text;
    final String password = passwordController.text;

    final AuthCubit authCubit = context.read<AuthCubit>();
    String errorMessage = _checkFields(email, password);
    if (errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
    authCubit.login(email, password);
  }

  String _checkFields(
    String email,
    String password,
  ) {
    if (email.isEmpty || password.isEmpty) {
      return 'Todos os campos são obrigatórios';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Email inválido';
    } else if (password.length < 8) {
      return 'Senha deve ter no minimo 8 dígitos';
    }
    return '';
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                  'Realize seu Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
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
                const SizedBox(height: 36.0),
                MyButton(
                  onTap: login,
                  text: 'Entrar',
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Ainda não possui uma conta?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
                TextButton(
                  onPressed: widget.togglePages,
                  child: Text(
                    'Crie uma agora!',
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
