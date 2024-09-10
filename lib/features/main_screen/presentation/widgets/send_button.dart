import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  const SendButton({
    required this.child,
    this.onPressed,
    super.key,
  });

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
