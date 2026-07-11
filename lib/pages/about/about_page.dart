import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../widgets/custom_app_bar.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  String _version = "";

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {

    final info = await PackageInfo.fromPlatform();

    setState(() {

      _version = info.version;

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: const CustomAppBar(

        title: "À propos",

      ),

      /*
      body: const Center(

        child: CircularProgressIndicator(),

      ),

       */
      body: SingleChildScrollView(

        padding: const EdgeInsets.all(24),

        child: Column(

          children: [

            const SizedBox(height: 10),

            Image.asset(
              "assets/images/icone.png",
              width: 100,
            ),

            const SizedBox(height: 20),

            const Text(

              "NOTE MÉMOIRE",

              style: TextStyle(

                fontSize: 28,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 8),

            Text(

              "Version $_version",

              style: const TextStyle(

                color: Colors.grey,

                fontSize: 18,

              ),

            ),

            const SizedBox(height: 30),

            Card(

              elevation: 2,

              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(20),

              ),

              child: const Padding(

                padding: EdgeInsets.all(20),

                child: Text(

                  "Votre compagnon numérique pour organiser vos idées, vos notes et vos tâches du quotidien.",

                  textAlign: TextAlign.center,

                  style: TextStyle(

                    fontSize: 17,

                    height: 1.5,

                  ),

                ),

              ),

            ),

            const SizedBox(height: 30),

            _buildSectionTitle("Fonctionnalités"),

            const SizedBox(height: 15),

            _feature(Icons.check_circle, "Ajouter des notes"),

            _feature(Icons.check_circle, "Modifier des notes"),

            _feature(Icons.check_circle, "Supprimer des notes"),

            _feature(Icons.check_circle, "Recherche instantanée"),

            _feature(Icons.check_circle, "Fonctionnement hors connexion"),

            _feature(Icons.check_circle, "Compatible Android • iOS • Web"),

            const SizedBox(height: 30),

            _buildSectionTitle("Technologies"),

            const SizedBox(height: 15),

            _feature(Icons.flutter_dash, "Flutter"),

            _feature(Icons.storage, "SQLite"),

            _feature(Icons.palette_outlined, "Material Design 3"),

            const SizedBox(height: 35),

            const Divider(),

            const SizedBox(height: 15),

            const Text(

              "Développé par",

              style: TextStyle(

                color: Colors.grey,

              ),

            ),

            const SizedBox(height: 8),

            const Text(

              "Herbert Vinou",

              style: TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 10),

            const Text(

              "© 2026",

              style: TextStyle(

                color: Colors.grey,

              ),

            ),

            const SizedBox(height: 20),

          ],

        ),

      ),

    );

  }

  Widget _buildSectionTitle(String title) {

    return Align(

      alignment: Alignment.centerLeft,

      child: Text(

        title,

        style: const TextStyle(

          fontSize: 22,

          fontWeight: FontWeight.bold,

        ),

      ),

    );

  }

  Widget _feature(IconData icon, String text) {

    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 6),

      child: Row(

        children: [

          Icon(

            icon,

            color: Colors.deepPurple,

          ),

          const SizedBox(width: 12),

          Expanded(

            child: Text(

              text,

              style: const TextStyle(

                fontSize: 17,

              ),

            ),

          ),

        ],

      ),

    );

  }

}