// ignore_for_file: use_build_context_synchronously
import 'package:chat_app/controller/login_provider.dart';
import 'package:chat_app/view/mobile_number_scree.dart';
import 'package:chat_app/view/register_screen.dart';
import 'package:chat_app/widget/button.dart';
import 'package:chat_app/widget/image_path.dart';
import 'package:chat_app/widget/textfields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final Function()? onTap;
  const LoginScreen({super.key, this.onTap});

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
                          onTap;
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
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      Text(
                        "Or connect with",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Consumer<LoginProvider>(
                    builder: (context, value, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyImagePath(
                          imagePath: 'assets/code.png',
                          onTap: value.signInWithGithub,
                        ),
                        MyImagePath(
                          imagePath: 'assets/google.png',
                          onTap: value.signInWithGoogle,
                        ),
                        MyImagePath(
                          imagePath: 'assets/mobile-phone.png',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MobileNumberScreen()));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
