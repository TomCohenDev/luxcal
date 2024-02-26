import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:revampedai/aaasrc/models/sizes_model.dart';

abstract class BaseSizesRepository {
  Future<SizesModel?> getSizes(String uid);
  Future<void> createSizes(SizesModel sizes);
  Future<void> updateSizes(SizesModel sizes);
}

class SizesRepository extends BaseSizesRepository {
  final FirebaseFirestore _firebaseFirestore;

  SizesRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<SizesModel?> getSizes(String uid) async {
    try {
      DocumentSnapshot snap =
          await _firebaseFirestore.collection('sizes').doc(uid).get();
      if (snap.exists) {
        return SizesModel.fromSnapshot(snap);
      }
    } catch (e) {
      print('Error getting size data: $e');
    }
    return null; // Return null if sizes data doesn't exist or on error
  }

  @override
  Future<void> createSizes(SizesModel sizes) async {
    try {
      bool sizesExists =
          (await _firebaseFirestore.collection('sizes').doc(sizes.uid).get())
              .exists;
      if (!sizesExists) {
        print('Creating new sizes data');
        await _firebaseFirestore
            .collection('sizes')
            .doc(sizes.uid)
            .set(sizes.toDocument());
      }
    } catch (e) {
      print('Error creating sizes data: $e');
    }
  }

  @override
  Future<void> updateSizes(SizesModel sizes) async {
    try {
      print('Updating sizes data');
      await _firebaseFirestore
          .collection('sizes')
          .doc(sizes.uid)
          .update(sizes.toDocument());
    } catch (e) {
      print('Error updating sizes data: $e');
    }
  }
}
