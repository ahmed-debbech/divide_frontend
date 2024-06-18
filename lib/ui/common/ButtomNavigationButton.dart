import 'package:flutter/material.dart';

class BottomNavigationButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function() onPressedButton;

  const BottomNavigationButton({required this.label, required this.icon, 
  required this.onPressedButton});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressedButton
        ),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
