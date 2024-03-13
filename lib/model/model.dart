import 'package:cloud_firestore/cloud_firestore.dart';

class UserPostModel {
  final String id;
  final String userEmail;
  final String message;
  final List<String> likes;

  UserPostModel({
    required this.id,
    required this.userEmail,
    required this.message,
    required this.likes,
  });

  factory UserPostModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserPostModel(
      id: doc.id,
      userEmail: data['UserEmail'] ?? '',
      message: data['Message'] ?? '',
      likes: List.from(data['Likes'] ?? []),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'UserEmail': userEmail,
      'Message': message,
      'Likes': likes
    };
  }
}
