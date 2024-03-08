import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final TextEditingController textController = TextEditingController();
  //sign out
  void signOut() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  //post message
  postMessage() {
    //only post if there is something in the textfield
    if (textController.text.isNotEmpty) {
      //store in firebase
      FirebaseFirestore.instance.collection('User posts').add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'Timestamb': Timestamp.now(),
        'Likes': [],
      });
      notifyListeners();
    }
    textController.clear();
  }
}
