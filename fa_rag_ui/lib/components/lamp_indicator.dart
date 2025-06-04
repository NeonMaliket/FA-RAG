import 'package:flutter/material.dart';

class LampIndicator extends StatelessWidget {
  final bool isOn;
  final String message;

  const LampIndicator({super.key, required this.isOn, required this.message});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isOn ? Colors.green : Colors.red,
          boxShadow: [
            BoxShadow(
              color: isOn ? Colors.greenAccent : Colors.redAccent,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}
