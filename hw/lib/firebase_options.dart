// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBNY79ejxqpOPLW1O8gck87luyqhOFNqxc',
    appId: '1:1081147942782:web:cd1b4b4bf653d6e049752f',
    messagingSenderId: '1081147942782',
    projectId: 'finalproject-fb104',
    authDomain: 'finalproject-fb104.firebaseapp.com',
    storageBucket: 'finalproject-fb104.appspot.com',
    measurementId: 'G-XMPYVZYSGG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEinb_HRr34Zba7GPw3lS4TmeN52XwqZA',
    appId: '1:1081147942782:android:a5a4711cfbdbbd2b49752f',
    messagingSenderId: '1081147942782',
    projectId: 'finalproject-fb104',
    storageBucket: 'finalproject-fb104.appspot.com',
  );

}