import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../modele/note.dart';
import '../../services/note_service.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/note_card.dart';
import '../auth/connexion.dart';
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

  bool _isSearching = false;

  final TextEditingController _searchController = TextEditingController();

  List<Note> _filteredNotes = [];


  //--------------------------------------------------
  // Initialisation
  //--------------------------------------------------

  @override
  void initState() {

    super.initState();

    _loadNotes();

  }



  //--------------------------------------------------
  // Chargement des notes
  //--------------------------------------------------


  Future<void> _loadNotes() async {

    setState(() {
      _loading = true;
    });

    try {

      final notes = await NoteService.instance.getNotesByUser(
        widget.utilisateur.idUtilisateur!,
      );

      setState(() {

        _notes = notes;

        _filteredNotes = List.from(notes);

        _loading = false;

      });

    } catch (e) {

      setState(() {
        _loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur : $e"),
        ),
      );

    }

  }

  //--------------------------------------------------
  // recherche
  //--------------------------------------------------
  void _filterNotes(String keyword) {

    setState(() {

      if (keyword.trim().isEmpty) {

        _filteredNotes = List.from(_notes);

      } else {

        _filteredNotes = _notes.where((note) {

          return note.title
              .toLowerCase()
              .contains(keyword.toLowerCase());

        }).toList();

      }

    });

  }


  //--------------------------------------------------
  // Suppression d'une note
  //--------------------------------------------------

  Future<void> _deleteNote(Note note) async {

    final confirmation = await showDialog<bool>(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text("Supprimer la note"),

          content: Text(
            "Voulez-vous vraiment supprimer '${note.title}' ?",
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(context, false);

              },

              child: const Text("Annuler"),

            ),

            ElevatedButton(

              onPressed: () {

                Navigator.pop(context, true);

              },

              child: const Text("Supprimer"),

            ),

          ],

        );

      },

    );

    if (confirmation != true) {
      return;
    }

    await NoteService.instance.deleteNote(note.idNote!);

    _loadNotes();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text("Note supprimée avec succès."),

      ),

    );

  }

  //--------------------------------------------------
  // Déconnexion
  //--------------------------------------------------

  Future<void> _logout() async {

    final confirmation = await showDialog<bool>(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text("Déconnexion"),

          content: const Text(
            "Voulez-vous vraiment vous déconnecter ?",
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(context, false);

              },

              child: const Text("Annuler"),

            ),

            ElevatedButton(

              onPressed: () {

                Navigator.pop(context, true);

              },

              child: const Text("Déconnexion"),

            ),

          ],

        );

      },

    );

    if (confirmation != true) {

      return;

    }

    Navigator.pushAndRemoveUntil(

      context,

      MaterialPageRoute(

        builder: (_) => Connexion(),

      ),

          (route) => false,

    );

  }


  //=====================================
  // Interface
  //=====================================


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      //drawer: Drawer()
      /*
      drawer: _isSearching ? null : Drawer(
        // ton Drawer actuel
      ),
       */
      /*
      drawer: AppDrawer(

        utilisateur: widget.utilisateur,

      ),

       */

      drawer: AppDrawer(

        utilisateur: widget.utilisateur,

        onRefreshNotes: _loadNotes,

        onLogout: _logout,

      ),

      appBar: AppBar(

        centerTitle: true,

        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Rechercher une note...",
            border: InputBorder.none,
          ),
          onChanged: _filterNotes,
        ) : const Text(
          "Liste des notes",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),

        actions: [

          if (!_isSearching)

            IconButton(

              icon: const Icon(Icons.search),

              onPressed: () {

                setState(() {

                  _isSearching = true;

                });

              },

            ),

          if (_isSearching)

            IconButton(

              icon: const Icon(Icons.close),

              onPressed: () {

                _searchController.clear();

                _filterNotes("");

                setState(() {

                  _isSearching = false;

                });

              },

            ),

        ],
        leading: _isSearching

            ? IconButton(

          icon: const Icon(Icons.arrow_back),

          onPressed: () {

            _searchController.clear();

            _filterNotes("");

            setState(() {

              _isSearching = false;

            });

          },

        )

            : null,
        /*
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

         */
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

      //itemCount: _notes.length,
      itemCount: _filteredNotes.length,

      itemBuilder: (context, index) {

        //final note = _notes[index];
        final note = _filteredNotes[index];

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
          onDelete: () {

            _deleteNote(note);

          },

          /*
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
          },*/

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