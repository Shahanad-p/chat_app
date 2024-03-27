import 'package:chat_app/controller/home_provider.dart';
import 'package:chat_app/model/model.dart';
import 'package:chat_app/widget/drawer.dart';
import 'package:chat_app/view/post.dart';
import 'package:chat_app/widget/textfields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      drawer: Consumer<HomeProvider>(
        builder: (context, value, child) => MyDrawer(
          onProfileTap: () => value.goToProfilePage(context),
          onSignOut: provider.signOut,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<HomeProvider>(
          builder: (context, value, child) => Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: Provider.of<HomeProvider>(context, listen: false)
                        .userPostsStream,
                    builder:
                        (context, AsyncSnapshot<List<UserPostModel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final post = snapshot.data![index];
                            return UserPost(
                              message: post.message,
                              user: post.userEmail,
                              postId: post.id,
                              // time: formatDate(post.timestamp as Timestamp),
                              likes: post.likes,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error ${snapshot.error}'));
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
              SizedBox(height: 30.10),
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
              SizedBox(height: 20.10),
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
