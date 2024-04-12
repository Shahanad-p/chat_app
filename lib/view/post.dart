// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:chat_app/controller/post_provider.dart';
import 'package:chat_app/widget/comment_dialogue.dart';
import 'package:chat_app/widget/delete_dialoque.dart';
import 'package:chat_app/widget/helper_method.dart';
import 'package:chat_app/widget/delete_button.dart';
import 'package:chat_app/widget/comment_button.dart';
import 'package:chat_app/widget/comments.dart';
import 'package:chat_app/widget/like_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final currentUser = FirebaseAuth.instance.currentUser!;

  // int commentCount = 0;

  @override
  void initState() {
    final provider = Provider.of<PostProvider>(context, listen: false);
    super.initState();
    provider.isLiked = widget.likes.contains(currentUser.email);
    provider.fetchCommentCount(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
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
                radius: 30.10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.10),
                  child: Image.asset(
                    'assets/user.png',
                    fit: BoxFit.cover,
                    height: 60,
                  ),
                ),
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
          //comment under the post
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('User posts')
                .doc(widget.postId)
                .collection('Comments')
                .orderBy('CommentTime', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              //show loading circle if no data yet
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<Widget> commentWidgets = snapshot.data!.docs.map((doc) {
                //get the comment
                final commentData = doc.data() as Map<String, dynamic>;
                //return the comment
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
          Consumer<PostProvider>(
            builder: (context, value, child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LikeButton(
                  isLiked: value.isLiked,
                  onTap: () => value.toggleLike(widget.postId, value.isLiked),
                ),
                Text(
                  '${widget.likes.length} likes',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                SizedBox(width: 30),
                CommentButton(
                  onTap: () => showCommentDialog(context, widget.postId),
                ),
                Text(
                  '${value.commentCount} comments',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                SizedBox(width: 20),
                // if (widget.user == currentUser.email)
                DeleteButton(
                    onTap: () => deletePostDialogue(context, widget.postId)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
