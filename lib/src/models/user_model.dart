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

  UserModel({
    this.uid,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.nickName,
    this.nickNameColor,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? nickName,
    Color? nickNameColor,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      nickName: nickName ?? this.nickName,
      nickNameColor: nickNameColor ?? this.nickNameColor,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;

    return UserModel(
      uid: snap.id,
      email: data?['email'],
      fullName: data?['fullName'],
      phoneNumber: data?['phoneNumber'],
      nickName: data?['nickName'],
      // Convert the Firestore color (usually stored as an int) back to a Color
      nickNameColor:
          data?['nickNameColor'] != null ? Color(data?['nickNameColor']) : null,
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'nickName': nickName,
      // Store the color as an int to Firestore
      'nickNameColor': nickNameColor?.value,
    };
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        fullName,
        phoneNumber,
        nickName,
        nickNameColor,
      ];
}
