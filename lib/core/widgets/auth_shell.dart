import 'package:agent_pro/core/widgets/form_container_wrapper.dart';
import 'package:agent_pro/core/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'copyright.dart';

class AuthShell extends StatelessWidget {
  final Widget child;
  final String currentPath;

  const AuthShell({required this.child, required this.currentPath, super.key});

  @override
  Widget build(BuildContext context) {
    final isForgotPassword = currentPath.startsWith('/forgot-password');
    final isSignIn =
        currentPath == '/sign-in' ||
        isForgotPassword; // Show logo for both sign-in and forgot password flows
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: bottomInset + 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: .spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (isForgotPassword)
                    LinearProgressIndicator(
                      value: switch (currentPath) {
                        '/forgot-password/step-1' => 0.33,
                        '/forgot-password/step-2' => 0.66,
                        '/forgot-password/step-3' => 1.0,
                        _ => 0.0,
                      },
                    ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isSignIn ? const Logo() : const SizedBox.shrink(),
                  ),
                  FormContainerWrapper(child: child),
                  if (isSignIn) const Copyright(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
