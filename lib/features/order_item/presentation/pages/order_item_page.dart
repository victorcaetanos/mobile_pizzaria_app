import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_pizzaria_app/features/order/presentation/components/my_img_button.dart'; 
import 'package:mobile_pizzaria_app/features/product/presentation/pages/product_list_page.dart'; 

class OptionsPage extends StatefulWidget {
  final String title;
  const OptionsPage({super.key, required this.title});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 12.0),
                _buildTittle('Nosso local'),
                const SizedBox(height: 14.0),
                _buildLocationCard(context),
                const SizedBox(height: 22.0),
                _buildTittle('Faça já seu pedido!'),
                const SizedBox(height: 22.0),
                _buildButton(
                  context,
                  const ProductListPage(),
                  'Pizza de um sabor',
                  'assets/icons/one_flavor_pizza.png',
                ),
                const SizedBox(height: 30.0),
                _buildButton(
                  context,
                  const ProductListPage(),
                  'Pizza de dois sabores',
                  'assets/icons/two_flavor_pizza.png',
                ),
                const SizedBox(height: 12.0),
              ],
            ),
          ),
        ),
      ), 
    );
  }

  Text _buildTittle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  MyImgButton _buildButton(
    BuildContext context,
    Widget nextPage,
    String text,
    String imgPath,
  ) {
    return MyImgButton(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => nextPage,
          ),
        );
      },
      text: text,
      imgPath: imgPath,
    );
  }

  GestureDetector _buildLocationCard(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(const ClipboardData(
          text:
              'Rua dos Sonhos, 123 Bairro Imaginário Cidade dos Contos, SP CEP: 12345-678',
        ));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Endereço copiado!')),
        );
      },
      child: Container(
        height: 140,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/icons/pizza_place.jpg',
                    fit: BoxFit.cover,
                    semanticLabel: 'Pizzeria Location Image',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Rua dos Sonhos, 123\nBairro Imaginário\nCidade dos Contos, SP\nCEP: 12345-678',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
