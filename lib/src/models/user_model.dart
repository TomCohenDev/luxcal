// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:revampedai/aaasrc/models/sizes_model.dart';
import 'package:revampedai/aaasrc/utils/model_functions.dart';
import 'package:revampedai/widgets/closet/closet_model.dart';

class UserModel extends Equatable {
  String? uid;
  String? email;
  DateTime? created_time;
  DateTime? birth_date;
  bool onboarding_complete;
  bool did_accept_terms;
  bool did_validate_email;

  DocumentReference? size_doc_ref;
  DocumentReference? closet_doc_ref;

  UserModel({
    this.uid,
    this.email,
    this.created_time,
    this.birth_date,
    this.onboarding_complete = false,
    this.did_accept_terms = false,
    this.did_validate_email = false,
    this.size_model,
    this.closet_model,
    this.size_doc_ref,
    this.closet_doc_ref,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    DateTime? created_time,
    DateTime? birth_date,
    bool? onboarding_complete,
    bool? did_accept_terms,
    bool? did_validate_email,
    SizesModel? size_model,
    ClosetModel? closet_model,
    DocumentReference? size_doc_ref,
    DocumentReference? closet_doc_ref,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      created_time: created_time ?? this.created_time,
      birth_date: birth_date ?? this.birth_date,
      onboarding_complete: onboarding_complete ?? this.onboarding_complete,
      did_accept_terms: did_accept_terms ?? this.did_accept_terms,
      did_validate_email: did_validate_email ?? this.did_validate_email,
      size_model: size_model ?? this.size_model,
      closet_model: closet_model ?? this.closet_model,
      size_doc_ref: size_doc_ref ?? this.size_doc_ref,
      closet_doc_ref: closet_doc_ref ?? this.closet_doc_ref,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;

    return UserModel(
      uid: snap.id,
      email: data?['email'],
      created_time: timestampToDateTime(data?['created_time']),
      birth_date: timestampToDateTime(data?['birth_date']),
      onboarding_complete: data?['onboarding_complete'] ?? false,
      did_accept_terms: data?['did_accept_terms'] ?? false,
      did_validate_email: data?['did_validate_email'] ?? false,
      size_doc_ref: data?['size_doc_ref'],
      closet_doc_ref: data?['closet_doc_ref'],
      // You can similarly check for size_model and closet_model if they are included in the document
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'email': email,
      'created_time': created_time,
      'birth_date': birth_date,
      'onboarding_complete': onboarding_complete,
      'did_accept_terms': did_accept_terms,
      'did_validate_email': did_validate_email,
      'size_doc_ref': size_doc_ref,
      'closet_doc_ref': closet_doc_ref,
    };
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        created_time,
        birth_date,
        onboarding_complete,
        did_accept_terms,
        did_validate_email,
        size_model,
        closet_model,
        size_doc_ref,
        closet_doc_ref,
      ];
}
