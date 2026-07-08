import '../database/database_constants.dart';
import '../modele/note.dart';
import 'base_service.dart';

class NoteService extends BaseService {

  NoteService._();

  static final NoteService instance = NoteService._();

  //----------------------------------
  // Ajouter une note
  //----------------------------------

  Future<int> createNote(Note note) async {

    return await repository.insert(

      NoteTable.table,

      note.toMap(),

    );

  }


  //----------------------------------
  // Modifier une note
  //----------------------------------

  Future<void> updateNote(Note note) async {

    await repository.update(

      NoteTable.table,

      note.toMap(),

      NoteTable.id,

      note.idNote!,

    );

  }


  //----------------------------------
  // Supprimer une note
  //----------------------------------

  Future<void> deleteNote(int idNote) async {

    await repository.delete(

      NoteTable.table,

      NoteTable.id,

      idNote,

    );

  }



  //----------------------------------
  // Récupérer une note
  //----------------------------------

  Future<Note?> getNoteById(int id) async {
    throw UnimplementedError();
  }

  //----------------------------------
  // Toutes les notes d'un utilisateur
  //----------------------------------

  Future<List<Note>> getNotesByUser(int userId) async {

    final result = await repository.findWhere(

      NoteTable.table,

      "${NoteTable.userId} = ?",

      [userId],

    );

    return result

        .map((map) => Note.fromMap(map))

        .toList();

  }


  //----------------------------------
  // Rechercher une note
  //----------------------------------

  Future<List<Note>> searchNotes(
      int userId,
      String keyword,
      ) async {
    throw UnimplementedError();
  }

  //----------------------------------
  // Marquer Terminée / Non Terminée
  //----------------------------------

  Future<int> toggleCompleted(Note note) async {
    throw UnimplementedError();
  }

}