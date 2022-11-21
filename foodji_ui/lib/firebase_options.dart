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
    apiKey: 'AIzaSyASAHflXbW1uAPnVuseYXTEtP1ckrGJfNs',
    appId: '1:452902969608:web:0f67999bba461d30914cbd',
    messagingSenderId: '452902969608',
    projectId: 'foodji-auth',
    authDomain: 'foodji-auth.firebaseapp.com',
    storageBucket: 'foodji-auth.appspot.com',
    measurementId: 'G-Y66SDFQ7EV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSp5ojVWbDtRNn3XsU57koZWqmeo8GX7w',
    appId: '1:452902969608:android:87c9ee088bc58e35914cbd',
    messagingSenderId: '452902969608',
    projectId: 'foodji-auth',
    storageBucket: 'foodji-auth.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6Rb8VSOmeXRTXE0ZsOrGiyCn_E9wuXFg',
    appId: '1:452902969608:ios:f9ccc1db2e4d3dde914cbd',
    messagingSenderId: '452902969608',
    projectId: 'foodji-auth',
    storageBucket: 'foodji-auth.appspot.com',
    iosClientId: '452902969608-m0qh87u9rk58fkpqccqnq2ugc8uvhl9e.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodjiUi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6Rb8VSOmeXRTXE0ZsOrGiyCn_E9wuXFg',
    appId: '1:452902969608:ios:f9ccc1db2e4d3dde914cbd',
    messagingSenderId: '452902969608',
    projectId: 'foodji-auth',
    storageBucket: 'foodji-auth.appspot.com',
    iosClientId: '452902969608-m0qh87u9rk58fkpqccqnq2ugc8uvhl9e.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodjiUi',
  );
}
