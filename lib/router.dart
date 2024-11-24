import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:piece_of_happiness/features/authentication/repos/auth_repo.dart';
import 'package:piece_of_happiness/features/authentication/views/sign_in_screen.dart';
import 'package:piece_of_happiness/features/authentication/views/sign_up_screen.dart';
import 'package:piece_of_happiness/features/home/views/home_screen.dart';
import 'package:piece_of_happiness/features/settings/views/settings_screen.dart';
import 'package:piece_of_happiness/features/user/views/edit_profile_screen.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: HomeScreen.routeUrl,
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;

        if (isLoggedIn) return null;

        if (!isLoggedIn) {
          if (state.matchedLocation != SignInScreen.routeUrl &&
              state.matchedLocation != SignUpScreen.routeUrl) {
            return SignInScreen.routeUrl;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          path: SignInScreen.routeUrl,
          name: SignInScreen.routeName,
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: SignUpScreen.routeUrl,
          name: SignUpScreen.routeName,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: HomeScreen.routeUrl,
          name: HomeScreen.routeName,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const HomeScreen(),
            transitionDuration: const Duration(
              milliseconds: 250,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final opacity = Tween(
                begin: 0.0,
                end: 1.0,
              ).animate(animation);

              return FadeTransition(
                opacity: opacity,
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: EditProfileScreen.routeUrl,
          name: EditProfileScreen.routeName,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const EditProfileScreen(),
            transitionDuration: const Duration(
              milliseconds: 250,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final position = Tween(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation);

              return SlideTransition(
                position: position,
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: SettingsScreen.routeUrl,
          name: SettingsScreen.routeName,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const SettingsScreen(),
            transitionDuration: const Duration(
              milliseconds: 250,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final position = Tween(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation);

              return SlideTransition(
                position: position,
                child: child,
              );
            },
          ),
        ),
      ],
    );
  },
);
