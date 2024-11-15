import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piece_of_happiness/features/authentication/repos/auth_repo.dart';
import 'package:piece_of_happiness/features/home/repos/piece_repo.dart';

class UploadPieceViewModel extends AsyncNotifier<void> {
  late final AuthRepo _authRepo;
  late final PieceRepo _pieceRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
    _pieceRepo = ref.read(pieceRepo);
  }

  Future<void> uploadPiece({
    required File image,
    required String text,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();

    final user = _authRepo.user!;
    String imageUrl = "";

    state = await AsyncValue.guard(
      () async {
        if (image.path.isNotEmpty) {
          final task =
              await _pieceRepo.uploadImageFile(image: image, uid: user.uid);
          imageUrl = await task.ref.getDownloadURL();
        }

        await _pieceRepo.uploadPiece(
          text: text,
          imageUrl: imageUrl,
          uid: user.uid,
        );
      },
    );

    // if (state.hasError) {
    //   if (!context.mounted) return;
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         (state.error as FirebaseException).message ?? "잠시 후에 다시 시도해 주세요.",
    //       ),
    //     ),
    //   );
    // }
  }
}

final uploadPieceProvider = AsyncNotifierProvider<UploadPieceViewModel, void>(
  () => UploadPieceViewModel(),
);
