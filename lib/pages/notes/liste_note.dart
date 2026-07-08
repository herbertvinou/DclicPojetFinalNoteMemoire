import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/note_card.dart';
import '../notes/add_note.dart';

class ListeNote extends StatefulWidget {
  const ListeNote({super.key});

  @override
  State<ListeNote> createState() => _ListeNoteState();
}

class _ListeNoteState extends State<ListeNote> {

  final List<Map<String, dynamic>> notes = [

    {
      "title":"A faire",
      "date":"01/07/2026",
      "image":"assets/images/icone_note.png"
    },

    {
      "title":"Réunion Flutter",
      "date":"30/06/2026",
      "image":"assets/images/icone_note.png"
    },

    {
      "title":"Projet Mémoire",
      "date":"29/06/2026",
      "image":"assets/images/icone_note.png"
    },

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      drawer: Drawer(),

      appBar: AppBar(

        centerTitle: true,

        title: const Text(
          "Liste des notes",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),

        actions: [

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: AppColors.primary,
              size: 34,
            ),
          )

        ],
      ),

      floatingActionButton: FloatingActionButton(

        backgroundColor: AppColors.primary,

        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),

        onPressed: (){

          /*
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddNotePage(),
            ),
          );*/

        },

      ),

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(18),

          child: Column(

            children: [

              CustomButton(

                text: "AJOUTER UNE NOTE",

                icon: Icons.note_add_rounded,

                onPressed: (){

                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddNotePage(),
                    ),
                  );

                   */

                },

              ),

              const SizedBox(height:25),

              Expanded(

                child: ListView.builder(

                  itemCount: notes.length,

                  itemBuilder: (context,index){

                    final note=notes[index];

                    return NoteCard(

                      image: note["image"],

                      title: note["title"],

                      subtitle: note["date"],

                      onEdit: (){

                      },

                      onDelete: (){

                      },

                    );

                  },

                ),

              )

            ],

          ),

        ),

      ),

    );

  }

}