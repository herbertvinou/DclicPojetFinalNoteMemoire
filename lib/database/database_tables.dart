import 'database_constants.dart';

class DatabaseTables {
  DatabaseTables._();


  static String createUtilisateurTable = '''
    CREATE TABLE ${UserTable.table}(
        
        ${UserTable.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        
        ${UserTable.nom} TEXT NOT NULL,
        
        ${UserTable.prenom} TEXT NOT NULL,
        
        ${UserTable.email} TEXT NOT NULL UNIQUE,
        
        ${UserTable.username} TEXT NOT NULL UNIQUE,
        
        ${UserTable.password} TEXT NOT NULL
    )
  ''';

  static String createNoteTable = '''
    CREATE TABLE ${NoteTable.table}(
      
      ${NoteTable.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      
      ${NoteTable.title} TEXT NOT NULL,
      
      ${NoteTable.content} TEXT NOT NULL,
      
      ${NoteTable.createdAt} TEXT NOT NULL,
      
      ${NoteTable.updatedAt} TEXT NOT NULL,
      
      ${NoteTable.completed} INTEGER NOT NULL DEFAULT 0,
      
      ${NoteTable.userId} INTEGER NOT NULL,
      
      FOREIGN KEY(${NoteTable.userId})
      
      REFERENCES ${UserTable.table}(${UserTable.id})
      
      ON DELETE CASCADE  
    )
  ''';
}