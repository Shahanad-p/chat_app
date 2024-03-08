import 'package:chat_app/helper/helper_method.dart';
import 'package:chat_app/view/drawer.dart';
import 'package:chat_app/view/post.dart';
import 'package:chat_app/view/profile_screen.dart';
import 'package:chat_app/widget/textfields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeSccreen extends StatefulWidget {
  const HomeSccreen({super.key});

  @override
  State<HomeSccreen> createState() => _HomeSccreenState();
}

class _HomeSccreenState extends State<HomeSccreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final TextEditingController textController = TextEditingController();

  //sign out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  //post message
  postMessage() {
    //only post if there is something in the textfield
    if (textController.text.isNotEmpty) {
      //store in firebase
      FirebaseFirestore.instance.collection('User posts').add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'Timestamb': Timestamp.now(),
        'Likes': [],
      });
    }

    //clear the textfield
    setState(() {
      textController.clear();
    });
  }

  //navigate to profile page
  void goToProfilePage() {
    //pop menu drawer
    Navigator.pop(context);

    //go to profile page'
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        //logout
        onSignOut: signOut,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('User posts')
                  .orderBy('Timestamb', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      //get the message
                      final post = snapshot.data!.docs[index];
                      return UserPost(
                        message: post['Message'],
                        user: post['UserEmail'],
                        postId: post.id,
                        time: formatDate(post['Timestamb']),
                        likes: List<String>.from(post['Likes'] ?? []),
                      );
                    },
                  );
                } else {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextFieldsWidget(
                    controller: textController,
                    hintText: 'Write something here',
                    obscureText: false,
                  ),
                ),
                IconButton(
                    onPressed: postMessage, icon: Icon(Icons.arrow_circle_up)),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Logged in as : ${currentUser.email!}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 42, 154, 46)),
            ),
          ],
        ),
      ),
    );
  }
}
