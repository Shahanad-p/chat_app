// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class PostProvider extends ChangeNotifier {
//   final TextEditingController commentTextController = TextEditingController();
//   final currentUser = FirebaseAuth.instance.currentUser!;
//   bool isLiked = false;
//   int commentCount = 0;
//   bool likeStatusChanged = false;

//   // toggleLike(widget) {
//   //   isLiked = !isLiked;

//   //   //access the document in firebase
//   //   DocumentReference postRef =
//   //       FirebaseFirestore.instance.collection('User posts').doc(widget.postId);

//   //   if (isLiked) {
//   //     //if the post is now liked then add the users email to the 'likes field'
//   //     postRef.update({
//   //       'Likes': FieldValue.arrayUnion([currentUser.email])
//   //     }).then((value) {
//   //       // Set likeStatusChanged to true
//   //       likeStatusChanged = true;
//   //       notifyListeners();
//   //     });
//   //   } else {
//   //     //if the post is now unliked, remove the users email  from the 'likes field'
//   //     postRef.update({
//   //       'Likes': FieldValue.arrayRemove([currentUser.email])
//   //     }).then((value) {
//   //       // Set likeStatusChanged to true
//   //       likeStatusChanged = true;
//   //       notifyListeners();
//   //     });
//   //   }
//   // }
  
// }
