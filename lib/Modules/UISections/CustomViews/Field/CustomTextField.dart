import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? placeholder;
  final String? labelText;
  final TextEditingController controller;
  final bool isObscureText;
  const CustomTextField(
      {this.placeholder = "",
      this.labelText,
      this.isObscureText = false,
      required this.controller,
      super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isObscureText,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: widget.placeholder,
          filled: true,
          fillColor: Colors.white60,
          labelText: widget.labelText ?? ""),
    );
  }
}
