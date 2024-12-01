import 'package:flutter/material.dart';

class MyFloatingButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const MyFloatingButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Icon(
        Icons.shopping_cart_rounded,
        color: Theme.of(context).colorScheme.onTertiary,
      ),
    );
  }
}
