import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PieceRepo {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UploadTask uploadImageFile({
    required File image,
    required String uid,
  }) {
    final fileRef = _storage.ref().child(
        "/images/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}");
    return fileRef.putFile(image);
  }

  Future<void> uploadPiece({
    required String text,
    required String imageUrl,
    required String uid,
  }) async {
    final piece = {
      "text": text,
      "date": FieldValue.serverTimestamp(),
      "uid": uid,
      "imageUrl": imageUrl,
    };
    final docRef = await _firestore.collection("pieces").add(piece);
    final docId = docRef.id;

    await _firestore.collection("pieces").doc(docId).update({
      "id": docId,
    });
  }
}

final pieceRepo = Provider(
  (ref) => PieceRepo(),
);
