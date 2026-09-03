import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'Web not supported. Add your Firebase web config if needed.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'Your platform is not supported. Please add your Firebase config manually.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAmrw2K2ZDDOSN-kNi28Xst7FKO3z977w',
    appId: '1:851461843078:android:d144d4ab5d7cdfd1e88907',
    messagingSenderId: '851461843078',
    projectId: 'livemcq-21522',
    storageBucket: 'livemcq-21522.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAmrw2K2ZDDOSN-kNi28Xst7FKO3z977w',
    appId: '1:851461843078:ios:d144d4ab5d7cdfd1e88907',
    messagingSenderId: '851461843078',
    projectId: 'livemcq-21522',
    storageBucket: 'livemcq-21522.firebasestorage.app',
    iosBundleId: 'com.nothibazar.livemcq',
  );
}
