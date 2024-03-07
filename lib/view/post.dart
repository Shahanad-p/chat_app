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
  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  //togle like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    //access the document is firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User posts').doc(widget.postId);

    if (isLiked) {
      //if the post is now liked then add the users email to the 'likes field'
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      //if the post is now unliked, remove the users email  from the 'likes field'
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  //add comment
  void addComment(String commentText) {
    //write the comment to firestore under the comments collection for tyhis post
    FirebaseFirestore.instance
        .collection('User posts')
        .doc(widget.postId)
        .collection('Comments')
        .add({
      'CommentText': commentText,
      'CommentedBy': currentUser.email,
      'CommentTime': Timestamp.now(),
    });
  }

  //show a dialogue box for adding comments
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
          //cancel button
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                commentTextController.clear();
              },
              child: Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          //post  button
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 194, 209, 194),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: ClipRRect(
                child: Image.asset(
              'assets/user.png',
              height: 40,
            )),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user,
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                Text(
                  widget.message,
                  style: TextStyle(fontWeight: FontWeight.bold),
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
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: snapshot.data!.docs.map((doc) {
                          //get the comment
                          final commentData =
                              doc.data() as Map<String, dynamic>;

                          //return the comment
                          return MyComments(
                            text: commentData['CommentText'],
                            user: commentData['CommentedBy'],
                            time: formatDate(commentData['CommentTime']),
                          );
                        }).toList(),
                      );
                    })
              ],
            ),
          ),
          Column(
            children: [
              //comment button
              CommentButton(onTap: showCommentDialog),
              SizedBox(height: 5),

              //comment count
              Text(
                '0',
                style: TextStyle(color: const Color.fromARGB(255, 95, 92, 92)),
              ),
            ],
          ),
          Column(
            children: [
              //like button
              LikeButton(
                isLiked: isLiked,
                onTap: toggleLike,
              ),
              SizedBox(height: 5),

              //like count
              Text(
                widget.likes.length.toString(),
                style: TextStyle(color: const Color.fromARGB(255, 95, 92, 92)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
