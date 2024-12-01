import 'package:flutter/material.dart';
import 'package:mobile_pizzaria_app/features/product/domain/entities/product.dart';
import 'package:mobile_pizzaria_app/features/product/presentation/components/my_icon_button.dart';
import 'package:mobile_pizzaria_app/features/product/presentation/components/product_dialog.dart';

class ProductDisplay extends StatelessWidget {
  final Product product;

  const ProductDisplay({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            product.imagePath,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        flex: 3,
                        child: Text(
                          product.description,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          maxLines: 6,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const SizedBox(height: 8.0),
                Text(
                  'A partir de R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: MyIconButton(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            ProductDialog(product: product),
                      );
                    },
                    icon: Icons.add,
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
