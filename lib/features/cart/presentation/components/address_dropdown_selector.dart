import 'package:flutter/material.dart';
import 'package:mobile_pizzaria_app/features/address/domain/entities/address.dart';
import 'package:mobile_pizzaria_app/utils/utils.dart';

class DropdownAddressSelector extends StatefulWidget {
  final List<Address> addresses;
  final Address? selectedAddress;
  final Function(Address?) onAddressSelected;

  const DropdownAddressSelector({
    required this.addresses,
    required this.selectedAddress,
    required this.onAddressSelected,
    super.key,
  });

  @override
  State<DropdownAddressSelector> createState() =>
      _DropdownAddressSelectorState();
}

class _DropdownAddressSelectorState extends State<DropdownAddressSelector> {
  Address? selectedAddress;

  @override
  void initState() {
    super.initState();
    selectedAddress = widget.selectedAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Center(
        child: DropdownButton<Address>(
          dropdownColor: Theme.of(context).colorScheme.secondary,
          iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
          value: selectedAddress,
          hint: Text(
            'Endereço de entrega',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          items: widget.addresses.map((address) {
            return DropdownMenuItem<Address>(
              value: address,
              child: Text(
                '${address.street}, ${address.houseNumber}, '
                '${address.neighborhood}, ${address.city.name} - '
                '${address.city.state.abbreviation}, ${cepMaskFormatter.maskText(address.cep)}',
                style: TextStyle(
                  color: selectedAddress == address
                      ? Theme.of(context).colorScheme.onSecondary
                      : Theme.of(context).colorScheme.onPrimaryFixedVariant,
                ),
              ),
            );
          }).toList(),
          onChanged: (Address? address) {
            setState(() {
              selectedAddress = address;
            });
            widget.onAddressSelected(address);
          },
          isExpanded: true,
          underline: const SizedBox(),
          icon: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.arrow_drop_down),
          ),
        ),
      ),
    );
  }
}
