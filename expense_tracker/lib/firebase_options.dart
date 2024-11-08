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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDw_09b4gItpg74jaLUfQ9ExVholPFyIfg',
    appId: '1:819915701623:web:324bd61a0ff1adb7abf572',
    messagingSenderId: '819915701623',
    projectId: 'flutter-expense-tracker-51134',
    authDomain: 'flutter-expense-tracker-51134.firebaseapp.com',
    storageBucket: 'flutter-expense-tracker-51134.firebasestorage.app',
    measurementId: 'G-ZXHDPL6M5X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKGUhBmT1rQDosorwypjmJ0YIBI8nHvlg',
    appId: '1:819915701623:android:3e770392f08d8b04abf572',
    messagingSenderId: '819915701623',
    projectId: 'flutter-expense-tracker-51134',
    storageBucket: 'flutter-expense-tracker-51134.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5TK-8SSp4zXlXWvoHdpFZ9cbEXt0gYOE',
    appId: '1:819915701623:ios:698d5a72561de849abf572',
    messagingSenderId: '819915701623',
    projectId: 'flutter-expense-tracker-51134',
    storageBucket: 'flutter-expense-tracker-51134.firebasestorage.app',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD5TK-8SSp4zXlXWvoHdpFZ9cbEXt0gYOE',
    appId: '1:819915701623:ios:698d5a72561de849abf572',
    messagingSenderId: '819915701623',
    projectId: 'flutter-expense-tracker-51134',
    storageBucket: 'flutter-expense-tracker-51134.firebasestorage.app',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDw_09b4gItpg74jaLUfQ9ExVholPFyIfg',
    appId: '1:819915701623:web:bfbd54cc9bf45370abf572',
    messagingSenderId: '819915701623',
    projectId: 'flutter-expense-tracker-51134',
    authDomain: 'flutter-expense-tracker-51134.firebaseapp.com',
    storageBucket: 'flutter-expense-tracker-51134.firebasestorage.app',
    measurementId: 'G-HKD3QX056D',
  );
}
