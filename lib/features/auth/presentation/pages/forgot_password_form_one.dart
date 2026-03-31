import 'package:agent_pro/core/types/forgot_password_field.dart';
import 'package:agent_pro/features/auth/presentation/controllers/auth_controller.dart';
import 'package:agent_pro/features/auth/presentation/controllers/forgot_password_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/auth_text.dart';
import '../widgets/custom_text_field.dart';

class ForgotPasswordFormOne extends ConsumerWidget {
  const ForgotPasswordFormOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final forgotPasswordNotifier = ref.read(forgotPasswordProvider.notifier);
    final forgotPasswordMutation = ref.watch(forgotPasswordMutationProvider);
    final forgotPasswordMutationState = ref.watch(forgotPasswordMutation);
    final authController = ref.read(authControllerProvider.notifier);
    ref.listen(forgotPasswordMutation, (previous, next) {
      if (next is MutationSuccess) {
        context.go('/forgot-password/step-2');
      }
    });
    return Column(
      spacing: 16,
      mainAxisSize: .min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AuthText(
          title: "Mot de passe oublié",
          subtitle:
              "Entrez l'adresse e-mail sur laquelle vous recevrez le code de vérification pour réinitialiser votre mot de passe.",
        ),
        CustomTextField(
          state: forgotPasswordState,
          field: ForgotPasswordField.email,
          valueSelector: (state, _) => state.email,
          errorTextSelector: (state, field) =>
              state.validationErrors[field]?.match(() => null, (error) => error),
          onChanged: forgotPasswordNotifier.setEmail,
          labelText: "Email",
          hintText: "Entrez votre adresse e-mail",
          prefixIcon: Icon(Icons.email_outlined, color: colorScheme.inversePrimary),
          maxLength: 254,
        ),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                context.go("/sign-in");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.tertiary,
                minimumSize: const Size(132, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              icon: Icon(Icons.arrow_back, color: colorScheme.onTertiary),
              label: Text(
                'Annuler',
                style: textTheme.titleMedium!.copyWith(color: colorScheme.onTertiary),
              ),
            ),
            const Expanded(child: SizedBox()),
            ElevatedButton.icon(
              onPressed:
                  !forgotPasswordNotifier.isValidPageOne ||
                      forgotPasswordMutationState is MutationPending
                  ? null
                  : () async {
                      await authController.sendPasswordResetEmail();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                minimumSize: const Size(176, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),

              label: switch (forgotPasswordMutationState) {
                MutationPending() => Text(
                  'Envoi du code...',
                  style: textTheme.titleMedium!.copyWith(color: colorScheme.onPrimary),
                ),
                _ => Text(
                  "Envoyer Code",
                  style: textTheme.titleMedium!.copyWith(color: colorScheme.onPrimary),
                ),
              },
            ),
          ],
        ),
      ],
    );
  }
}
