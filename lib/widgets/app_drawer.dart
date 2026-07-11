import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/helpers/snackbar_helper.dart';
import '../modele/utilisateur.dart';
import '../pages/about/about_page.dart';
import '../pages/notes/add_note.dart';
import 'drawer_menu_item.dart';

class AppDrawer extends StatelessWidget {

  final Utilisateur utilisateur;
  final VoidCallback? onNoteAdded;

  final Future<void> Function()? onRefreshNotes;
  final VoidCallback? onLogout;

  const AppDrawer({

    super.key,

    required this.utilisateur,
    this.onNoteAdded,

    this.onRefreshNotes,

    this.onLogout,


  });

  @override
  Widget build(BuildContext context) {

    return Drawer(

      child: Column(

        children: [

          _buildHeader(),

          Expanded(

            child: ListView(

              padding: EdgeInsets.zero,

              children: [

                DrawerMenuItem(

                  icon: Icons.home_outlined,

                  title: "Accueil",

                  selected: true,

                  onTap: () {

                    Navigator.pop(context);

                  },

                ),

                DrawerMenuItem(

                  icon: Icons.note_alt_outlined,

                  //title: "Mes notes",
                  title: "Export PDF",

                  onTap: () {

                    Navigator.pop(context);
                    SnackBarHelper.info(
                      context,
                      "Fonction disponible dans une prochaine version.",
                    );

                  },

                ),

                DrawerMenuItem(

                  icon: Icons.note_add_outlined,

                  title: "Ajouter une note",

                  onTap: () async {

                    Navigator.pop(context);

                    final refresh = await Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) => AddNotePage(

                          utilisateur: utilisateur,

                        ),

                      ),

                    );

                    if (refresh == true) {
                      // a améliorer  après.
                      await onRefreshNotes?.call();
                    }

                  },

                ),
                const Divider(),

                DrawerMenuItem(

                  icon: Icons.settings_outlined,

                  title: "Paramètres",

                  onTap: () {

                    Navigator.pop(context);
                    SnackBarHelper.info(
                      context,
                      "Fonction disponible dans une prochaine version.",
                    );

                  },

                ),

                DrawerMenuItem(

                  icon: Icons.info_outline,

                  title: "À propos",

                  onTap: () {

                    Navigator.pop(context);
                    Navigator.push(

                      context,

                      MaterialPageRoute(
                        builder: (_) => const AboutPage(),
                      ),

                    );

                  },

                ),

                const Divider(),

                DrawerMenuItem(

                  icon: Icons.logout,

                  title: "Déconnexion",

                  onTap: () {

                    Navigator.pop(context);

                    onLogout?.call();

                  },

                ),

              ],
              /*
              children: const [

              ],
               */


            ),

          ),

        ],

      ),

    );
    /*
    return Drawer(


      child: ListView(

        padding: EdgeInsets.zero,

        children: [

          UserAccountsDrawerHeader(

            decoration: const BoxDecoration(

              color: AppColors.primary,

            ),

            currentAccountPicture: CircleAvatar(

              backgroundColor: Colors.white,

              child: Text(

                _initiales(),

                style: const TextStyle(

                  fontSize: 28,

                  fontWeight: FontWeight.bold,

                  color: AppColors.primary,

                ),

              ),

            ),

            accountName: Text(

              utilisateur.username,

              style: const TextStyle(

                fontWeight: FontWeight.bold,

                fontSize: 18,

              ),

            ),

            accountEmail: Text(

              utilisateur.email,

            ),

          ),

        ],

      ),

    );
    */

  }

  String _initiales() {

    return utilisateur.username
        .substring(0, 2)
        .toUpperCase();

  }


  //----------------------------------
  //
  //----------------------------------
  Widget _buildHeader() {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.only(

        top: 55,

        left: 20,

        right: 20,

        bottom: 25,

      ),

      decoration: const BoxDecoration(

        gradient: LinearGradient(

          colors: [

            Color(0xFF6750A4),

            Color(0xFF342C42),

          ],

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,

        ),

        borderRadius: BorderRadius.only(

          bottomLeft: Radius.circular(5),

          bottomRight: Radius.circular(5),

        ),

      ),

      child: Row(

        children: [

          CircleAvatar(

            radius: 35,

            backgroundColor: Colors.white24,

            child: Text(

              _initiales(),

              style: const TextStyle(

                color: Colors.white,

                fontSize: 28,

                fontWeight: FontWeight.bold,

              ),

            ),

          ),

          const SizedBox(width: 20),

          Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(

                  utilisateur.username,

                  style: const TextStyle(

                    color: Colors.white,

                    fontSize: 24,

                    fontWeight: FontWeight.bold,

                  ),

                ),

                const SizedBox(height: 6),

                Text(

                  utilisateur.email,

                  style: const TextStyle(

                    color: Colors.white70,

                    fontSize: 16,

                  ),

                ),

              ],

            ),

          ),

        ],

      ),

    );

  }

}