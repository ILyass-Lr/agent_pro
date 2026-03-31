import 'package:agent_pro/core/types/forgot_password_field.dart';
import 'package:agent_pro/features/auth/presentation/controllers/auth_controller.dart';
import 'package:agent_pro/features/auth/presentation/controllers/forgot_password_notifier.dart';
import 'package:agent_pro/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/auth_text.dart';

class ForgotPasswordFormThree extends ConsumerWidget {
  const ForgotPasswordFormThree({super.key});
  // void _listenForgotPasswordMutation(Mutation<Unit> signInMutation) {

  // }

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
        context.go(
          '/sign-in',
          extra: (
            title: "Mot de passe réinitialisé",
            subtitle: "Votre mot de passe a été réinitialisé avec succès.\nVeuillez vous connecter",
          ),
        );
      }
    });
    return Column(
      spacing: 16,
      mainAxisSize: .min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AuthText(
          title: "Mot de passe oublié",
          subtitle: "Veuillez entrer votre nouveau mot de passe.",
        ),

        CustomTextField(
          onChanged: forgotPasswordNotifier.setPassword,
          state: forgotPasswordState,
          field: ForgotPasswordField.password,
          valueSelector: (state, field) => switch (field) {
            ForgotPasswordField.email => state.email,
            ForgotPasswordField.password => state.password,
            ForgotPasswordField.confirmPassword => state.confirmPassword,
            ForgotPasswordField.otp => state.otp,
          },
          errorTextSelector: (state, field) =>
              state.validationErrors[field]?.match(() => null, (error) => error),
          labelText: "Nouveau mot de passe*",
          hintText: "Entrez un nouveau mot de passe",
          prefixIcon: Icon(Icons.lock_outline, color: colorScheme.inversePrimary),
          isPasswordField: true,
          maxLength: 50,
        ),
        CustomTextField(
          onChanged: forgotPasswordNotifier.setConfirmPassword,
          state: forgotPasswordState,
          field: ForgotPasswordField.confirmPassword,
          valueSelector: (state, field) => switch (field) {
            ForgotPasswordField.email => state.email,
            ForgotPasswordField.password => state.password,
            ForgotPasswordField.confirmPassword => state.confirmPassword,
            ForgotPasswordField.otp => state.otp,
          },
          errorTextSelector: (state, field) =>
              state.validationErrors[field]?.match(() => null, (error) => error),
          labelText: "Confirmer mot de passe*",
          hintText: "Entrez votre mot de passe",
          prefixIcon: Icon(Icons.lock_outline, color: colorScheme.inversePrimary),
          isPasswordField: true,
          maxLength: 50,
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
                      await authController.resetPassword();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                minimumSize: const Size(176, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              icon: forgotPasswordMutationState is MutationPending
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 1, color: Colors.white),
                    )
                  : Icon(Icons.key, color: colorScheme.onPrimary),
              label: Text(
                "Réinitialiser",
                style: textTheme.titleMedium!.copyWith(color: colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
