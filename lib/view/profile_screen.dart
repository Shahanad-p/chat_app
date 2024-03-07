import 'package:chat_app/view/texts_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //edit field
  Future<void> editFields(String fields) async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          //profile pic
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 226, 220, 220),
              radius: 50,
              child: Image.asset(
                'assets/user.png',
                height: 50,
              ),
            ),
          ),
          SizedBox(height: 10),
          //user email
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          //user details
          Text(
            'User details',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          //usernam
          MyTextBox(
            text: 'shinad',
            sectionName: 'username',
            onPressed: () => editFields('Username'),
          ),
          //bio
          SizedBox(height: 20),
          MyTextBox(
            text: 'bio',
            sectionName: 'empty bio',
            onPressed: () => editFields('Username'),
          ),
          //user posts
          SizedBox(height: 20),
          Text(
            'My pots',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
