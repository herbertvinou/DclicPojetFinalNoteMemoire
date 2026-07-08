import '../database/database_constants.dart';
import 'base_model.dart';

class Utilisateur extends BaseModel<Utilisateur>{

  final int? idUtilisateur;

  final String nom;

  final String prenom;

  final String email;

  final String username;

  final String password;

  Utilisateur({

    this.idUtilisateur,

    required this.nom,

    required this.prenom,

    required this.email,

    required this.username,

    required this.password,

  });

  //--------------------------------------------------
  // Conversion Objet -> SQLite
  //--------------------------------------------------

  @override
  Map<String, dynamic> toMap() {

    return {

      UserTable.id: idUtilisateur,

      UserTable.nom: nom,

      UserTable.prenom: prenom,

      UserTable.email: email,

      UserTable.username: username,

      UserTable.password: password,

    };

  }

  //--------------------------------------------------
  // Conversion SQLite -> Objet
  //--------------------------------------------------

  factory Utilisateur.fromMap(Map<String, dynamic> map) {

    return Utilisateur(

      idUtilisateur: map[UserTable.id],

      nom: map[UserTable.nom],

      prenom: map[UserTable.prenom],

      email: map[UserTable.email],

      username: map[UserTable.username],

      password: map[UserTable.password],

    );

  }

  //--------------------------------------------------
  // Copier un objet
  //--------------------------------------------------

  Utilisateur copyWith({

    int? idUtilisateur,

    String? nom,

    String? prenom,

    String? email,

    String? username,

    String? password,

  }) {

    return Utilisateur(

      idUtilisateur: idUtilisateur ?? this.idUtilisateur,

      nom: nom ?? this.nom,

      prenom: prenom ?? this.prenom,

      email: email ?? this.email,

      username: username ?? this.username,

      password: password ?? this.password,

    );

  }

  //--------------------------------------------------
  // Affichage de l'objet
  //--------------------------------------------------

  @override
  String toString() {

    return '''
Utilisateur(
 idUtilisateur: $idUtilisateur,
 nom: $nom,
 prenom: $prenom,
 email: $email,
 username: $username
)
''';

  }

  //--------------------------------------------------
  // Comparaison entre objets
  //--------------------------------------------------

  @override
  bool operator ==(Object other) {

    if (identical(this, other)) return true;

    return other is Utilisateur &&
        other.idUtilisateur == idUtilisateur &&
        other.nom == nom &&
        other.prenom == prenom &&
        other.email == email &&
        other.username == username &&
        other.password == password;

  }

  @override
  int get hashCode {

    return Object.hash(

      idUtilisateur,

      nom,

      prenom,

      email,

      username,

      password,

    );

  }

}
/*
import '../database/database_constants.dart';

class Utilisateur {

  final int? idUtilisateur;

  final String nom;

  final String prenom;

  final String email;

  final String username;

  final String password;

  const Utilisateur({

    this.idUtilisateur,

    required this.nom,

    required this.prenom,

    required this.email,

    required this.username,

    required this.password,

  });

  //--------------------------------------------------
  // Convertit un objet Utilisateur vers Map
  //--------------------------------------------------

  Map<String, dynamic> toMap() {

    return {

      UserTable.id: idUtilisateur,

      UserTable.nom: nom,

      UserTable.prenom: prenom,

      UserTable.email: email,

      UserTable.username: username,

      UserTable.password: password,

    };

  }

  //--------------------------------------------------
  // Convertit une Map SQLite vers Utilisateur
  //--------------------------------------------------

  factory Utilisateur.fromMap(
      Map<String, dynamic> map,
      ) {

    return Utilisateur(

      idUtilisateur: map[UserTable.id],

      nom: map[UserTable.nom],

      prenom: map[UserTable.prenom],

      email: map[UserTable.email],

      username: map[UserTable.username],

      password: map[UserTable.password],

    );

  }

  //--------------------------------------------------
  // Copier un objet en modifiant certains champs
  //--------------------------------------------------

  Utilisateur copyWith({

    int? idUtilisateur,

    String? nom,

    String? prenom,

    String? email,

    String? username,

    String? password,

  }) {

    return Utilisateur(

      idUtilisateur: idUtilisateur ?? this.idUtilisateur,

      nom: nom ?? this.nom,

      prenom: prenom ?? this.prenom,

      email: email ?? this.email,

      username: username ?? this.username,

      password: password ?? this.password,

    );

  }

}

 */