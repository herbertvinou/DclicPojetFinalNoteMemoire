class Validators {

  Validators._();

  static String? requiredField(
      String? value,
      String field,
      ) {

    if (value == null || value.trim().isEmpty) {
      return "Veuillez saisir $field.";
    }

    return null;
  }

  static String? email(String? value) {

    if (value == null || value.trim().isEmpty) {
      return "Veuillez saisir votre adresse e-mail.";
    }

    final regex = RegExp(
      r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!regex.hasMatch(value.trim())) {
      return "Adresse e-mail invalide.";
    }

    return null;
  }

  static String? password(String? value) {

    if (value == null || value.isEmpty) {
      return "Veuillez saisir votre mot de passe.";
    }

    if (value.length < 8) {
      return "Le mot de passe doit contenir au moins 8 caractères.";
    }

    return null;
  }

  static String? confirmPassword(
      String? value,
      String password,
      ) {

    if (value == null || value.isEmpty) {
      return "Veuillez confirmer votre mot de passe.";
    }

    if (value != password) {
      return "Les mots de passe ne correspondent pas.";
    }

    return null;
  }
}