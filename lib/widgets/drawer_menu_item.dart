import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {

  final IconData icon;

  final String title;

  final VoidCallback onTap;

  final bool selected;

  const DrawerMenuItem({

    super.key,

    required this.icon,

    required this.title,

    required this.onTap,

    this.selected = false,

  });
  @override
  Widget build(BuildContext context) {

    final primary = Theme.of(context).colorScheme.primary;

    return Material(

      color: Colors.transparent,

      child: InkWell(

        onTap: onTap,

        child: Container(

          height: 56,

          decoration: BoxDecoration(

            border: Border(

              left: BorderSide(

                color: selected
                    ? primary
                    : Colors.transparent,

                width: 4,

              ),

            ),

            color: selected

                ? primary.withOpacity(.08)

                : Colors.transparent,

          ),

          child: Row(

            children: [

              const SizedBox(width: 18),

              Icon(

                icon,

                color: selected
                    ? primary
                    : Colors.grey,

              ),

              const SizedBox(width: 22),

              Expanded(

                child: Text(

                  title,

                  style: TextStyle(

                    fontSize: 16,

                    fontWeight: selected
                        ? FontWeight.bold
                        : FontWeight.w500,

                    color: selected
                        ? primary
                        : Colors.black87,

                  ),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }
}