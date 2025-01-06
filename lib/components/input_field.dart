import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final IconData icon;
  final Function(String) onChanged;
  final bool obscureText;

  const CustomInputField({
    super.key,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.obscureText = false,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      obscureText: widget.obscureText ? !showPassword : widget.obscureText,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => showPassword = !showPassword),
              )
            : null,
      ),
    );
  }
}
