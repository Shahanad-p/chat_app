import 'package:chat_app/model/model.dart';
import 'package:chat_app/service/service.dart';
import 'package:chat_app/view/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final TextEditingController textController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  //sign out
  void signOut() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  //post message
  postMessage() async {
    //only post if there is something in the textfield
    if (textController.text.isNotEmpty) {
      await _firestoreService.postMessage(
          currentUser.email!, textController.text);
      textController.clear();
      notifyListeners();
    }
  }

  Stream<List<UserPostModel>> get userPostsStream =>
      _firestoreService.streamUserPosts();

  void goToProfilePage(context) {
    Navigator.pop(context);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ProfileScreen()));
    notifyListeners();
  }
}
