import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piece_of_happiness/features/home/models/piece_model.dart';

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

  Stream<List<PieceModel>> fetchPieces(String uid) {
    return _firestore
        .collection("pieces")
        .where("uid", isEqualTo: uid)
        .orderBy("date", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => PieceModel.fromJson(
                  json: doc.data(),
                ),
              )
              .toList(),
        );
  }

  Future<void> deletePiece(String id, String imagePath, String uid) async {
    await _firestore.collection("pieces").doc(id).delete();
    if (imagePath.isNotEmpty) {
      final path = Uri.parse(imagePath)
          .pathSegments[Uri.parse(imagePath).pathSegments.length - 1];
      await _storage.ref().child(path).delete();
    }
  }

  Future<void> deleteAllPieces(String uid) async {
    final pieces = await _firestore
        .collection("pieces")
        .where("uid", isEqualTo: uid)
        .get();

    for (var piece in pieces.docs) {
      await piece.reference.delete();
    }

    final folderRef = _storage.ref().child("images/$uid");
    final folderList = await folderRef.listAll();

    if (folderList.items.isNotEmpty) {
      for (var image in folderList.items) {
        await image.delete();
      }
    }
  }
}

final pieceRepo = Provider(
  (ref) => PieceRepo(),
);
