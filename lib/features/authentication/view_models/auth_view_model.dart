import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:piece_of_happiness/features/authentication/repos/auth_repo.dart';
import 'package:piece_of_happiness/features/home/views/home_screen.dart';
import 'package:piece_of_happiness/features/user/view_models/user_view_model.dart';

class AuthViewModel extends AsyncNotifier {
  late final AuthRepo _authRepo;

  @override
  FutureOr build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp({
    required Map<String, String> form,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();
    final user = ref.read(userProvider.notifier);

    state = await AsyncValue.guard(
      () async {
        final userCredential = await _authRepo.signUp(
          email: form["email"]!,
          password: form["password"]!,
        );

        await user.createProfile(
          userCredential: userCredential,
          name: form["name"]!,
          email: form["email"]!,
        );
      },
    );

    if (state.hasError) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            (state.error as FirebaseException).message ?? "잠시 후에 다시 시도해 주세요.",
          ),
        ),
      );
    } else {
      if (!context.mounted) return;
      context.go(HomeScreen.routeUrl);
    }
  }

  Future<void> signIn({
    required Map<String, String> form,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _authRepo.signIn(
        email: form["email"]!,
        password: form["password"]!,
      );
    });

    if (state.hasError) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            (state.error as FirebaseException).message ?? "잠시 후에 다시 시도해 주세요.",
          ),
        ),
      );
    } else {
      if (!context.mounted) return;
      context.go(HomeScreen.routeUrl);
    }
  }
}

final authProvider = AsyncNotifierProvider<AuthViewModel, void>(
  () => AuthViewModel(),
);
