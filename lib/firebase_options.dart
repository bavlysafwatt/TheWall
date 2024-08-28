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
    apiKey: 'AIzaSyDdwgPKu3MTbTY6sXAgjcYCXEo3X3iJn-s',
    appId: '1:599122577953:web:394fc37c4c4c13f14af160',
    messagingSenderId: '599122577953',
    projectId: 'the-wall-b3642',
    authDomain: 'the-wall-b3642.firebaseapp.com',
    storageBucket: 'the-wall-b3642.appspot.com',
    measurementId: 'G-WWVY69NC3H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4ED3Sd0dbISoTBB8IpuV1GgFcGcgyEXU',
    appId: '1:599122577953:android:aeb008f6d40bef6e4af160',
    messagingSenderId: '599122577953',
    projectId: 'the-wall-b3642',
    storageBucket: 'the-wall-b3642.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOh2Pj0fHCE0aeLDC3Y2mYsHCEr_KpeKM',
    appId: '1:599122577953:ios:cace679e9ed204b74af160',
    messagingSenderId: '599122577953',
    projectId: 'the-wall-b3642',
    storageBucket: 'the-wall-b3642.appspot.com',
    iosBundleId: 'com.example.theWall',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOh2Pj0fHCE0aeLDC3Y2mYsHCEr_KpeKM',
    appId: '1:599122577953:ios:cace679e9ed204b74af160',
    messagingSenderId: '599122577953',
    projectId: 'the-wall-b3642',
    storageBucket: 'the-wall-b3642.appspot.com',
    iosBundleId: 'com.example.theWall',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDdwgPKu3MTbTY6sXAgjcYCXEo3X3iJn-s',
    appId: '1:599122577953:web:3eebf49e6f2a766e4af160',
    messagingSenderId: '599122577953',
    projectId: 'the-wall-b3642',
    authDomain: 'the-wall-b3642.firebaseapp.com',
    storageBucket: 'the-wall-b3642.appspot.com',
    measurementId: 'G-0CGY3LMLZ3',
  );
}
