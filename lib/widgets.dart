import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  const IconAndText(this.icon, this.text, {super.key});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(180.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(
            width: 180.0,
          ),
          Text(text)
        ],
      ),
    );
  }
}
