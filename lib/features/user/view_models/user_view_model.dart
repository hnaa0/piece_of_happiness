import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piece_of_happiness/features/authentication/repos/auth_repo.dart';
import 'package:piece_of_happiness/features/user/models/user_model.dart';
import 'package:piece_of_happiness/features/user/repos/user_repo.dart';

class UserViewModel extends AsyncNotifier<UserModel> {
  late final UserRepo _userRepo;
  late final AuthRepo _authRepo;

  @override
  FutureOr<UserModel> build() async {
    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);

    if (_authRepo.isLoggedIn) {
      final profile = await _userRepo.getProfile(_authRepo.user!.uid);
      if (profile != null) {
        return UserModel.fromJson(profile);
      }
    }

    return UserModel.empty();
  }

  Future<void> createProfile({
    required UserCredential userCredential,
    required String name,
    required String email,
  }) async {
    state = const AsyncValue.loading();

    final profile = UserModel(
      name: name,
      email: email,
      uid: userCredential.user!.uid,
      hasProfileImage: false,
    );

    _userRepo.createProfile(user: profile);
  }

  Future<void> getProfile() async {
    state = const AsyncValue.loading();
    final user = _authRepo.user!;

    state = await AsyncValue.guard(
      () async {
        final profile = await _userRepo.getProfile(user.uid);

        if (profile != null) {
          return UserModel.fromJson(profile);
        } else {
          return UserModel.empty();
        }
      },
    );
  }

  Future<void> editProfile({
    required String name,
    required File file,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final Map<String, dynamic> data = {
          "name": name,
        };

        if (file.path.isNotEmpty) {
          data["hasProfileImage"] = true;
        }

        await _userRepo.updateProfile(
          uid: _authRepo.user!.uid,
          data: data,
          file: file,
        );

        return state.value!.copyWith(
          name: name,
          hasProfileImage: true,
        );
      },
    );

    if (state.hasError) {
      if (!context.mounted) return;
      final errorMessage = (state.error is FirebaseException)
          ? (state.error as FirebaseException).message
          : "프로필을 수정할 수 없습니다. 잠시 후 다시 시도해 주세요.";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage ?? "프로필을 수정할 수 없습니다. 잠시 후 다시 시도해 주세요.",
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      );
    }
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserModel>(
  () => UserViewModel(),
);
