import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:piece_of_happiness/features/authentication/repos/auth_repo.dart';
import 'package:piece_of_happiness/features/authentication/views/sign_in_screen.dart';
import 'package:piece_of_happiness/features/authentication/views/sign_up_screen.dart';
import 'package:piece_of_happiness/features/home/views/home_screen.dart';
import 'package:piece_of_happiness/features/settings/views/settings_screen.dart';

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
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: SettingsScreen.routeUrl,
          name: SettingsScreen.routeName,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    );
  },
);
