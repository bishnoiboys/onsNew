import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAvidJS1vak-HPTG9xVU-tALVbrzOWmGO4",
            authDomain: "one-night-stand-5529.firebaseapp.com",
            projectId: "one-night-stand-5529",
            storageBucket: "one-night-stand-5529.appspot.com",
            messagingSenderId: "899073200083",
            appId: "1:899073200083:web:356faef53f9f6f0c626926"));
  } else {
    await Firebase.initializeApp();
  }
}
