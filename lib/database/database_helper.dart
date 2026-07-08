import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_constants.dart';
import 'database_tables.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, DatabaseConstants.databaseName);

    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(DatabaseTables.createUtilisateurTable);
    await db.execute(DatabaseTables.createNoteTable);
    await _insertDefaultData(db);


  }


  //--------------------------------------------------
// Données par défaut
//--------------------------------------------------

  Future<void> _insertDefaultData(Database db) async {

    //--------------------------------------
    // Utilisateur par défaut
    //--------------------------------------

    final int userId = await db.insert(

      UserTable.table,

      {

        UserTable.nom: "Administrateur",

        UserTable.prenom: "Demo",

        UserTable.email: "admin@notememoire.com",

        UserTable.username: "admin",

        UserTable.password: "admin123",

      },

    );

    //--------------------------------------
    // Première note
    //--------------------------------------

    await db.insert(

      NoteTable.table,

      {

        NoteTable.title: "Bienvenue dans Note Mémoire",

        NoteTable.content:
        "Merci d'utiliser Note Mémoire.\n\n"
            "Cette application vous permet de créer, modifier et organiser vos notes personnelles.",

        NoteTable.createdAt: DateTime.now().toIso8601String(),

        NoteTable.updatedAt: DateTime.now().toIso8601String(),

        NoteTable.completed: 0,

        NoteTable.userId: userId,

      },

    );

    //--------------------------------------
    // Deuxième note
    //--------------------------------------

    await db.insert(

      NoteTable.table,

      {

        NoteTable.title: "Liste des fonctionnalités",

        NoteTable.content:
        "✔ Ajouter une note\n"
            "✔ Modifier une note\n"
            "✔ Supprimer une note\n"
            "✔ Recherche des notes (à venir)\n"
            "✔ Export PDF (à venir)",

        NoteTable.createdAt: DateTime.now().toIso8601String(),

        NoteTable.updatedAt: DateTime.now().toIso8601String(),

        NoteTable.completed: 1,

        NoteTable.userId: userId,

      },

    );

  }
}
