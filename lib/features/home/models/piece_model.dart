import 'package:cloud_firestore/cloud_firestore.dart';

class PieceModel {
  final String text;
  final String id;
  final String imageUrl;
  final String uid;
  final DateTime date;

  PieceModel({
    required this.text,
    required this.id,
    required this.imageUrl,
    required this.uid,
    required this.date,
  });

  PieceModel.fromJson({required Map<String, dynamic> json})
      : text = json["text"],
        id = json["id"],
        imageUrl = json["imageUrl"],
        uid = json["uid"],
        date = (json["date"] as Timestamp).toDate();
}
