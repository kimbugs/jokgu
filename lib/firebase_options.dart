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
    apiKey: 'AIzaSyDLW4lhsWzEZN4u2z26HGgOUZw9hp570G4',
    appId: '1:916704590801:web:4840bd5b6b915976823ef0',
    messagingSenderId: '916704590801',
    projectId: 'test-app-790a0',
    authDomain: 'test-app-790a0.firebaseapp.com',
    storageBucket: 'test-app-790a0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDl25s-nQxMQ5Ydyg13AGB0EiBt4pYSJOA',
    appId: '1:916704590801:android:78755ae8a988fbbf823ef0',
    messagingSenderId: '916704590801',
    projectId: 'test-app-790a0',
    storageBucket: 'test-app-790a0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxy9xjXhYjOGdimruL7fXORv4kBb5ICf0',
    appId: '1:916704590801:ios:c68ccad33fa1a43d823ef0',
    messagingSenderId: '916704590801',
    projectId: 'test-app-790a0',
    storageBucket: 'test-app-790a0.appspot.com',
    iosClientId: '916704590801-l1ojt4mdfqtga1g8rj94ua3sqgjvs6kt.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplicationFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxy9xjXhYjOGdimruL7fXORv4kBb5ICf0',
    appId: '1:916704590801:ios:c68ccad33fa1a43d823ef0',
    messagingSenderId: '916704590801',
    projectId: 'test-app-790a0',
    storageBucket: 'test-app-790a0.appspot.com',
    iosClientId: '916704590801-l1ojt4mdfqtga1g8rj94ua3sqgjvs6kt.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplicationFirebase',
  );
}
