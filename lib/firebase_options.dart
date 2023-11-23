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
    apiKey: 'AIzaSyAJdxUZg4aLT3APqozPKvjdBvr5WQAbUEY',
    appId: '1:614294494809:web:45bc50fad4439284a89b48',
    messagingSenderId: '614294494809',
    projectId: 'campus-connect-app-71fc4',
    authDomain: 'campus-connect-app-71fc4.firebaseapp.com',
    storageBucket: 'campus-connect-app-71fc4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATV1SmMPNC1aCk7Xv0osAu3Bl2B9kpZxM',
    appId: '1:614294494809:android:ef285a153f82ba23a89b48',
    messagingSenderId: '614294494809',
    projectId: 'campus-connect-app-71fc4',
    storageBucket: 'campus-connect-app-71fc4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8ja0uSjfGIjsVUKnL-AfhbdLjJbX8950',
    appId: '1:614294494809:ios:fa772bcde29f3d22a89b48',
    messagingSenderId: '614294494809',
    projectId: 'campus-connect-app-71fc4',
    storageBucket: 'campus-connect-app-71fc4.appspot.com',
    iosBundleId: 'com.example.campusConnectApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8ja0uSjfGIjsVUKnL-AfhbdLjJbX8950',
    appId: '1:614294494809:ios:ac17dfbd7ee5914ea89b48',
    messagingSenderId: '614294494809',
    projectId: 'campus-connect-app-71fc4',
    storageBucket: 'campus-connect-app-71fc4.appspot.com',
    iosBundleId: 'com.example.campusConnectApp.RunnerTests',
  );
}