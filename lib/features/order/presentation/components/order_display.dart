import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pizzaria_app/features/order/domain/entities/order.dart';

class OrderDisplay extends StatelessWidget {
  final Order order;
  final bool activeOrder;

  const OrderDisplay({
    required this.order,
    required this.activeOrder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: activeOrder
            ? Theme.of(context).colorScheme.tertiary.withOpacity(0.9)
            : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Pedido feito as ${DateFormat('HH:mm dd/MM/yyyy').format(order.createdAt)}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: activeOrder
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          order.items
                              .map((item) =>
                                  '${item.quantity}x ${item.product.name}. ${item.size.name}${item.size.slices != null ? ' (${item.size.slices} fatias)' : ''}')
                              .join('\n'),
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            color: activeOrder
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Theme.of(context).colorScheme.onSecondary,
                          ),
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4.0),
                      Text(
                        'Endereço para entrega:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: activeOrder
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          '${order.address.street}, ${order.address.houseNumber}.'
                          '${order.address.neighborhood}, ${order.address.complement}\n'
                          '${order.address.city.name}, ${order.address.city.state.abbreviation}. '
                          'CEP: ${order.address.cep}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: activeOrder
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Theme.of(context).colorScheme.onSecondary,
                          ),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
