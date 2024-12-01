import 'package:flutter/material.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/city.dart';

class DropdownCitySelector extends StatefulWidget {
  final List<MyCity> cities;
  final MyCity? selectedCity;
  final Function(MyCity?) onCitySelected; // Callback for selected city

  const DropdownCitySelector({
    required this.cities,
    required this.selectedCity,
    required this.onCitySelected,
    super.key,
  });

  @override
  State<DropdownCitySelector> createState() => _DropdownCitySelectorState();
}

class _DropdownCitySelectorState extends State<DropdownCitySelector> {
  MyCity? selectedCity;

  @override
  void initState() {
    super.initState();
    selectedCity = widget.selectedCity;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<MyCity>(
      dropdownColor: Theme.of(context).colorScheme.secondary,
      iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
      value: selectedCity,
      hint: Text(
        'Selecione uma cidade',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      items: widget.cities.map((city) {
        return DropdownMenuItem<MyCity>(
          value: city,
          child: Text(
            '${city.name} (${city.state.name})',
            style: TextStyle(
              color: selectedCity == city
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.onPrimaryFixedVariant,
            ),
          ),
        );
      }).toList(),
      onChanged: (MyCity? city) {
        setState(() {
          selectedCity = city;
        });
        widget.onCitySelected(city);
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
