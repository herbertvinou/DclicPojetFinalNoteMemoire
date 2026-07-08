import '../database/database_constants.dart';
import '../exceptions/auth_exception.dart';
import '../modele/utilisateur.dart';
import 'base_service.dart';

class AuthService extends BaseService {

  AuthService._();

  static final AuthService instance = AuthService._();

  //----------------------------------
  // Inscription
  //----------------------------------

  Future<int> register(Utilisateur utilisateur) async {

    // Vérifier que le nom d'utilisateur est disponible
    if (await usernameExists(utilisateur.username)) {
      throw const AuthException(
        "Ce nom d'utilisateur est déjà utilisé.",
      );
    }

    // Vérifier que l'adresse e-mail est disponible
    if (await emailExists(utilisateur.email)) {
      throw const AuthException(
        "Cette adresse e-mail est déjà utilisée.",
      );
    }

    // Plus tard : chiffrement du mot de passe
    final utilisateurToSave = utilisateur;

    final id = await repository.insert(
      UserTable.table,
      utilisateurToSave.toMap(),
    );

    return id;
    //Future<Utilisateur>;
  }

  /*
  Future<int> register(Utilisateur utilisateur) async {
    throw UnimplementedError();
  }

   */

  //----------------------------------
  // Connexion
  //----------------------------------


  Future<Utilisateur> login({

    required String username,

    required String password,

  }) async {

    //------------------------------------------------
    // Rechercher l'utilisateur
    //------------------------------------------------

    final userMap = await repository.findOne(

      UserTable.table,

      "${UserTable.username} = ?",

      [username],

    );

    //------------------------------------------------
    // Utilisateur introuvable
    //------------------------------------------------

    if (userMap == null) {

      throw const AuthException(

        "Nom d'utilisateur ou mot de passe incorrect.",

      );

    }

    //------------------------------------------------
    // Conversion Map -> Objet
    //------------------------------------------------

    final utilisateur = Utilisateur.fromMap(userMap);

    //------------------------------------------------
    // Vérification du mot de passe
    //------------------------------------------------

    if (utilisateur.password != password) {

      throw const AuthException(

        "Nom d'utilisateur ou mot de passe incorrect.",

      );

    }

    //------------------------------------------------
    // Succès
    //------------------------------------------------

    return utilisateur;

  }
  /*
  Future<Utilisateur?> login({
    required String username,
    required String password,
  }) async {
    throw UnimplementedError();
  }

   */

  //----------------------------------
  // Vérifier username
  //----------------------------------

  Future<bool> usernameExists(String username) async {

    final result = await repository.findWhere(

      UserTable.table,

      "${UserTable.username} = ?",

      [username],

    );

    return result.isNotEmpty;

  }
  /*
  Future<bool> usernameExists(String username) async {
    throw UnimplementedError();
  }

   */

  //----------------------------------
  // Vérifier email
  //----------------------------------

  Future<bool> emailExists(String email) async {

    final result = await repository.findWhere(

      UserTable.table,

      "${UserTable.email} = ?",

      [email],

    );

    return result.isNotEmpty;

  }

  /*
  Future<bool> emailExists(String email) async {
    throw UnimplementedError();
  }
  */

  //----------------------------------
  // Déconnexion
  //----------------------------------

  Future<void> logout() async {}


  /*
  Future<int> register(Utilisateur utilisateur)
  Future<Utilisateur> login({
    required String username,
    required String password,
  })
  Future<bool> usernameExists(String username)
  Future<bool> emailExists(String email)
  *
   */


}