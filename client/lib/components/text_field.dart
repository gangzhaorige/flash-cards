import 'package:flutter/material.dart';

class FlashTextField extends StatelessWidget {
  const FlashTextField({
    super.key,
    required this.onChanged,
    required this.controller,
    required this.text,
    this.obscureText = false,
    this.enableSuggestions = false,
    this.autocorrect = false,
  });

  final Function onChanged;
  final TextEditingController controller;
  final String text;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => onChanged(value),
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
      controller: controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        labelText: text,
      ),
      style: const TextStyle(fontSize: 18),
    );
  }
}