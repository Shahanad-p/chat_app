// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:chat_app/view/home_screen.dart';
import 'package:chat_app/widget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/3d-mobile-phone-with-security-code-padlock (1).jpg',
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Verification',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.8),
                  Text(
                    'Enter the OTP sent to your phone',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.8),
                  TextFormField(
                    cursorColor: Colors.green,
                    controller: otpController,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Enter the phone number',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 36, 102, 38))),
                    ),
                  ),
                  SizedBox(height: 20),
                  MyButtonWidget(
                      onTap: () async {
                        if (otpController.text.isNotEmpty) {
                          try {
                            PhoneAuthCredential credential =
                                await PhoneAuthProvider.credential(
                                    verificationId: widget.verificationId,
                                    smsCode: otpController.text.toString());
                            await FirebaseAuth.instance
                                .signInWithCredential(credential);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          } catch (e) {
                            log(e.toString());
                          }
                        } else {
                          log('Otp is empty');
                        }
                      },
                      text: 'Verify'),
                  SizedBox(height: 20),
                  Text(
                    'Did\'t receive any code?',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Resent new code',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
