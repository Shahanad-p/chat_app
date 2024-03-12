import 'package:chat_app/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}
