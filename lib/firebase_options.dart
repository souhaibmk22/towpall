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
    apiKey: 'AIzaSyByPymlM_jtUJ1aZmR_xXOVNtgVQAmDLt0',
    appId: '1:536717158148:web:b95c98026b97c480d65251',
    messagingSenderId: '536717158148',
    projectId: 'towpal-417323',
    authDomain: 'towpal-417323.firebaseapp.com',
    storageBucket: 'towpal-417323.appspot.com',
    measurementId: 'G-8L4ZJCQYCX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAqY_8zSpLF_q0g_VOwGHV2ONAM3-3hzBI',
    appId: '1:536717158148:android:8f722a80919ddb6fd65251',
    messagingSenderId: '536717158148',
    projectId: 'towpal-417323',
    storageBucket: 'towpal-417323.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtZzVzMdQRbCpMm9cPg7qqy4kS8vCp7l8',
    appId: '1:536717158148:ios:5b0c3b4d8dbe4251d65251',
    messagingSenderId: '536717158148',
    projectId: 'towpal-417323',
    storageBucket: 'towpal-417323.appspot.com',
    iosBundleId: 'com.example.carihio',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtZzVzMdQRbCpMm9cPg7qqy4kS8vCp7l8',
    appId: '1:536717158148:ios:5b0c3b4d8dbe4251d65251',
    messagingSenderId: '536717158148',
    projectId: 'towpal-417323',
    storageBucket: 'towpal-417323.appspot.com',
    iosBundleId: 'com.example.carihio',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyByPymlM_jtUJ1aZmR_xXOVNtgVQAmDLt0',
    appId: '1:536717158148:web:9feb76ce3f52c5d7d65251',
    messagingSenderId: '536717158148',
    projectId: 'towpal-417323',
    authDomain: 'towpal-417323.firebaseapp.com',
    storageBucket: 'towpal-417323.appspot.com',
    measurementId: 'G-Q8LCJEXPXJ',
  );
}
