import 'package:flutter/material.dart';

class MyImgButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final String imgPath;

  const MyImgButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              imgPath,
              height: 100,
              fit: BoxFit.cover,
              semanticLabel: 'Button Image',
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                  overflow: TextOverflow.visible,
                ),
                softWrap: true,
                
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
