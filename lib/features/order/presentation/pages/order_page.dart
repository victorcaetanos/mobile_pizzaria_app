import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_pizzaria_app/features/order/domain/entities/order.dart';
import 'package:mobile_pizzaria_app/features/order/presentation/components/order_dialog.dart';

class OrderPage extends StatefulWidget {
  final Order order;
  const OrderPage({super.key, required this.order});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text(
          'Detalhes do Pedido',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        leading: Container(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 12.0),
                _buildStatusSection('Nosso local'),
                const SizedBox(height: 16.0),
                _buildItemsSection(context),
                const SizedBox(height: 8.0),
                _buildAddressSection(context),
                const SizedBox(height: 8.0),
                _buildPaymentSection(context),
                const SizedBox(height: 8.0),
                _buildNoteSection(context),
                const SizedBox(height: 8.0),
                _buildHelpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusSection(String text) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildStatusColumn(
                  0,
                  Icons.library_add_check_outlined,
                  widget.order.status,
                  'Pedido feito',
                ),
                _buildStatusColumn(
                  1,
                  Icons.local_fire_department,
                  widget.order.status,
                  'Em produção',
                ),
                _buildStatusColumn(
                  2,
                  Icons.delivery_dining_rounded,
                  widget.order.status,
                  'A caminho',
                ),
                _buildStatusColumn(
                  3,
                  Icons.check_rounded,
                  widget.order.status,
                  'Concluído',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildStatusColumn(
    int statusId,
    IconData icon,
    String status,
    String text,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: statusId < calculateStatusId(status)
              ? const Color(0xFF0E4910).withOpacity(0.6)
              : statusId == calculateStatusId(status)
                  ? Theme.of(context).colorScheme.tertiary.withOpacity(0.6)
                  : Theme.of(context).colorScheme.onSecondary.withOpacity(0.2),
          size: 30,
        ),
        Icon(
          Icons.circle,
          color: statusId < calculateStatusId(status)
              ? const Color(0xFF0E4910)
              : statusId == calculateStatusId(status)
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.onSecondary.withOpacity(0.2),
          size: 14,
        ),
        Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  int calculateStatusId(String status) {
    switch (widget.order.status) {
      case 'ordered':
        return 0;
      case 'making':
        return 1;
      case 'underway':
        return 2;
      case 'finished':
        return 3;
      default:
        return 0;
    }
  }

  Widget _buildItemsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Produtos:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ...widget.order.items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 6, left: 12),
            child: Text(
              '${item.quantity}x ${item.product.name}${item.size.slices != null ? ". ${item.size.name} (${item.size.slices} fatias)" : ". ${item.size.name}"} R\$${item.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Endereço para entrega:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            '${widget.order.address.city.name}, '
            '${widget.order.address.city.state.abbreviation}. '
            '${widget.order.address.neighborhood} '
            'CEP: ${widget.order.address.cep} '
            '${widget.order.address.street}, ${widget.order.address.houseNumber}. ',
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Forma de pagamento:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Cartão com final ${widget.order.card.cardNumber.substring(widget.order.card.cardNumber.length - 4)}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onLongPress: () {
            final price = 'R\$${widget.order.total.toStringAsFixed(2)}';
            Clipboard.setData(ClipboardData(
              text: price,
            ));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Preço copiado para área de transferência',
                ),
              ),
            );
          },
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Total: R\$${widget.order.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Observação:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.all(12),
          child: Text(
            widget.order.notes != '' ? widget.order.notes : 'Sem observações',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  TextButton _buildHelpButton() {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => const OrderDialog(),
        );
      },
      child: Text(
        'Precisa de ajuda com o pedido?',
        style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
          fontSize: 12,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
