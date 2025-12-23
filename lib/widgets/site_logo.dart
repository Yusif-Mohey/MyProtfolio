import 'package:flutter/material.dart';

class SiteLogo extends StatelessWidget {
  const SiteLogo({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        'Mohey',
        style: TextStyle(
          fontSize: 22,
          color: Colors.yellow,
          fontWeight: FontWeight.bold,
          // decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
