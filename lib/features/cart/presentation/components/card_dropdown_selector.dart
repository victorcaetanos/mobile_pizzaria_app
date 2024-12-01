import 'package:flutter/material.dart';
import 'package:mobile_pizzaria_app/features/card/domain/entities/card.dart';

class DropdownCardSelector extends StatefulWidget {
  final List<MyCard> cards;
  final MyCard? selectedCard;
  final Function(MyCard?) onCardSelected;

  const DropdownCardSelector({
    required this.cards,
    required this.selectedCard,
    required this.onCardSelected,
    super.key,
  });

  @override
  State<DropdownCardSelector> createState() => _DropdownCardSelectorState();
}

class _DropdownCardSelectorState extends State<DropdownCardSelector> {
  MyCard? selectedCard;

  @override
  void initState() {
    super.initState();
    selectedCard = widget.selectedCard;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: DropdownButton<MyCard>(
          dropdownColor: Theme.of(context).colorScheme.secondary,
          iconEnabledColor: Theme.of(context).colorScheme.onSecondary,
          value: selectedCard,
          hint: Text(
            'Cartões',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          items: widget.cards.map((card) {
            return DropdownMenuItem<MyCard>(
              value: card,
              child: Text(
                'Cartão com final ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                style: TextStyle(
                  color: selectedCard == card
                      ? Theme.of(context).colorScheme.onSecondary
                      : Theme.of(context).colorScheme.onPrimaryFixedVariant,
                ),
              ),
            );
          }).toList(),
          onChanged: (MyCard? card) {
            setState(() {
              selectedCard = card;
            });
            widget.onCardSelected(card);
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
