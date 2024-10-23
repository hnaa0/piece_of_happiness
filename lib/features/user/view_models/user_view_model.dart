import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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
    );

    _userRepo.createProfile(user: profile);
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserModel>(
  () => UserViewModel(),
);
