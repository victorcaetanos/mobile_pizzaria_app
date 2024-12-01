import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/my_button.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/masked_text_field.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/components/my_text_field.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mobile_pizzaria_app/features/home/presentation/pages/home_page.dart';
import 'package:mobile_pizzaria_app/features/user/domain/entities/profile_user.dart';
import 'package:mobile_pizzaria_app/features/user/presentation/cubits/profile_cubit.dart';
import 'package:mobile_pizzaria_app/features/user/presentation/cubits/profile_state.dart';
import 'package:mobile_pizzaria_app/features/loading/pages/loading_page.dart';
import 'package:mobile_pizzaria_app/utils/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthCubit authCubit = context.read<AuthCubit>();
  late ProfileCubit profileCubit = context.read<ProfileCubit>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late AppUser? currentUser = authCubit.currentUser;

  @override
  void initState() {
    super.initState();
    profileCubit.getUserProfile();
  }

  bool update() {
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String phone =
        phoneController.text.replaceAll(phoneReplacementRegex, '');
    final String email = emailController.text;
    final String password = passwordController.text;

    String errorMessage =
        _checkFields(firstName, lastName, phone, email, password);
    if (errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
      return false;
    }

    profileCubit.updateProfile(
      ProfileUser(
        user: AppUser(
          id: profileCubit.currentProfileUser!.user.id,
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phone,
        ),
        role: profileCubit.currentProfileUser!.role,
        isActive: profileCubit.currentProfileUser!.isActive,
        selectedCardId: profileCubit.currentProfileUser!.selectedCardId,
        selectedAddressId: profileCubit.currentProfileUser!.selectedAddressId,
        hasActiveCart: profileCubit.currentProfileUser!.hasActiveCart,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil atualizado com sucesso!'),
      ),
    );
    return true;
  }

  String _checkFields(
    String firstName,
    String lastName,
    String phone,
    String email,
    String password,
  ) {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      return 'Todos os campos são obrigatórios';
    } else if (phone.length < 8) {
      return 'Telefone deve ter no minimo 8 dígitos';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Email inválido';
    } else if (password.length < 8) {
      return 'Senha deve ter no minimo 8 dígitos';
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
              title: const Text(
                'Meus Dados',
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
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: ListView(
                    children: [
                      const SizedBox(height: 72.0),
                      Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              controller: firstNameController
                                ..text = state.profileUser.user.firstName,
                              hintText: 'Nome',
                              obscureText: false,
                        keyboardType: TextInputType.text,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: MyTextField(
                              controller: lastNameController
                                ..text = state.profileUser.user.lastName,
                              hintText: 'Sobrenome',
                              obscureText: false,
                        keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      MaskedTextField(
                        controller: phoneController
                          ..text = state.profileUser.user.phoneNumber,
                        hintText: 'Telefone',
                        obscureText: false,
                        inputFormatters: [phoneMaskFormatter],
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16.0),
                      MyTextField(
                        controller: emailController
                          ..text = state.profileUser.user.email,
                        hintText: 'Email',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16.0),
                      MyTextField(
                        controller: passwordController
                          ..text = state.profileUser.user.password,
                        hintText: 'Senha',
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 36.0),
                      MyButton(
                        onTap: () {
                          if (update()) {
                            Navigator.pop(context, true);
                          }
                        },
                        text: 'Salvar',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is ProfileLoading) {
          return const LoadingPage();
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Dados não encontrados"),
            ),
          );
        }
      },
    );
  }
}
