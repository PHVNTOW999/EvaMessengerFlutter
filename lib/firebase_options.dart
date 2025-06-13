import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBD4ZkUJInKk7Q0PXHTZhKajQ1012kt-60',
    appId: '1:214250648925:web:41f2ab7d156d11e6a264b4',
    messagingSenderId: '214250648925',
    projectId: 'evamessenger-ff5a8',
    authDomain: 'evamessenger-ff5a8.firebaseapp.com',
    storageBucket: 'evamessenger-ff5a8.firebasestorage.app',
    measurementId: 'G-YLJEGNTFSC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBR_GFonANa8f4qdBqnAejjDdsajqo6c2M',
    appId: '1:214250648925:android:30d6d577cdcee7fea264b4',
    messagingSenderId: '214250648925',
    projectId: 'evamessenger-ff5a8',
    storageBucket: 'evamessenger-ff5a8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDB8RNRPHHLqifsqRRNkIta6Tw7iEju-Rk',
    appId: '1:214250648925:ios:7f04b3b0e686f5b8a264b4',
    messagingSenderId: '214250648925',
    projectId: 'evamessenger-ff5a8',
    storageBucket: 'evamessenger-ff5a8.firebasestorage.app',
    iosBundleId: 'com.example.evaMessengerFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDB8RNRPHHLqifsqRRNkIta6Tw7iEju-Rk',
    appId: '1:214250648925:ios:7f04b3b0e686f5b8a264b4',
    messagingSenderId: '214250648925',
    projectId: 'evamessenger-ff5a8',
    storageBucket: 'evamessenger-ff5a8.firebasestorage.app',
    iosBundleId: 'com.example.evaMessengerFlutter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBD4ZkUJInKk7Q0PXHTZhKajQ1012kt-60',
    appId: '1:214250648925:web:7042e31630c5c4bea264b4',
    messagingSenderId: '214250648925',
    projectId: 'evamessenger-ff5a8',
    authDomain: 'evamessenger-ff5a8.firebaseapp.com',
    storageBucket: 'evamessenger-ff5a8.firebasestorage.app',
    measurementId: 'G-KYXN9BJYPD',
  );

}