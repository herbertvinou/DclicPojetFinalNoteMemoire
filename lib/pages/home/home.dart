import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../modele/note.dart';
import '../../services/note_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/note_card.dart';
import '../notes/add_note.dart';
import '../../modele/utilisateur.dart';
import '../notes/detail_note.dart';

class Home extends StatefulWidget {
  final Utilisateur utilisateur;

  const Home({
    super.key,
    required this.utilisateur,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  //=====================================
  // Variables
  //=====================================

  List<Note> _notes = [];

  bool _loading = true;

  //--------------------------------------------------
  // Chargement des notes
  //--------------------------------------------------

  Future<void> _loadNotes() async {

    setState(() {
      _loading = true;
    });

    _notes = await NoteService.instance.getNotesByUser(
      widget.utilisateur.idUtilisateur!,
    );

    setState(() {
      _loading = false;
    });

  }

  //--------------------------------------------------
  // Initialisation
  //--------------------------------------------------

  @override
  void initState() {

    super.initState();

    _loadNotes();

  }


  //=====================================
  // Interface
  //=====================================


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

        onPressed: () async {

          final refresh = await Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) => AddNotePage(

                utilisateur: widget.utilisateur,

              ),

            ),

          );

          if (refresh == true) {

            _loadNotes();

          }

        },

      ),

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(18),

          child: Column(

            children: [

              Container(

                width: double.infinity,

                margin: const EdgeInsets.only(bottom: 20),

                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),

                decoration: BoxDecoration(

                  color: AppColors.primary.withOpacity(.08),

                  borderRadius: BorderRadius.circular(15),

                ),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(

                      "Bienvenue 👋",

                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),

                    ),

                    const SizedBox(height: 4),

                    Text(

                      "${widget.utilisateur.prenom} ${widget.utilisateur.nom}",

                      style: const TextStyle(

                        fontSize: 22,

                        fontWeight: FontWeight.bold,

                        color: AppColors.primary,

                      ),

                    ),

                  ],

                ),

              ),

              CustomButton(

                text: "AJOUTER UNE NOTE",

                icon: Icons.note_add_rounded,

                onPressed: () async {

                  final refresh = await Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => AddNotePage(

                        utilisateur: widget.utilisateur,

                      ),

                    ),

                  );

                  if (refresh == true) {

                    _loadNotes();

                  }

                },


              ),

              const SizedBox(height:25),
              Expanded(
                child: _buildBody(),
              ),
              /*
              Expanded(

                child: _loading

                    ? const Center(
                  child: CircularProgressIndicator(),
                )

                    : _notes.isEmpty

                    ? const Center(
                  child: Text(
                    "Aucune note disponible",
                  ),
                )

                    : ListView.builder(

                  itemCount: _notes.length,

                  itemBuilder: (context, index) {

                    final note = _notes[index];

                    return NoteCard(

                      image: "assets/images/icone_note.png",

                      title: note.title,

                      subtitle: note.createdAt.toString(),

                      onEdit: (){

                      },

                      onDelete: (){

                      },

                    );


                  },

                ),

              ),*/

            ],

          ),

        ),

      ),

    );

  }
  Widget _buildBody() {

    //----------------------------------
    // Chargement
    //----------------------------------
    if (_loading) {

      return const Center(
        child: CircularProgressIndicator(),
      );

    }

    //----------------------------------
    // Aucune note
    //----------------------------------
    if (_notes.isEmpty) {

      return const Center(
        child: Text(
          "Aucune note disponible",
        ),
      );

    }

    //----------------------------------
    // Liste des notes
    //----------------------------------
    return ListView.builder(

      itemCount: _notes.length,

      itemBuilder: (context, index) {

        final note = _notes[index];

        return NoteCard(

          image: "assets/images/icone_note.png",

          title: note.title,

          subtitle: DateUtilsApp.format(note.createdAt),

          onTap: () async {

            final refresh = await Navigator.push(

              context,

              MaterialPageRoute(

                builder: (_) => NoteDetailsPage(

                  utilisateur: widget.utilisateur,

                  note: note,

                ),

              ),

            );

            if (refresh == true) {

              _loadNotes();

            }

          },

          //onEdit: () {},
          onEdit: () async {

            final refresh = await Navigator.push(

              context,

              MaterialPageRoute(

                builder: (_) => NoteDetailsPage(
                  utilisateur: widget.utilisateur,

                  note: note,

                ),

              ),

            );

            if (refresh == true) {

              _loadNotes();

            }

          },

          onDelete: () async {
            final refresh = await Navigator.push(

              context,

              MaterialPageRoute(

                builder: (_) => NoteDetailsPage(
                  utilisateur: widget.utilisateur,

                  note: note,

                ),

              ),

            );

            if (refresh == true) {

              _loadNotes();

            }
          },

        );
        /*
        return NoteCard(

          image: "assets/images/icone_note.png",

          title: note.title,

          subtitle: DateUtilsApp.format(note.createdAt),

          //subtitle: note.createdAt.toString(),

          onEdit: (){

          },

          onDelete: (){

          },

        );
        */
      },

    );

  }


}