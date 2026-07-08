import 'package:flutter/material.dart';
import '../../exceptions/auth_exception.dart';
import '../../services/auth_service.dart';
import '../home/home.dart';
import 'inscription.dart';
import '../../modele/utilisateur.dart';

class Connexion extends StatefulWidget {
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  String? _loginError;
  /*
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

   */

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
          "Connexion",
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
                  'assets/images/connexion.png',
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
              "Connectez-vous pour accéder à vos notes",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //------------------------------------


                    //Champ utilisateur------------------------------------------------------!!
                    TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,

                      validator: (value) {

                        if (value == null || value.trim().isEmpty) {
                          return "Veuillez saisir votre nom d'utilisateur.";
                        }

                        if (value.length < 3) {
                          return "Nom d'utilisateur trop court.";
                        }

                        return null;
                      },

                      decoration: InputDecoration(

                        labelText: "Nom d'utilisateur",

                        prefixIcon: const Icon(Icons.person_outline),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Colors.deepPurple,
                            width: 2,
                          ),
                        ),

                      ),
                    ),

                    SizedBox(height: 8.0),
                    //Champ mot de passe------------------------------------------------------!!
                    TextFormField(

                      controller: _passwordController,

                      obscureText: _obscurePassword,

                      textInputAction: TextInputAction.done,

                      validator: (value) {

                        if (value == null || value.isEmpty) {
                          return "Veuillez saisir votre mot de passe.";
                        }

                        if (value.length < 8) {
                          return "Le mot de passe doit contenir au moins 8 caractères.";
                        }

                        return null;
                      },

                      decoration: InputDecoration(

                        labelText: "Mot de passe",

                        prefixIcon: const Icon(Icons.lock_outline),

                        suffixIcon: IconButton(

                          icon: Icon(

                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,

                          ),

                          onPressed: () {

                            setState(() {

                              _obscurePassword = !_obscurePassword;

                            });

                          },

                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),

                      ),

                    ),

                    SizedBox(height: 8.0),
                    // se souvenir de moi et motde passe oublié=======================
                    Row(
                      children: [

                        Expanded(

                          child: Row(

                            children: [

                              Checkbox(

                                value: _rememberMe,

                                onChanged: (value) {

                                  setState(() {

                                    _rememberMe = value!;

                                  });

                                },

                              ),

                              Expanded(

                                child: Text(
                                  "Se souvenir de moi",
                                  //overflow: TextOverflow.ellipsis,
                                ),

                              )

                            ],

                          ),


                          // Bouton de connexion=====================





                        ),

                        TextButton(

                          onPressed: () {},

                          child: const Text(
                            "Mot de passe oublié ?",
                          ),

                        )

                      ],

                    ),

                    if (_loginError != null)

                      Container(

                        margin: const EdgeInsets.only(top: 15),

                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(

                          color: Colors.red.shade50,

                          borderRadius: BorderRadius.circular(12),

                          border: Border.all(
                            color: Colors.red.shade300,
                          ),

                        ),

                        child: Row(

                          children: [

                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),

                            const SizedBox(width: 10),

                            Expanded(

                              child: Text(
                                _loginError!,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),

                            )

                          ],

                        ),

                      ),
                    SizedBox(height: 8.0),
                    ///Bouton de connexion-------------------------------------------
                    SizedBox(

                      width: double.infinity,

                      height: 55,

                      child: ElevatedButton(

                        onPressed: _isLoading
                            ? null
                            : _login,


                        style: ElevatedButton.styleFrom(

                          backgroundColor: Colors.deepPurple,

                          foregroundColor: Colors.white,

                          shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(30),

                          ),

                        ),

                        child: _isLoading

                            ? const SizedBox(

                          height: 22,

                          width: 22,

                          child: CircularProgressIndicator(

                            color: Colors.white,

                            strokeWidth: 3,

                          ),

                        )

                            : const Text(

                          "Se connecter",

                          style: TextStyle(

                            fontSize: 18,

                          ),

                        ),

                      ),

                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Text(
                          "Pas encore de compte ?",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),

                        TextButton(
                          onPressed: () {

                            /**/
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  Inscription(),
                          ),
                        );



                          },
                          child: const Text(
                            "S'inscrire",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //------------------------------------
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _login() async {

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loginError = null;
      _isLoading = true;
    });

    try {

      final utilisateur = await AuthService.instance.login(

        username: _usernameController.text.trim(),

        password: _passwordController.text,

      );

      if (!mounted) return;

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) => Home(

            utilisateur: utilisateur,

          ),

        ),

      );

    }

    on AuthException catch (e) {

      if (!mounted) return;

      setState(() {

        _loginError = e.message;

      });

    }

    catch (e) {

      if (!mounted) return;

      setState(() {

        _loginError = e.toString();

      });

    }

    finally {

      if (mounted) {

        setState(() {

          _isLoading = false;

        });

      }

    }

  }
}
