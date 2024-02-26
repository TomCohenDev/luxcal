import 'dart:convert';
import 'dart:math';
import 'package:crypto/src/sha256.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:revampedai/aaasrc/models/user_model.dart';
import 'package:revampedai/aaasrc/repositories/user_repo.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
  Future<void> logInWithGoogle();
  Future<void> logInWithApple();
  Future<void> logInWithFacebook();

  Future<void> signOut();
}

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  AuthRepository(
      {auth.FirebaseAuth? firebaseAuth,
      GoogleSignIn? googleSignIn,
      FacebookAuth? facebookAuth,
      required UserRepository userRepository})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _googleSignIn =
            googleSignIn ?? GoogleSignIn.standard(scopes: ['email']),
        _facebookAuth = facebookAuth ?? FacebookAuth.instance,
        _userRepository = userRepository;

  @override
  Future<auth.User?> signUpWithEmail({
    required UserModel userModel,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: password,
      );
      final authUser = userCredential.user;

      await _userRepository.createUser(
        userModel.copyWith(
          uid: authUser!.uid,
          created_time: DateTime.now(),
          email: userModel.email,
        ),
      );

      return authUser;
    } on auth.FirebaseAuthException catch (e) {
      print(e.toString());
    }
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
  Future<void> logInWithGoogle() async {
    try {
      late final auth.AuthCredential credential;
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;

      credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      _firebaseAuth.signInWithCredential(credential).then((value) => {
            _userRepository.createUser(UserModel(
              uid: value.user!.uid,
              email: value.user!.email ?? '',
              created_time: DateTime.now(),
            ))
          });
    } catch (e) {}
  }

  @override
  Future<void> logInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final auth.AuthCredential credential =
            auth.FacebookAuthProvider.credential(accessToken.token);

        final auth.UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        // Update the user in the repository
        final user = userCredential.user;
        if (user != null) {
          _userRepository.createUser(UserModel(
            uid: user.uid,
            email: user.email ?? '',
            created_time: DateTime.now(),
          ));
        }
      }
    } catch (e) {
      // Handle the exception
      print(e.toString());
    }
  }

  @override
  Future<void> logInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = auth.OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final auth.UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(oauthCredential);

      // Update the user in the repository
      final user = userCredential.user;
      if (user != null) {
        _userRepository.createUser(UserModel(
          uid: user.uid,
          email: user.email ?? '',
          created_time: DateTime.now(),

          // Add other fields if necessary
        ));
      }
    } catch (e) {
      // Handle the exception
      print(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
