import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class NoteCard extends StatelessWidget {

  final String image;
  final String title;
  final String subtitle;

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const NoteCard({

    super.key,

    required this.image,

    required this.title,

    required this.subtitle,

    required this.onEdit,

    required this.onDelete,
    this.onTap,

  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: onTap,

      borderRadius: BorderRadius.circular(22),

      child: Card(
        margin: const EdgeInsets.only(bottom:18),

        elevation: 3,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),

        child: Padding(

          padding: const EdgeInsets.all(14),

          child: Row(

            children: [

              Image.asset(
                image,
                width:70,
              ),

              const SizedBox(width:18),

              Expanded(

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(

                      title,

                      style: const TextStyle(

                        fontWeight: FontWeight.bold,

                        fontSize: 18,

                      ),

                    ),

                    const SizedBox(height:5),

                    Text(

                      subtitle,

                      style: const TextStyle(

                        fontSize:18,

                        color: Colors.black54,

                      ),

                    ),

                  ],

                ),

              ),

              IconButton(

                onPressed: onEdit,

                icon: const Icon(

                  Icons.edit,

                  color: AppColors.primary,

                ),

              ),

              IconButton(

                onPressed: onDelete,

                icon: const Icon(

                  Icons.delete,

                  color: Colors.red,

                ),

              )

            ],

          ),

        ),

      ),

    );


  }

}