import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SnackBarHelper {

  SnackBarHelper._();

  //--------------------------------------------------
  // Information
  //--------------------------------------------------

  static void info(
      BuildContext context,
      String message,
      ) {

    _show(

      context,

      message,

      AppColors.primary,

      Icons.info_outline,

    );

  }

  //--------------------------------------------------
  // Succès
  //--------------------------------------------------

  static void success(
      BuildContext context,
      String message,
      ) {

    _show(

      context,

      message,

      Colors.green,

      Icons.check_circle_outline,

    );

  }

  //--------------------------------------------------
  // Erreur
  //--------------------------------------------------

  static void error(
      BuildContext context,
      String message,
      ) {

    _show(

      context,

      message,

      Colors.red,

      Icons.error_outline,

    );

  }

  //--------------------------------------------------
  // Méthode privée
  //--------------------------------------------------

  static void _show(

      BuildContext context,

      String message,

      Color color,

      IconData icon,

      ) {

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(

        behavior: SnackBarBehavior.floating,

        backgroundColor: color,

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(14),

        ),

        content: Row(

          children: [

            Icon(

              icon,

              color: Colors.white,

            ),

            const SizedBox(width: 12),

            Expanded(

              child: Text(

                message,

                style: const TextStyle(

                  color: Colors.white,

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