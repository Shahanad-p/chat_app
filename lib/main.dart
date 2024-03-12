import 'package:chat_app/controller/home_provider.dart';
import 'package:chat_app/controller/login_provider.dart';
import 'package:chat_app/controller/post_provider.dart';
import 'package:chat_app/controller/profile_provider.dart';
import 'package:chat_app/controller/register_provider.dart';
import 'package:chat_app/view/auth.dart';
import 'package:chat_app/service/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => PostProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
      ],
      child: MaterialApp(
        home: AuthPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
