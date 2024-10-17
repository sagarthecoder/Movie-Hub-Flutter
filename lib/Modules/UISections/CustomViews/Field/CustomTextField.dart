import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? placeholder;
  final String? labelText;
  final TextEditingController controller;
  final bool isObscureText;

  const CustomTextField({
    this.placeholder = "",
    this.labelText,
    this.isObscureText = false,
    required this.controller,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Fetch the current theme

    return TextField(
      controller: widget.controller,
      obscureText: widget.isObscureText,
      style: TextStyle(color: theme.colorScheme.onBackground),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        hintText: widget.placeholder,
        filled: true,
        fillColor: theme.scaffoldBackgroundColor,
        hintStyle:
            TextStyle(color: theme.colorScheme.onBackground.withOpacity(0.5)),
        labelText: widget.labelText ?? "",
        labelStyle: TextStyle(color: theme.colorScheme.primary),
      ),
    );
  }
}
