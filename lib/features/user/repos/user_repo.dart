import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piece_of_happiness/features/user/models/user_model.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile({required UserModel user}) async {
    await _firestore.collection("users").doc(user.uid).set(user.toJson());
  }

  Future<Map<String, dynamic>?> getProfile(String uid) async {
    final doc = await _firestore.collection("users").doc(uid).get();

    return doc.data();
  }

  Future<void> updateProfile({
    required String uid,
    required Map<String, dynamic> data,
    required File file,
  }) async {
    if (file.path.isNotEmpty) {
      final fileRef = _storage.ref().child("profileImage/$uid");
      await fileRef.putFile(file);
    }
    await _firestore.collection("users").doc(uid).update(data);
  }
}

final userRepo = Provider(
  (ref) => UserRepo(),
);
