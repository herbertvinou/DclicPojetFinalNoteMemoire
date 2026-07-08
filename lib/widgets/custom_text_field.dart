import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  final bool enabled;
  final bool readOnly;
  final bool autofocus;

  final int maxLines;

  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),

      child: TextFormField(
        controller: controller,

        //keyboardType: keyboardType,
        keyboardType: maxLines > 1
            ? TextInputType.multiline
            : keyboardType,

        textInputAction: maxLines > 1
            ? TextInputAction.newline
            : textInputAction,

        enabled: enabled,

        readOnly: readOnly,

        autofocus: autofocus,

        maxLines: maxLines,

        validator: validator,

        decoration: InputDecoration(
          labelText: label,

          prefixIcon: Align(
            alignment: Alignment.topCenter,
            widthFactor: 1,
            heightFactor: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Icon(icon),
            ),
          ),
        ),
      ),
    );
  }
}