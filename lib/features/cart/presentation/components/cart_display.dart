import 'package:flutter/material.dart';
import 'package:mobile_pizzaria_app/features/cart/domain/entities/cart.dart';

class CartDisplay extends StatelessWidget {
  final Cart cart;

  const CartDisplay({
    required this.cart,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2.0),
          const Text(
            '1x Pizza Marguerita - R\$ 20.00\n'
            '1x Pizza pepperoni - R\$ 20.00\n'
            '1x Frango com catupiry - R\$ 20.00\n',
            style: TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Total: R\$ 60.00',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
