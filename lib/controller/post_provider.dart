import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  final TextEditingController commentTextController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  int commentCount = 0;
  void toggleLike(widget) {
    isLiked = !isLiked;

    //access the document in firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User posts').doc(widget.postId);

    if (isLiked) {
      //if the post is now liked then add the users email to the 'likes field'
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
      notifyListeners();
    } else {
      //if the post is now unliked, remove the users email  from the 'likes field'
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
      notifyListeners();
    }
    notifyListeners();
  }

  //add comment
  void addComment(String commentText, widget) {
    FirebaseFirestore.instance
        .collection('User posts')
        .doc(widget.postId)
        .collection('Comments')
        .add({
      'CommentText': commentText,
      'CommentedBy': currentUser.email,
      'CommentTime': Timestamp.now(),
    }).then((value) => fetchCommentCount(widget));
    notifyListeners();
  }

  //update the comment count
  void fetchCommentCount(dynamic widget) {
    FirebaseFirestore.instance
        .collection('User posts')
        .doc(widget.postId)
        .collection('Comments')
        .get()
        .then((snapshot) {
      commentCount = snapshot.docs.length;
    });
    notifyListeners();
  }

  //show a dialogue box for adding comments
  void showCommentDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add comment'),
        content: TextField(
          controller: commentTextController,
          decoration: InputDecoration(hintText: 'Write a comment..'),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                commentTextController.clear();
              },
              child: Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          TextButton(
            onPressed: () {
              addComment(commentTextController.text, context);
              commentTextController.clear();
              Navigator.pop(context);
              notifyListeners();
            },
            child: Text(
              'Post',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
    notifyListeners();
  }
}
