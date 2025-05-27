import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/cart/presentation/cubits/cart_cubit.dart';
import 'package:mobile_pizzaria_app/features/product/domain/entities/product.dart';
import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';
import 'package:mobile_pizzaria_app/features/size/presentation/components/size_dropdown_selector.dart';

class ProductDialog extends StatefulWidget {
  final Product product;

  const ProductDialog({
    required this.product,
    super.key,
  });

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  late MySize selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.product.sizes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        height: 300,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(),
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      widget.product.imagePath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      widget.product.description,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      maxLines: 7,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: DropdownSizeSelector(
                    sizes: widget.product.sizes,
                    onSizeSelected: (value) {
                      setState(() {
                        selectedSize = value!;
                      });
                    },
                    selectedSize: widget.product.sizes[0],
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  onPressed: () {
                    final CartCubit cartCubit = context.read<CartCubit>();
                    cartCubit.updateCartItem(
                      widget.product,
                      selectedSize,
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Adicionar R\$ ${widget.product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
