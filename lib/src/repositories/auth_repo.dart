import 'package:LuxCal/src/models/user_model.dart';
import 'package:LuxCal/src/repositories/user_repo.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  Stream<auth.User?> get user;
  Future<auth.User?> signUpWithEmail({
    required UserModel userModel,
    required String password,
  });
  Future<void> logInWithEmail({
    required String email,
    required String password,
  });

  Future<void> signOut();
}

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthRepository(
      {auth.FirebaseAuth? firebaseAuth, required UserRepository userRepository})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _userRepository = userRepository;

  @override
  Future<auth.User?> signUpWithEmail({
    required UserModel userModel,
    required String password,
  }) async {
    print(userModel.email);
    print(password);

    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: password,
      );
      final authUser = userCredential.user;

      await _userRepository.createUser(
        userModel.copyWith(
          uid: authUser!.uid,
          email: userModel.email,
        ),
      );

      return authUser;
    } on auth.FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Future<void> logInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on auth.FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
