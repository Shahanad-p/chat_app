// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class PostProvider extends ChangeNotifier {
//   final TextEditingController commentTextController = TextEditingController();
//   final currentUser = FirebaseAuth.instance.currentUser!;
//   bool isLiked = false;
//   int commentCount = 0;

//   //delete post
//   // void deletePost(BuildContext context, String postId) {
//   //   //show a dialog box asking for confirmation
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) => AlertDialog(
//   //       title: Text('Delete Post'),
//   //       content: Text('Are you sure to delete this post?'),
//   //       actions: [
//   //         TextButton(
//   //           onPressed: () => Navigator.pop(context),
//   //           child: Text('Cancel'),
//   //         ),
//   //         TextButton(
//   //           onPressed: () async {
//   //             //delete the comment from fire store first
//   //             //(if you only delete the post, the comments will still be the stored in firestore)
//   //             final commentDocs = await FirebaseFirestore.instance
//   //                 .collection('User posts')
//   //                 .doc(postId)
//   //                 .collection('Comments')
//   //                 .get();
//   //             for (var doc in commentDocs.docs) {
//   //               await FirebaseFirestore.instance
//   //                   .collection('User posts')
//   //                   .doc(postId)
//   //                   .collection('Comments')
//   //                   .doc(doc.id)
//   //                   .delete();
//   //               notifyListeners();
//   //             }
//   //             //then delete the post
//   //             FirebaseFirestore.instance
//   //                 .collection('User posts')
//   //                 .doc(postId)
//   //                 .delete()
//   //                 .then((value) => print('Delete the post'))
//   //                 .catchError((error) => print('failed to delete post'));

//   //             //dismiss the dialog box
//   //             Navigator.pop(context);
//   //             notifyListeners();
//   //           },
//   //           child: Text('Delete'),
//   //         )
//   //       ],
//   //     ),
//   //   );
//   //   notifyListeners();
//   // }
// }
