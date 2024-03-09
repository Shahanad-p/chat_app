// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCBb3aOBIeJqdY2lpZ2p7zFqACLX6cN0ao',
    appId: '1:71144012186:web:796a574215ac3067aca223',
    messagingSenderId: '71144012186',
    projectId: 'chatapp-eb2ed',
    authDomain: 'chatapp-eb2ed.firebaseapp.com',
    storageBucket: 'chatapp-eb2ed.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBneO4n1yl0AwK07CirLd2kgz8JcqZUUyI',
    appId: '1:71144012186:android:e1fe76e9c6be084daca223',
    messagingSenderId: '71144012186',
    projectId: 'chatapp-eb2ed',
    storageBucket: 'chatapp-eb2ed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDylFyRLymlZJT4VnDdbVp1eB3mK0p3SQ',
    appId: '1:71144012186:ios:e557a5b832b88669aca223',
    messagingSenderId: '71144012186',
    projectId: 'chatapp-eb2ed',
    storageBucket: 'chatapp-eb2ed.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBDylFyRLymlZJT4VnDdbVp1eB3mK0p3SQ',
    appId: '1:71144012186:ios:b7ceb125ab123e43aca223',
    messagingSenderId: '71144012186',
    projectId: 'chatapp-eb2ed',
    storageBucket: 'chatapp-eb2ed.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}