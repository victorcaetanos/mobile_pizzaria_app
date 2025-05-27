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
            Column(
            children: cart.items.map((item) {
              return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                onTap: () {
                  // Handle item removal
                },
                child: const Icon(Icons.remove_circle, color: Colors.red),
                ),
                Text(
                '${item.quantity}x ${item.product.name} - R\$ ${item.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                ),
                GestureDetector(
                onTap: () {
                  // Handle item addition
                },
                child: const Icon(Icons.add_circle, color: Colors.green),
                ),
              ],
              );
            }).toList(),
            ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Total: R\$ ${cart.total().toStringAsFixed(2)}',
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
