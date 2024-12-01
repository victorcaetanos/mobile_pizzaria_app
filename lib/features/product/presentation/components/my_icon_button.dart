import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;

  const MyIconButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onInverseSurface,
            size: 32,
          ),
        ),
      ),
    );
  }
}
