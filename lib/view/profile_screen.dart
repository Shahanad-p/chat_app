// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/widget/texts_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  //all users
  final userCollection = FirebaseFirestore.instance.collection('Users');

  //edit field
  Future<void> editFields(String fields) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Edit $fields',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter new $fields',
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          TextButton(
            onPressed: () async {
              if (newValue.trim().isNotEmpty) {
                //only update if there is something in the textfield
                await userCollection
                    .doc(currentUser.email)
                    .update({fields: newValue});
                setState(() {}); // update UI
                Navigator.of(context).pop();
              }
            },
            child: Text(
              'Save',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          //get the user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
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
                  'My details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                //username
                MyTextBox(
                  text: userData['username'],
                  sectionName: 'Username',
                  onPressed: () =>
                      editFields('username'), // changed to lowercase
                ),
                //bio
                SizedBox(height: 20),
                MyTextBox(
                  text: userData['bio'],
                  sectionName: ' Bio',
                  onPressed: () => editFields('bio'), // changed to lowercase
                ),
                //user posts
                SizedBox(height: 20),
                Text(
                  'My post',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error:${snapshot.error}'));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
