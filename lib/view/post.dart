import 'package:chat_app/helper/helper_method.dart';
import 'package:chat_app/widget/comment_button.dart';
import 'package:chat_app/widget/comments.dart';
import 'package:chat_app/widget/like_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  // final String time;

  const UserPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    // required this.time,
  });

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  final TextEditingController commentTextController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  int commentCount = 0; // Initialize comment count

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
    fetchCommentCount();
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection('User posts')
        .doc(widget.postId)
        .collection('Comments')
        .add({
      'CommentText': commentText,
      'CommentedBy': currentUser.email,
      'CommentTime': Timestamp.now(),
    }).then((value) =>
            fetchCommentCount()); // Update comment count after adding
  }

  void showCommentDialog() {
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
                addComment(commentTextController.text);
                commentTextController.clear();
                Navigator.pop(context);
              },
              child: Text(
                'Post',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

  void fetchCommentCount() {
    FirebaseFirestore.instance
        .collection('User posts')
        .doc(widget.postId)
        .collection('Comments')
        .get()
        .then((snapshot) {
      setState(() {
        commentCount = snapshot.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 194, 209, 194),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/user.png',
                      fit: BoxFit.cover,
                      height: 60,
                    )),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user,
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.message,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('User posts')
                .doc(widget.postId)
                .collection('Comments')
                .orderBy('CommentTime', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<Widget> commentWidgets = snapshot.data!.docs.map((doc) {
                final commentData = doc.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: MyComments(
                    comment: commentData['CommentText'],
                    user: commentData['CommentedBy'],
                    time: formatDate(commentData['CommentTime']),
                  ),
                );
              }).toList();
              return Column(
                children: commentWidgets,
              );
            },
          ),
          SizedBox(height: 20),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LikeButton(
                isLiked: isLiked,
                onTap: toggleLike,
              ),
              Text(
                '${widget.likes.length} likes',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              SizedBox(width: 110),
              CommentButton(
                onTap: showCommentDialog,
              ),
              Text(
                '$commentCount comments',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
