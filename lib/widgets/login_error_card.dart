import 'package:flutter/material.dart';

class LoginErrorCard extends StatelessWidget {

  final String message;

  const LoginErrorCard({

    super.key,

    required this.message,

  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.only(top: 15),

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        color: Colors.red.shade50,

        borderRadius: BorderRadius.circular(12),

        border: Border.all(
          color: Colors.red.shade300,
        ),

      ),

      child: Row(

        children: [

          const Icon(
            Icons.error_outline,
            color: Colors.red,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),

        ],

      ),

    );

  }

}