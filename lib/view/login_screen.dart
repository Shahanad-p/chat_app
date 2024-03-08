// ignore_for_file: use_build_context_synchronously
import 'package:chat_app/controller/login_provider.dart';
import 'package:chat_app/view/register_screen.dart';
import 'package:chat_app/widget/button.dart';
import 'package:chat_app/widget/textfields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordlController = TextEditingController();

  // //user signed in
  // void signIn() async {
  //   //loading circle
  //   showDialog(
  //     context: context,
  //     builder: (context) => Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );

  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text, password: passwordlController.text);

  //     // pop loading circle
  //     if (context.mounted) Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     //pop loading circle
  //     Navigator.pop(context);
  //     //display error message
  //     displayMessage(e.code);
  //   }
  // }

  // //display a message to user
  // void displayMessage(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text(message),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Consumer<LoginProvider>(
              builder: (context, value, child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/security.png'),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Welcome back to the login screen',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextFieldsWidget(
                    controller: value.emailController,
                    hintText: 'Enter the email',
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  TextFieldsWidget(
                      controller: value.passwordlController,
                      hintText: 'Enter the password here',
                      obscureText: true),
                  SizedBox(height: 20),
                  MyButtonWidget(
                    text: 'Sign In',
                    onTap: () => value.signIn(context),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have account? ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          widget.onTap;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                          'Register now',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/code.png'),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/facebook (1).png'),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/google.png'),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: InkWell(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => OtpStartingScreen()));
                            },
                            child: Image.asset('assets/mobile-phone.png')),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
