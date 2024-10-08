import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedTextView extends StatelessWidget {
  final String text;
  final double cornerRadius;
  final double fontSize;
  RoundedTextView({required this.text, super.key})
      : cornerRadius = 8,
        fontSize = 12;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cornerRadius),
          border: Border.all(color: Colors.white)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    );
  }
}
