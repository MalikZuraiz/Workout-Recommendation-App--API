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
    apiKey: 'AIzaSyDKvzZLB_LdiIDdYf5-dw_1-k2B9vNNxPI',
    appId: '1:690527389976:web:994ebbe95d145f1a38366d',
    messagingSenderId: '690527389976',
    projectId: 'wrmflutter',
    authDomain: 'wrmflutter.firebaseapp.com',
    storageBucket: 'wrmflutter.appspot.com',
    measurementId: 'G-KRRMKDB8LC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwyMXNtouni6FRGLvn_dDO50JyVJ_EPQY',
    appId: '1:690527389976:android:c1f8322dd9e5033d38366d',
    messagingSenderId: '690527389976',
    projectId: 'wrmflutter',
    storageBucket: 'wrmflutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCm7W7v_Vo2lqyltNMMTdOF_qimKBrUack',
    appId: '1:690527389976:ios:47d3f60fafa131d238366d',
    messagingSenderId: '690527389976',
    projectId: 'wrmflutter',
    storageBucket: 'wrmflutter.appspot.com',
    iosBundleId: 'com.example.wrs',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCm7W7v_Vo2lqyltNMMTdOF_qimKBrUack',
    appId: '1:690527389976:ios:e11a9c1fb11ce6b438366d',
    messagingSenderId: '690527389976',
    projectId: 'wrmflutter',
    storageBucket: 'wrmflutter.appspot.com',
    iosBundleId: 'com.example.wrs.RunnerTests',
  );
}
