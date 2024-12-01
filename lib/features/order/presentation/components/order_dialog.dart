import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderDialog extends StatefulWidget {
  const OrderDialog({
    super.key,
  });

  @override
  State<OrderDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: 300,
        height: 200,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Entre em contato com a gente!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onLongPress: () {
                  Clipboard.setData(const ClipboardData(text: '1234-5678'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Número fixo copiado!')),
                  );
                },
                child: const Text(
                  'Tel. fixo: 1234-5678',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onLongPress: () {
                  Clipboard.setData(const ClipboardData(text: '64987654321'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Número do WhatsApp copiado!')),
                  );
                },
                child: const Text(
                  'WhatsApp: (64) 98765-4321',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
