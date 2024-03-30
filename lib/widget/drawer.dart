import 'package:chat_app/widget/my_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 60.8, bottom: 20.8),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/man.png',
                width: 80,
              ),
            ),
          ),
          MyListTile(
            icon: Icons.home,
            text: 'HOME',
            onTap: () => Navigator.pop(context),
          ),
          MyListTile(
            icon: Icons.person,
            text: 'PROFILE',
            onTap: onProfileTap,
          ),
          MyListTile(
            icon: Icons.logout,
            text: 'LOGOUT',
            onTap: () async {
              await GoogleSignIn().signOut();
              FirebaseAuth.instance.signOut();
              onSignOut;
            },
          )
        ],
      ),
    );
  }
}
