import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.onChanged,
    this.fillColor,
  });

  final String hintText;
  final bool obscureText;
  final void Function(String)? onChanged;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Value here is required';
        }
        return null;
      },
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey.shade500,
        ),
        contentPadding: const EdgeInsets.all(18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),
        fillColor: fillColor ?? Colors.grey.shade200,
        filled: true,
      ),
      cursorColor: Colors.black,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
    );
  }
}
