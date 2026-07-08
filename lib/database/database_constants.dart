class DatabaseConstants {
  DatabaseConstants._();

  static const databaseName = "note_memoire.db";
  static const databaseVersion = 1;
}

class UserTable {
  UserTable._();

  static const table = "utilisateur";
  static const id = "idUtilisateur";
  static const nom = "nom";
  static const prenom = "prenom";
  static const email = "email";
  static const username = "username";
  static const password = "password";
}

class NoteTable {
  NoteTable._();

  static const table = "note";
  static const id = "idNote";
  static const title = "title";
  static const content = "content";
  static const createdAt = "createdAt";
  static const updatedAt = "updatedAt";
  static const completed = "completed";
  static const userId = "idUtilisateur";
}