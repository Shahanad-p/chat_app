import 'package:chat_app/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  // Post a message
  Future<void> postMessage(String userEmail, String message) async {
    await _firestore.collection('User posts').add({
      'UserEmail': userEmail,
      'Message': message,
      'Timestamb': Timestamp.now(),
      'Likes': [],
    });
  }

  // Stream of user posts
  Stream<List<UserPostModel>> streamUserPosts() {
    return _firestore
        .collection('User posts')
        .orderBy('Timestamb', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => UserPostModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<void> toggleLike(String postId, bool isLiked) async {
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User posts').doc(postId);
    if (isLiked) {
      await postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      await postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email]),
      });
    }
  }

  Future<void> addComment(String postId, String commentText) async {
    await FirebaseFirestore.instance
        .collection('User posts')
        .doc(postId)
        .collection('Comments')
        .add({
      'CommentText': commentText,
      'CommentedBy': currentUser.email,
      'CommentTime': Timestamp.now()
    });
  }

  Future<int> fetchCommentCount(String postId) async {
    final snapshot = await _firestore
        .collection('User posts')
        .doc(postId)
        .collection('Comments')
        .get();
    return snapshot.docs.length;
  }

  Future<void> deletePost(String postId) async {
    //delete comment
    final commentDocs = await FirebaseFirestore.instance
        .collection('User posts')
        .doc(postId)
        .collection('Comments')
        .get();
    for (var doc in commentDocs.docs) {
      await doc.reference.delete();
    }
    //delete post
    await FirebaseFirestore.instance
        .collection('User posts')
        .doc(postId)
        .delete();
  }
}
