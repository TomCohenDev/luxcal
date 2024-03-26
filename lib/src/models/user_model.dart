import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserModel extends Equatable {
  String? uid;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? nickName;
  Color? nickNameColor;
  String? fcmToken;

  UserModel({
    this.uid,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.nickName,
    this.nickNameColor,
    this.fcmToken,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? nickName,
    Color? nickNameColor,
    String? fcmToken,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      nickName: nickName ?? this.nickName,
      nickNameColor: nickNameColor ?? this.nickNameColor,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot snap) {
    var firestoreDoc = snap.data() as Map<String, dynamic>? ?? {};
    return UserModel(
      uid: snap.id,
      email: firestoreDoc['email'] ?? '',
      fcmToken: firestoreDoc['fcmToken'],
      fullName: firestoreDoc['fullName'] ?? '',
      phoneNumber: firestoreDoc['phoneNumber'] ?? '',
      nickName: firestoreDoc['nickName'],
      nickNameColor: firestoreDoc['nickNameColor'] != null
          ? Color(firestoreDoc['nickNameColor'])
          : null,
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'nickName': nickName,
      'nickNameColor': nickNameColor?.value,
      'fcmToken': fcmToken,
    };
  }

  @override
  List<Object?> get props =>
      [uid, email, fullName, phoneNumber, nickName, nickNameColor, fcmToken];
}
