import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    return const FirebaseOptions(
      appId: '',
      apiKey: '',
      projectId: '',
      messagingSenderId: '',
    );
  }
}
