import 'package:chat_app/widget/button.dart';
import 'package:chat_app/widget/textfields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  const RegisterScreen({super.key, this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  //user sign Up
  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    //make sure password match
    if (passwordController.text != confirmPassController.text) {
      Navigator.pop(context);
      //show error to user
      displayMessage('Passwords don\'t match');
      return;
    }

    try {
      //create the user
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      // after creating the user, create a new document in cloud firestore called Users
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'username': emailController.text.split('@')[0], //initial username
        'bio': 'empty bio' //initially empty bio
        //add any additional; fields as needed
      });

      //pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //show error to user
      displayMessage(e.code);
    }
  }

  //display dialogue message to user
  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/verify.png'),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Create an account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFieldsWidget(
                  controller: emailController,
                  hintText: 'Enter the email',
                  obscureText: false,
                ),
                SizedBox(height: 20),
                TextFieldsWidget(
                    controller: passwordController,
                    hintText: 'Enter the password here',
                    obscureText: true),
                SizedBox(height: 20),
                TextFieldsWidget(
                    controller: confirmPassController,
                    hintText: 'Enter the confirm password here',
                    obscureText: true),
                SizedBox(height: 20),
                MyButtonWidget(
                  text: 'Sign Up',
                  onTap: signUp,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account? ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        widget.onTap;
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
