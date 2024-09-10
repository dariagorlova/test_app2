import 'package:flutter/material.dart';

class CaptionWidget extends StatelessWidget {
  const CaptionWidget({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 32),
    );
  }
}
