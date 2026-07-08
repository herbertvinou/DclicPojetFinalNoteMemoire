import 'package:flutter/material.dart';
import 'package:note_memoire/modele/utilisateur.dart';

import '../../core/validators/Validators.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
//import '../../core/validators/validators.dart';
import '../../modele/note.dart';
import '../../services/note_service.dart';


class AddNotePage extends StatefulWidget {
  final Utilisateur utilisateur;
  const AddNotePage({
    super.key,
    required this.utilisateur,
  });

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {

  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();

  final _contentController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _clearFields() {

    _titleController.clear();

    _contentController.clear();

    FocusScope.of(context).unfocus();

  }

  Future<void> _saveNote() async {

    setState(() {

      _loading = true;

    });

    try {

      final note = Note(

        title: _titleController.text.trim(),

        content: _contentController.text.trim(),

        createdAt: DateTime.now(),

        updatedAt: DateTime.now(),

        completed: false,

        idUtilisateur: widget.utilisateur.idUtilisateur!,

      );

      await NoteService.instance.createNote(note);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Note enregistrée avec succès.",
          ),

        ),

      );

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: const CustomAppBar(
        title: "Ajout de note",
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Form(

            key: _formKey,

            child: Column(

              children: [

                Image.asset(
                  "assets/images/add_note.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                Padding(

                  padding: const EdgeInsets.all(24),

                  child: Column(

                    children: [

                      CustomTextField(

                        controller: _titleController,

                        label: "Titre",

                        icon: Icons.note_add_outlined,

                        validator: (value) =>
                            Validators.requiredField(value, "le titre"),

                      ),

                      CustomTextField(

                        controller: _contentController,

                        label: "Contenu",

                        icon: Icons.edit_note,

                        maxLines: 5,

                        validator: (value) =>
                            Validators.requiredField(value, "le contenu"),

                      ),

                      const SizedBox(height: 24),

                      Column(
                        children: [

                          CustomButton(
                            text: "Ajouter la note",
                            icon: Icons.note_add_rounded,
                            loading: _loading,
                            onPressed: _saveNote,
                          ),

                          const SizedBox(height: 16),

                          CustomButton(
                            text: "Ajouter une autre",
                            icon: Icons.post_add_rounded,
                            type: ButtonType.outlined,
                            onPressed: _clearFields,
                          ),

                        ],
                      ),

                      /*
                      Row(

                        children: [

                          Expanded(

                            child: CustomButton(

                              text: "Ajouter",

                              loading: _loading,

                              onPressed: _saveNote,

                            ),

                          ),

                          const SizedBox(width: 16),

                          Expanded(

                            child: CustomButton(

                              text: "Effacer",

                              loading: false,

                              type: ButtonType.outlined,

                              onPressed: _clearFields,

                            ),

                          ),

                        ],

                      ),
                      */

                    ],

                  ),

                )

              ],

            ),

          ),

        ),

      ),

    );

  }

}