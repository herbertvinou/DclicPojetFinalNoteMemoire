import '../database/database_constants.dart';
import 'base_model.dart';

class Note extends BaseModel<Note> {

  final int? idNote;

  final String title;

  final String content;

  final DateTime createdAt;

  final DateTime updatedAt;

  final bool completed;

  /// Clé étrangère
  final int idUtilisateur;

  Note({

    this.idNote,

    required this.title,

    required this.content,

    required this.createdAt,

    required this.updatedAt,

    required this.completed,

    required this.idUtilisateur,

  });

  //--------------------------------------------------
  // Conversion Objet -> SQLite
  //--------------------------------------------------

  @override
  Map<String, dynamic> toMap() {

    return {

      NoteTable.id: idNote,

      NoteTable.title: title,

      NoteTable.content: content,

      NoteTable.createdAt: createdAt.toIso8601String(),

      NoteTable.updatedAt: updatedAt.toIso8601String(),

      NoteTable.completed: completed ? 1 : 0,

      NoteTable.userId: idUtilisateur,

    };

  }

  bool get isCompleted => completed;
  //--------------------------------------------------
  // Conversion SQLite -> Objet
  //--------------------------------------------------

  factory Note.fromMap(Map<String, dynamic> map) {

    return Note(

      idNote: map[NoteTable.id],

      title: map[NoteTable.title],

      content: map[NoteTable.content],

      createdAt: DateTime.parse(map[NoteTable.createdAt]),

      updatedAt: DateTime.parse(map[NoteTable.updatedAt]),

      completed: map[NoteTable.completed] == 1,

      idUtilisateur: map[NoteTable.userId],

    );

  }

  //--------------------------------------------------
  // Copier un objet
  //--------------------------------------------------

  Note copyWith({

    int? idNote,

    String? title,

    String? content,

    DateTime? createdAt,

    DateTime? updatedAt,

    bool? completed,

    int? idUtilisateur,

  }) {

    return Note(

      idNote: idNote ?? this.idNote,

      title: title ?? this.title,

      content: content ?? this.content,

      createdAt: createdAt ?? this.createdAt,

      updatedAt: updatedAt ?? this.updatedAt,

      completed: completed ?? this.completed,

      idUtilisateur: idUtilisateur ?? this.idUtilisateur,

    );

  }

  //--------------------------------------------------
  // Affichage
  //--------------------------------------------------

  @override
  String toString() {

    return '''

Note(

 idNote: $idNote,

 title: $title,

 content: $content,

 createdAt: $createdAt,

 updatedAt: $updatedAt,

 completed: $completed,

 idUtilisateur: $idUtilisateur

)

''';

  }

  //--------------------------------------------------
  // Comparaison
  //--------------------------------------------------

  @override
  bool operator ==(Object other) {

    if (identical(this, other)) return true;

    return other is Note &&
        other.idNote == idNote &&
        other.title == title &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.completed == completed &&
        other.idUtilisateur == idUtilisateur;

  }

  @override
  int get hashCode {

    return Object.hash(

      idNote,

      title,

      content,

      createdAt,

      updatedAt,

      completed,

      idUtilisateur,

    );

  }
  //--------------------------------------------------
// Marquer terminée / non terminée
//--------------------------------------------------

  Note markCompleted(bool value) {

    return copyWith(

      completed: value,

      updatedAt: DateTime.now(),

    );

  }

}