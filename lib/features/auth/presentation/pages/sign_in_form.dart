import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/core/types/agent_status.dart';
import 'package:agent_pro/core/types/sign_in_field.dart';
import 'package:agent_pro/features/auth/domain/entities/agent.dart';
import 'package:agent_pro/features/auth/presentation/controllers/auth_controller.dart';
import 'package:agent_pro/core/services/auth_status_notifier.dart';
import 'package:agent_pro/features/auth/presentation/controllers/forgot_password_notifier.dart';
import 'package:agent_pro/features/auth/presentation/controllers/sign_in_notifier.dart';
import 'package:agent_pro/features/auth/presentation/widgets/banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/experimental/mutation.dart';

import '../widgets/auth_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/redirection_text.dart';

class SignInForm extends ConsumerStatefulWidget {
  final ({String title, String subtitle})? successMessage;
  const SignInForm({this.successMessage, super.key});

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  String? _transientAuthMessage;

  @override
  void initState() {
    super.initState();
    // Show success message if coming from sign-up flow and invalidate sign-up state to reset the form
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.invalidate(signUpMutationProvider);
      ref.invalidate(forgotPasswordProvider);
      final consumedMessage = ref.read(authStatusProvider.notifier).consumeLogoutMessage();
      if (consumedMessage != null) {
        setState(() {
          _transientAuthMessage = consumedMessage;
        });
        Future<void>.delayed(const Duration(seconds: 6), () {
          if (!mounted) return;
          setState(() {
            _transientAuthMessage = null;
          });
        });
      }
      if (widget.successMessage != null) {
        _showSuccessSnackBar(widget.successMessage!.title, widget.successMessage!.subtitle);
      }
    });
  }

  void _showSuccessSnackBar(String title, String subtitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, color: Theme.of(context).colorScheme.inversePrimary),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      ),
    );
  }

  IconData _iconBasedOnStatus(Failure failure) {
    if (failure is UnauthorizedFailure) {
      switch (failure.status) {
        case Status.pending:
          return Icons.hourglass_top;

        case Status.suspended:
          return Icons.back_hand;
        case Status.rejected:
          return Icons.block;
        default:
          return Icons.error_outline;
      }
    } else if (failure is NetworkFailure) {
      return Icons.wifi_off;
    } else {
      return Icons.error_outline;
    }
  }

  void _listenSignInMutation(Mutation<Agent> signInMutation) {
    ref.listen(signInMutation, (previous, next) {
      if (next is MutationSuccess) {
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final signInState = ref.watch(signInProvider);
    final signInNotifier = ref.read(signInProvider.notifier);
    final signInMutation = ref.watch(signInMutationProvider);
    final signInMutationState = ref.watch(signInMutation);
    _listenSignInMutation(signInMutation);
    final error = signInMutationState is MutationError
        ? (signInMutationState as MutationError).error as Failure
        : null;
    final sessionExpiredMessage = _transientAuthMessage;

    final formContent = Column(
      spacing: 16,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const AuthText(title: "Connexion", subtitle: "Accédez à votre espace professionnel"),
        if (signInMutationState is MutationError)
          CustomBanner(
            icon: _iconBasedOnStatus(error!),
            title: switch (error) {
              UnauthorizedFailure(status: Status.pending) => "Compte en cours de validation",
              _ => error.message,
            },
            subtitle: switch (error) {
              UnauthorizedFailure(:final reason) => reason,
              _ => null,
            },
          )
        else if (sessionExpiredMessage != null)
          CustomBanner(icon: Icons.info_outline, title: sessionExpiredMessage),

        CustomTextField(
          state: signInState,
          field: SignInField.email,
          valueSelector: (state, field) => switch (field) {
            SignInField.email => state.email,
            SignInField.password => state.password,
          },
          errorTextSelector: (state, field) =>
              state.validationErrors[field]?.match(() => null, (error) => error),
          onChanged: signInNotifier.setEmail,
          labelText: "Email*",
          hintText: "joe.doe@gmail.com",
          prefixIcon: Icon(Icons.email_outlined, color: colorScheme.inversePrimary),
          maxLength: null,
        ),
        CustomTextField(
          onChanged: signInNotifier.setPassword,
          state: signInState,
          field: SignInField.password,
          valueSelector: (state, field) => switch (field) {
            SignInField.email => state.email,
            SignInField.password => state.password,
          },
          errorTextSelector: (state, field) =>
              state.validationErrors[field]?.match(() => null, (error) => error),
          labelText: "Mot de passe*",
          hintText: "Entrez votre mot de passe",
          prefixIcon: Icon(Icons.lock_outline, color: colorScheme.inversePrimary),
          isPasswordField: true,
          maxLength: null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Checkbox(
                    value: signInState.rememberMe,
                    onChanged: (value) {
                      signInNotifier.toggleRememberMe();
                    },
                  ),
                ),
                Text(
                  'Se souvenir de moi',
                  style: textTheme.labelSmall!.copyWith(color: colorScheme.onPrimaryContainer),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            TextButton(
              onPressed: () {
                context.go("/forgot-password/step-1");
              },
              child: Text(
                "Mot de passe oublié ?",
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: signInNotifier.isValidForm
              ? () async {
                  try {
                    await ref.read(authControllerProvider.notifier).performSignIn();
                  } catch (_) {}
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: signInMutationState is MutationPending
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(colorScheme.onPrimaryContainer),
                  ),
                )
              : Text(
                  "Accéder au Dashboard",
                  style: textTheme.titleMedium!.copyWith(color: colorScheme.onPrimary),
                ),
        ),
        Divider(color: colorScheme.tertiary),
        const RedirectionText(
          label: "Nouveau sur AgentPro ?",
          redirectionText: "Demander un accès",
          path: "/sign-up/step-1",
        ),
      ],
    );

    return SingleChildScrollView(
      primary: false,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: formContent,
    );
  }
}
