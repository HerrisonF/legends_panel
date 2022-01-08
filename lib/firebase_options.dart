// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDkOov1HMJ1Xm8t3SmqV9n6JbGgxs0oYI',
    appId: '1:722053764734:android:143d8295a3d6b90a8fea2f',
    messagingSenderId: '722053764734',
    projectId: 'watchsummoner-7312d',
    storageBucket: 'watchsummoner-7312d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmRpJnoa7KUXv19Wb7vscqr2kpr9riPdw',
    appId: '1:722053764734:ios:77e1a7f6cca080ab8fea2f',
    messagingSenderId: '722053764734',
    projectId: 'watchsummoner-7312d',
    storageBucket: 'watchsummoner-7312d.appspot.com',
    iosClientId: '722053764734-icgleintln11v144v5o07386bsup93n6.apps.googleusercontent.com',
    iosBundleId: 'com.herrison.legendsPanel',
  );
}
