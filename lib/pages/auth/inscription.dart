import 'package:flutter/material.dart';

import '../../exceptions/auth_exception.dart';
import '../../modele/utilisateur.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_password_field.dart';
import '../../widgets/custom_text_field.dart';

class Inscription extends StatefulWidget {
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  /// les controleurs----------------------------------------------------!!!
  final _nomController = TextEditingController();

  final _prenomController = TextEditingController();

  final _emailController = TextEditingController();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  ///Les variables----------------------------------------------------!!!

  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  bool _obscureConfirmPassword = true;

  bool _acceptConditions = false;

  bool _loading = false;

  //String? _registerError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "S'inscrire",
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        /*
        title: Image.asset(
          "assets/images/icone.png",
          height: 40,
        ),

         */
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(
                  'assets/images/icone.png',
                ),
              ),
            ),

            /*
            Image.asset(
              "assets/images/connexion.png",
              //width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),

             */

            const SizedBox(height: 20),

            const Text(
              "Inscrivez-vous pour accéder à Note Mémoire ",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children:[

                    /// Nom
                    CustomTextField(
                      controller: _nomController,
                      label: "Nom",
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Veuillez saisir votre nom.";
                        }
                        return null;
                      },
                    ),

                    //const SizedBox(height: 16),

                    /// Prénom
                    CustomTextField(
                      controller: _prenomController,
                      label: "Prénom",
                      icon: Icons.badge_outlined,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Veuillez saisir votre prénom.";
                        }
                        return null;
                      },
                    ),

                    //const SizedBox(height: 16),

                    /// Adresse e-mail
                    CustomTextField(
                      controller: _emailController,
                      label: "Adresse e-mail",
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {

                        if (value == null || value.trim().isEmpty) {
                          return "Veuillez saisir votre adresse e-mail.";
                        }

                        final emailRegex = RegExp(
                          r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$',
                        );

                        if (!emailRegex.hasMatch(value.trim())) {
                          return "Adresse e-mail invalide.";
                        }

                        return null;
                      },
                    ),

                    //const SizedBox(height: 16),

                    /// Nom d'utilisateur
                    CustomTextField(
                      controller: _usernameController,
                      label: "Nom d'utilisateur",
                      icon: Icons.account_circle_outlined,
                      validator: (value) {

                        if (value == null || value.trim().isEmpty) {
                          return "Veuillez saisir un nom d'utilisateur.";
                        }

                        if (value.trim().length < 3) {
                          return "Le nom d'utilisateur doit contenir au moins 3 caractères.";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    /// Mot de passe
                    CustomPasswordField(
                      controller: _passwordController,
                      label: "Mot de passe",
                      obscureText: _obscurePassword,
                      onVisibilityChanged: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      validator: (value) {

                        if (value == null || value.isEmpty) {
                          return "Veuillez saisir un mot de passe.";
                        }

                        if (value.length < 8) {
                          return "Le mot de passe doit contenir au moins 8 caractères.";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    /// Confirmation du mot de passe
                    CustomPasswordField(
                      controller: _confirmPasswordController,
                      label: "Confirmer le mot de passe",
                      obscureText: _obscureConfirmPassword,
                      onVisibilityChanged: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      validator: (value) {

                        if (value == null || value.isEmpty) {
                          return "Veuillez confirmer votre mot de passe.";
                        }

                        if (value != _passwordController.text) {
                          return "Les mots de passe ne correspondent pas.";
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [

                        Expanded(
                          child: CustomButton(
                            text: "Retour",
                            loading: false,
                            type: ButtonType.outlined,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: CustomButton(
                            text: "S'inscrire",
                            loading: _loading,
                            type: ButtonType.filled,
                            onPressed: _register,
                            //onPressed: (){}/*register*/,
                          ),
                        ),

                      ],

                    ),
                    const SizedBox(height: 16),


                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }


  /// pour bouton S'inscrire-----------

  Future<void> _register() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {

      final utilisateur = Utilisateur(

        nom: _nomController.text.trim(),

        prenom: _prenomController.text.trim(),

        email: _emailController.text.trim(),

        username: _usernameController.text.trim(),

        password: _passwordController.text,

      );

      await AuthService.instance.register(utilisateur);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text("Inscription réussie."),

        ),

      );

      Navigator.pop(context);

    }

    on AuthException catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(e.message),

        ),

      );

    }

    catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(e.toString()),

        ),

      );

    }

    finally {

      if (mounted) {

        setState(() {
          _loading = false;
        });

      }

    }

  }
  /*
  Future<void> _register() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final utilisateur = Utilisateur(

      nom: _nomController.text.trim(),

      prenom: _prenomController.text.trim(),

      email: _emailController.text.trim(),

      username: _usernameController.text.trim(),

      password: _passwordController.text,

    );

    try {

      await AuthService.instance.register(utilisateur);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text("Inscription réussie."),

        ),

      );

      Navigator.pop(context);

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(


        SnackBar(

          content: Text(e.toString()),

        ),

      );

    }

  }

   */



}
