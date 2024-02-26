import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:revampedai/aaasrc/models/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseUserRepository {
  Stream<UserModel> getUser(String uid);
  Future<void> createUser(UserModel user);
  Future<void> updateUser(UserModel user);
  // Future<void> deleteUser(UserModel user);
}

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<UserModel> getUser(String uid) {
    print('getting user data from firestore');
    return _firebaseFirestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snap) => UserModel.fromSnapshot(snap));
  }

  @override
  Future<void> createUser(UserModel user) async {
    bool userExists =
        (await _firebaseFirestore.collection('users').doc(user.uid).get())
            .exists;
    if (userExists) {
      return;
    }
    print('creating new user');
    return await _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(user.toDocument());
  }

  @override
  Future<void> updateUser(UserModel user) async {
    return await _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .update(user.toDocument())
        .then((value) => print('user doc updated'));
  }

  // @override
  // Future<void> deleteUser(UserModel user) {
  //   return () {};
  // }
}
