import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piece_of_happiness/features/user/models/user_model.dart';

class UserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createProfile({required UserModel user}) async {
    await _firestore.collection("users").doc(user.uid).set(user.toJson());
  }
}

final userRepo = Provider(
  (ref) => UserRepo(),
);
