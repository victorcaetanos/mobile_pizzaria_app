import 'package:flutter/material.dart';
import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';

class DropdownSizeSelector extends StatefulWidget {
  final List<MySize> sizes;
  final MySize selectedSize;
  final Function(MySize?) onSizeSelected;

  const DropdownSizeSelector({
    required this.sizes,
    required this.selectedSize,
    required this.onSizeSelected,
    super.key,
  });

  @override
  State<DropdownSizeSelector> createState() => _DropdownSizeSelectorState();
}

class _DropdownSizeSelectorState extends State<DropdownSizeSelector> {
  MySize? selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.selectedSize;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6.0),
      padding: const EdgeInsets.only(left: 6.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: DropdownButton<MySize>(
        dropdownColor: Theme.of(context).colorScheme.secondary,
        iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
        value: selectedSize,
        hint: Text(
          'Tamahos',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        items: widget.sizes.map((size) {
          return DropdownMenuItem<MySize>(
            value: size,
            child: Text(
              size.name,
              style: TextStyle(
                color: selectedSize == size
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.onPrimaryFixedVariant,
              ),
            ),
          );
        }).toList(),
        onChanged: (MySize? size) {
          setState(() {
            selectedSize = size;
          });
          widget.onSizeSelected(size);
        },
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }
}
