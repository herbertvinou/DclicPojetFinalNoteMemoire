import 'package:flutter/material.dart';

import '../../core/validators/Validators.dart';
import '../../modele/note.dart';
import '../../modele/utilisateur.dart';
import '../../services/note_service.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class NoteDetailsPage extends StatefulWidget {

  /*
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;
  final bool completed;

   */

  final Utilisateur utilisateur;

  final Note note;

  const NoteDetailsPage({

    super.key,

    required this.utilisateur,

    required this.note,

  });
  /*
  const NoteDetailsPage({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.completed,
  });

   */

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _contentController;

  bool _loading = false;

  bool _isEditing = false;

  late bool _completed;

  @override
  void initState() {
    super.initState();

    /*
    _titleController = TextEditingController(text: widget.title);

    _contentController = TextEditingController(text: widget.content);

    _completed = widget.completed;
    */

    _titleController = TextEditingController(
      text: widget.note.title,
    );

    _contentController = TextEditingController(
      text: widget.note.content,
    );

    _completed = widget.note.completed;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {

      final note = widget.note.copyWith(

        title: _titleController.text.trim(),

        content: _contentController.text.trim(),

        updatedAt: DateTime.now(),

        completed: _completed,

      );

      await NoteService.instance.updateNote(note);

      if (!mounted) return;

      Navigator.pop(context, true);

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(e.toString()),
        ),

      );

    } finally {

      if (mounted) {

        setState(() {

          _loading = false;

        });

      }

    }

  }
  Future<void> _deleteNote() async {

    final confirm = await showDialog<bool>(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            "Supprimer la note",
          ),

          content: const Text(
            "Voulez-vous vraiment supprimer cette note ?",
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

    if (confirm != true) {
      return;
    }

    try {

      await NoteService.instance.deleteNote(

        widget.note.idNote!,

      );

      if (!mounted) return;

      Navigator.pop(context, true);

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(e.toString()),

        ),

      );

    }

  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    /// TODO
    /// UPDATE SQLite

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _loading = false;
      _isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("La note a été modifiée avec succès.")),
    );
  }

  void _enableEdition() {
    setState(() {
      _isEditing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Détail de la note"),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,

            child: Column(
              children: [
                Image.asset(
                  "assets/images/detailnote.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                Padding(
                  padding: const EdgeInsets.all(24),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "📅 Créée le : ${widget.note.createdAt}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              value: _completed,

                              contentPadding: EdgeInsets.zero,

                              title: const Text("Note terminée"),

                              controlAffinity: ListTileControlAffinity.leading,

                              onChanged: _isEditing
                                  ? (value) {
                                      setState(() {
                                        _completed = value!;
                                      });
                                    }
                                  : null,
                            ),
                          ),

                          Text(
                            //"ID : ${widget.id}",
                            "ID : ${widget.note.idNote}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        controller: _titleController,

                        label: "Titre",

                        icon: Icons.note_alt_outlined,

                        readOnly: !_isEditing,

                        validator: (value) =>
                            Validators.requiredField(value, "le titre"),
                      ),

                      CustomTextField(
                        controller: _contentController,

                        label: "Contenu",

                        icon: Icons.notes_outlined,

                        maxLines: 6,

                        readOnly: !_isEditing,

                        validator: (value) =>
                            Validators.requiredField(value, "le contenu"),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        "🕒 Dernière modification : ${widget.note.updatedAt}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 30),
                      //const SizedBox(height: 30),

                      // parti2
                      _isEditing
                      ? CustomButton(
                          text: "Enregistrer",
                          icon: Icons.save_rounded,
                          loading: _loading,
                          //onPressed: _saveChanges,
                          onPressed: _saveNote,//_saveNote
                        )
                      : CustomButton(
                          text: "Modifier",
                          icon: Icons.edit_rounded,
                          onPressed: _enableEdition,
                        ),
                        const SizedBox(height: 15),

                      CustomButton(

                        text: "Supprimer",

                        icon: Icons.delete,

                        type: ButtonType.outlined,

                        onPressed: _deleteNote,

                      ),


                      const SizedBox(height: 16),

                      CustomButton(
                        text: "Retour",
                        icon: Icons.arrow_back_rounded,
                        type: ButtonType.outlined,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
