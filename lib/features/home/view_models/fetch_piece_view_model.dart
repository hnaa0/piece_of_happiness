import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piece_of_happiness/features/authentication/repos/auth_repo.dart';
import 'package:piece_of_happiness/features/home/models/piece_model.dart';
import 'package:piece_of_happiness/features/home/repos/piece_repo.dart';

class FetchPieceViewModel extends StreamNotifier<List<PieceModel>> {
  late final PieceRepo _pieceRepo;
  late final AuthRepo _authRepo;

  @override
  Stream<List<PieceModel>> build() {
    _pieceRepo = ref.read(pieceRepo);
    _authRepo = ref.read(authRepo);

    return fetchPieces();
  }

  Stream<List<PieceModel>> fetchPieces() {
    final user = _authRepo.user!;

    return _pieceRepo.fetchPieces(user.uid);
  }

  Future<void> deletePiece(String id, String imagePath) async {
    await _pieceRepo.deletePiece(id, imagePath, _authRepo.user!.uid);
  }
}

final fetchPieceProvider =
    StreamNotifierProvider<FetchPieceViewModel, List<PieceModel>>(
  () => FetchPieceViewModel(),
);
