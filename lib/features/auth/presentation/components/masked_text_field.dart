import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaskedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType  keyboardType;

  const MaskedTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.inputFormatters,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.primaryFixed,
        ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: false,
      ),
      inputFormatters: inputFormatters,
    );
  }
}
