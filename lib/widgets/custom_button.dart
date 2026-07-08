import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

/// Les différents styles de bouton
enum ButtonType {
  filled,
  outlined,
}

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ButtonType type;

  final bool loading;

  final double width;
  final double height;

  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.type = ButtonType.filled,
    this.loading = false,
    this.width = double.infinity,
    this.height = 55,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool outlined = type == ButtonType.outlined;

    return SizedBox(
      width: width,
      height: height,

      child: outlined

      /// ==========================
      /// OUTLINED BUTTON
      /// ==========================
          ? OutlinedButton(
        onPressed: loading ? null : onPressed,

        style: OutlinedButton.styleFrom(

          side: BorderSide(
            color: backgroundColor ?? AppColors.primary,
            width: 2,
          ),

          foregroundColor:
          foregroundColor ?? AppColors.primary,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),

        ),

        child: loading

            ? SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color:
            foregroundColor ?? AppColors.primary,
          ),
        )

            : Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [

            if (icon != null) ...[
              Icon(
                icon,
                size: 22,
              ),
              const SizedBox(width: 8),
            ],

            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      )

      /// ==========================
      /// FILLED BUTTON
      /// ==========================
          : ElevatedButton(
        onPressed: loading ? null : onPressed,

        style: ElevatedButton.styleFrom(

          backgroundColor:
          backgroundColor ?? AppColors.primary,

          foregroundColor:
          foregroundColor ?? Colors.white,

          elevation: 2,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),

        ),

        child: loading

            ? const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )

            : Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [

            if (icon != null) ...[
              Icon(
                icon,
                size: 22,
              ),
              const SizedBox(width: 8),
            ],

            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

/*

import 'package:flutter/material.dart';

enum ButtonType {
  filled,
  outlined,
}

class CustomButton extends StatelessWidget {

  final String text;
  final bool loading;
  final VoidCallback onPressed;
  final ButtonType type;

  const CustomButton({
    super.key,
    required this.text,
    required this.loading,
    required this.onPressed,
    this.type = ButtonType.filled,
  });

  @override
  Widget build(BuildContext context) {

    if (type == ButtonType.outlined) {

      return SizedBox(
        width: double.infinity,
        height: 55,
        child: OutlinedButton(

          onPressed: loading ? null : onPressed,

          style: OutlinedButton.styleFrom(

            foregroundColor: Colors.deepPurple,

            side: const BorderSide(
              color: Colors.deepPurple,
              width: 2,
            ),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),

          ),

          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

        ),
      );

    }

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(

        onPressed: loading ? null : onPressed,

        style: ElevatedButton.styleFrom(

          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),

        ),

        child: loading

            ? const CircularProgressIndicator(
          color: Colors.white,
        )

            : Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
    );

  }
}

 */