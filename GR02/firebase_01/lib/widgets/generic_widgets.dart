import 'package:flutter/material.dart';

class IconAndDetail extends StatelessWidget {
  final IconData icon;
  final String detail;

  const IconAndDetail(this.icon, this.detail, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(detail, style: const TextStyle(fontSize: 18)),
        ],)
      );

}
