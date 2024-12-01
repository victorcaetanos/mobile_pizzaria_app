import 'package:flutter/material.dart';
import 'package:mobile_pizzaria_app/features/category/domain/entities/category.dart';

class DropdownCategorySelector extends StatefulWidget {
  final List<MyCategory> categories;
  final MyCategory? selectedCategory;
  final Function(MyCategory?) onCategorySelected;

  const DropdownCategorySelector({
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    super.key,
  });

  @override
  State<DropdownCategorySelector> createState() =>
      _DropdownCategorySelectorState();
}

class _DropdownCategorySelectorState extends State<DropdownCategorySelector> {
  MyCategory? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<MyCategory>(
      dropdownColor: Theme.of(context).colorScheme.secondary,
      iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
      value: selectedCategory,
      hint: Text(
        'Categorias',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      items: widget.categories.map((category) {
        return DropdownMenuItem<MyCategory>(
          value: category,
          child: Text(
            category.name,
            style: TextStyle(
              color: selectedCategory == category
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.onPrimaryFixedVariant,
            ),
          ),
        );
      }).toList(),
      onChanged: (MyCategory? category) {
        setState(() {
          selectedCategory = category;
        });
        widget.onCategorySelected(category);
      },
      isExpanded: true, // This will make the dropdown take the full width
      underline: const SizedBox(), // This will remove the underline
      icon: const Padding(
        padding:
            EdgeInsets.only(left: 8.0), // Adjust the left padding as needed
        child: Icon(Icons.arrow_drop_down),
      ),
    );
  }
}