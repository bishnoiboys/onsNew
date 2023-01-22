import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class OneNightStandFirebaseUser {
  OneNightStandFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

OneNightStandFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<OneNightStandFirebaseUser> oneNightStandFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<OneNightStandFirebaseUser>(
      (user) {
        currentUser = OneNightStandFirebaseUser(user);
        return currentUser!;
      },
    );
