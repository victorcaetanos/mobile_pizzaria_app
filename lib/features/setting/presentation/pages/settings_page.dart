import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/address/presentation/pages/address_list_page.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mobile_pizzaria_app/features/card/presentation/pages/card_list_page.dart';
import 'package:mobile_pizzaria_app/features/setting/presentation/components/my_button.dart';
import 'package:mobile_pizzaria_app/features/user/presentation/pages/profile_page.dart';

class SettingsPage extends StatefulWidget {
  final String title;

  const SettingsPage({super.key, required this.title});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        leading: Container(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  text: 'Meus dados',
                  icon: Icons.keyboard_arrow_right_rounded,
                ),
                const SizedBox(height: 16),
                MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddressListPage(),
                      ),
                    );
                  },
                  text: 'Endereços',
                  icon: Icons.keyboard_arrow_right_rounded,
                ),
                const SizedBox(height: 16),
                MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CardListPage(),
                      ),
                    );
                  },
                  text: 'Formas de Pagamento',
                  icon: Icons.keyboard_arrow_right_rounded,
                ),
                const SizedBox(height: 16),
                MyButton(
                  onTap: () {
                    context.read<AuthCubit>().logout();
                  },
                  text: 'Sair',
                  icon: Icons.logout,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
