import 'package:flutter/material.dart';

class Dividers extends StatelessWidget {
  const Dividers({super.key, required this.color, required this.height});

  final Color color;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: color,
      endIndent: 50,
      indent: 40,
    );
  }
}
