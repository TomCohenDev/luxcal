import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class LoginFirebaseUser {
  LoginFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

LoginFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<LoginFirebaseUser> loginFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<LoginFirebaseUser>(
      (user) {
        currentUser = LoginFirebaseUser(user);
        return currentUser!;
      },
    );
