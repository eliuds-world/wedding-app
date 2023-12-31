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
    apiKey: 'AIzaSyAprB9-yMECjEIXpXfhK_jQQVmCnd3vVY8',
    appId: '1:935990424363:web:2029f38c98a2345b648b6e',
    messagingSenderId: '935990424363',
    projectId: 'wedd-app-8dbed',
    authDomain: 'wedd-app-8dbed.firebaseapp.com',
    storageBucket: 'wedd-app-8dbed.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmmZ8iSJvFwguGA6tid568PhJSHjxTKfU',
    appId: '1:935990424363:android:b0cd8ab56f40fb19648b6e',
    messagingSenderId: '935990424363',
    projectId: 'wedd-app-8dbed',
    storageBucket: 'wedd-app-8dbed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiCUEc2iB_fFQxlg0rPVRIVoQ0xltiFPs',
    appId: '1:935990424363:ios:f46df0dec05cb186648b6e',
    messagingSenderId: '935990424363',
    projectId: 'wedd-app-8dbed',
    storageBucket: 'wedd-app-8dbed.appspot.com',
    iosBundleId: 'com.example.wedding2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDiCUEc2iB_fFQxlg0rPVRIVoQ0xltiFPs',
    appId: '1:935990424363:ios:b52e7917fc26bb44648b6e',
    messagingSenderId: '935990424363',
    projectId: 'wedd-app-8dbed',
    storageBucket: 'wedd-app-8dbed.appspot.com',
    iosBundleId: 'com.example.wedding2.RunnerTests',
  );
}
