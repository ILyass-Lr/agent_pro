import 'package:agent_pro/core/widgets/auth_shell.dart';
import 'package:agent_pro/core/services/auth_status_notifier.dart';
import 'package:agent_pro/features/auth/presentation/pages/forgot_password_form_one.dart';
import 'package:agent_pro/features/auth/presentation/pages/forgot_password_form_three.dart';
import 'package:agent_pro/features/auth/presentation/pages/forgot_password_form_two.dart';
import 'package:agent_pro/features/auth/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/pages/onboarding_screen.dart';
import '../../features/auth/presentation/pages/sign_in_form.dart';
import '../../features/auth/presentation/pages/sign_up_form_one.dart';
import '../../features/auth/presentation/pages/sign_up_form_two.dart';
import '../widgets/background_wrapper.dart';
import '../services/app_settings_service.dart';

part 'router_provider.g.dart';

NoTransitionPage<void> _noTransitionPage({required LocalKey key, required Widget child}) {
  return NoTransitionPage<void>(key: key, child: child);
}

Widget _withBackRedirect(BuildContext context, Widget child, String? backTo) {
  if (backTo == null) return child;

  return PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) {
      if (didPop) return;
      FocusManager.instance.primaryFocus?.unfocus();
      context.go(backTo);
    },
    child: child,
  );
}

@riverpod
GoRouter router(Ref ref) {
  final appSettings = ref.watch(appSettingServiceProvider);
  final authState = ref.watch(authStatusProvider);
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isFirstOpen = appSettings.isFirstOpen;
      final isAuthenticated = authState.maybeWhen(authenticated: (_) => true, orElse: () => false);
      final currentPath = state.matchedLocation;
      final isAuthRoute =
          currentPath.startsWith('/sign') || currentPath.startsWith('/forgot-password');
      final isOnboardingRoute = currentPath == '/onboarding';

      if (currentPath == '/') {
        if (isFirstOpen) return '/onboarding';
        if (isAuthenticated) return '/home';
        return '/sign-in';
      }

      // 1. First-time users should go to onboarding
      if (isFirstOpen && !isOnboardingRoute) {
        return '/onboarding';
      }
      // 2. Onboarding done, but not authenticated users should go to sign-in
      if (!isFirstOpen && !isAuthenticated && !isAuthRoute) {
        return '/sign-in';
      }
      // 3. Authenticated users should not access auth routes
      if (isAuthenticated && isAuthRoute) {
        return '/home';
      }

      return null; // No redirection needed
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) => BackgroundWrapper(child: child),
        routes: [
          GoRoute(
            path: '/onboarding',
            pageBuilder: (context, state) =>
                _noTransitionPage(key: state.pageKey, child: const OnboardingScreen()),
          ),
          ShellRoute(
            builder: (context, state, child) =>
                AuthShell(currentPath: state.matchedLocation, child: child),
            routes: [
              GoRoute(
                path: '/sign-in',
                pageBuilder: (context, state) {
                  final extra = state.extra as ({String title, String subtitle})?;

                  return _noTransitionPage(
                    key: state.pageKey,
                    child: SignInForm(successMessage: extra),
                  );
                },
              ),
              GoRoute(
                path: '/sign-up/step-1',
                pageBuilder: (context, state) => _noTransitionPage(
                  key: state.pageKey,
                  child: _withBackRedirect(context, const SignUpFormOne(), '/sign-in'),
                ),
              ),
              GoRoute(
                path: '/sign-up/step-2',
                pageBuilder: (context, state) => _noTransitionPage(
                  key: state.pageKey,
                  child: _withBackRedirect(context, const SignUpFormTwo(), '/sign-up/step-1'),
                ),
              ),
              GoRoute(
                path: '/forgot-password/step-1',
                pageBuilder: (context, state) => _noTransitionPage(
                  key: state.pageKey,
                  child: _withBackRedirect(context, const ForgotPasswordFormOne(), '/sign-in'),
                ),
              ),
              GoRoute(
                path: '/forgot-password/step-2',
                pageBuilder: (context, state) => _noTransitionPage(
                  key: state.pageKey,
                  child: _withBackRedirect(
                    context,
                    const ForgotPasswordFormTwo(),
                    '/forgot-password/step-1',
                  ),
                ),
              ),
              GoRoute(
                path: '/forgot-password/step-3',
                pageBuilder: (context, state) => _noTransitionPage(
                  key: state.pageKey,
                  child: _withBackRedirect(context, const ForgotPasswordFormThree(), '/sign-in'),
                ),
              ),
            ],
          ),
        ],
      ),
      // Define other app routes here, e.g. home, profile, etc.
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) =>
            _noTransitionPage(key: state.pageKey, child: const WelcomePage()),
      ),
    ],
  );
}
