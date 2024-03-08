import 'package:chat_app/controller/home_provider.dart';
import 'package:chat_app/helper/helper_method.dart';
import 'package:chat_app/view/profile_screen.dart';
import 'package:chat_app/widget/drawer.dart';
import 'package:chat_app/view/post.dart';
import 'package:chat_app/widget/textfields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSccreen extends StatefulWidget {
  const HomeSccreen({super.key});

  @override
  State<HomeSccreen> createState() => _HomeSccreenState();
}

class _HomeSccreenState extends State<HomeSccreen> {
  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
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
        onSignOut: provider.signOut,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<HomeProvider>(
          builder: (context, value, child) => Column(
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
                      controller: value.textController,
                      hintText: 'Write something here',
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                      onPressed: value.postMessage,
                      icon: Icon(Icons.arrow_circle_up)),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Logged in as : ${value.currentUser.email!}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 42, 154, 46)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
