import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {

  final TextEditingController controller;

  final bool obscureText;

  final VoidCallback onVisibilityChanged;

  final String? Function(String?) validator;

  final String label;

  const CustomPasswordField({

    super.key,

    required this.controller,

    required this.obscureText,

    required this.onVisibilityChanged,

    required this.validator,

    required this.label,

  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(

      controller: controller,

      obscureText: obscureText,

      validator: validator,

      decoration: InputDecoration(

        //labelText: "Mot de passe",
        labelText: label,



        prefixIcon: const Icon(Icons.lock_outline),

        suffixIcon: IconButton(

          icon: Icon(

            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,

          ),

          onPressed: onVisibilityChanged,

        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),

      ),

    );

  }

}