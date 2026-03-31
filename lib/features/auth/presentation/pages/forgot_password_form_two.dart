import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/core/types/forgot_password_field.dart';
import 'package:agent_pro/features/auth/presentation/controllers/auth_controller.dart';
import 'package:agent_pro/features/auth/presentation/controllers/forgot_password_notifier.dart';
import 'package:agent_pro/features/auth/presentation/widgets/banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../widgets/auth_text.dart';

class ForgotPasswordFormTwo extends ConsumerStatefulWidget {
  const ForgotPasswordFormTwo({super.key});

  @override
  ConsumerState<ForgotPasswordFormTwo> createState() => _ForgotPasswordFormTwoState();
}

class _ForgotPasswordFormTwoState extends ConsumerState<ForgotPasswordFormTwo> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final seconds = ref.read(otpTimerProvider);
      if (seconds == 0) {
        ref.read(otpTimerProvider.notifier).start();
      }
    });
  }

  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email; // Invalid email, return as is
    final namePart = parts[0];
    final domainPart = parts[1];
    if (namePart.length <= 2) {
      return "${'*' * namePart.length}@$domainPart";
    }
    const visibleChars = 2;
    final maskedName = namePart.substring(0, visibleChars) + '*' * (namePart.length - visibleChars);
    return '$maskedName@$domainPart';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final forgotPasswordNotifier = ref.read(forgotPasswordProvider.notifier);
    final forgotPasswordMutation = ref.watch(forgotPasswordMutationProvider);
    final resendOtpMutation = ref.watch(resendOtpMutationProvider);
    final forgotPasswordMutationState = ref.watch(forgotPasswordMutation);
    final resendOtpMutationState = ref.watch(resendOtpMutation);
    final authController = ref.read(authControllerProvider.notifier);
    final seconds = ref.watch(otpTimerProvider);

    ref.listen(forgotPasswordMutation, (previous, next) {
      if (next is MutationSuccess) {
        context.go('/forgot-password/step-3');
      }
    });

    ref.listen(resendOtpMutation, (previous, next) {
      if (next is MutationSuccess) {
        ref.read(otpTimerProvider.notifier).start();
      }
      if (next is MutationError) {
        final error = (next as MutationError).error;
        if (error is RateLimitFailure) {
          ref.read(otpTimerProvider.notifier).start(seconds: error.coolDownSeconds);
        }
      }
    });

    final resendError = switch (resendOtpMutationState) {
      MutationError(:final error) when error is RateLimitFailure => error.message,
      MutationError() => "Une erreur est survenue. Veuillez réessayer.",
      _ => "",
    };

    final verificationFailure = switch (forgotPasswordMutationState) {
      MutationError(:final error) when error is Failure => error,
      _ => null,
    };

    final otpValidationError = forgotPasswordState.validationErrors[ForgotPasswordField.otp]?.match(
      () => null,
      (error) => error,
    );

    final bannerTitle = switch (verificationFailure) {
      ServerFailure(:final message) => message,
      Failure(:final message) => message,
      _ when otpValidationError != null => otpValidationError,
      _ => switch (resendOtpMutationState) {
        MutationError() => ((resendOtpMutationState as MutationError).error as Failure).message,
        _ => "Vérifier le code OTP",
      },
    };

    final bannerSubtitle = switch (verificationFailure) {
      ServerFailure() => "Vérifiez votre email et le code OTP puis réessayez.",
      Failure() => "Veuillez réessayer.",
      _ when otpValidationError != null => "Le code OTP doit contenir 6 chiffres.",
      _ => switch (resendOtpMutationState) {
        MutationError() => resendError,
        _ => "Code envoyé à ${_maskEmail(forgotPasswordState.email)}",
      },
    };

    return Column(
      spacing: 16,
      mainAxisSize: .min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AuthText(
          title: "Mot de passe oublié",
          subtitle: "Entrez le code à 6 chiffres reçu par e-mail.",
        ),
        CustomBanner(
          icon: verificationFailure != null || otpValidationError != null
              ? Icons.error_outline
              : Icons.password,
          title: bannerTitle,
          subtitle: bannerSubtitle,
        ),
        Pinput(
          length: 6,
          defaultPinTheme: PinTheme(
            width: 48,
            height: 48,
            textStyle: textTheme.bodyLarge!.copyWith(
              color: colorScheme.secondaryContainer,
              fontWeight: FontWeight.w600,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              border: Border.all(color: colorScheme.outline),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          focusedPinTheme: PinTheme(
            width: 48,
            height: 48,
            textStyle: textTheme.titleMedium!.copyWith(
              color: colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w600,
            ),
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              border: Border.all(color: colorScheme.secondary, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          errorPinTheme: PinTheme(
            width: 48,
            height: 48,
            textStyle: textTheme.titleMedium!.copyWith(color: colorScheme.onErrorContainer),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              border: Border.all(color: colorScheme.error, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: forgotPasswordNotifier.setOtp,
        ),

        Row(
          mainAxisSize: .min,
          children: [
            Row(
              mainAxisSize: .min,
              mainAxisAlignment: .spaceBetween,
              spacing: 4,
              children: [
                Icon(Icons.hourglass_bottom, color: colorScheme.surfaceDim, size: 16),
                Text(
                  "Expire dans 10 min",
                  overflow: .fade,
                  style: textTheme.labelMedium!.copyWith(color: colorScheme.onPrimaryContainer),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Row(
              mainAxisSize: .min,
              mainAxisAlignment: .end,
              spacing: 4,
              children: [
                Icon(Icons.restart_alt_rounded, color: colorScheme.inversePrimary, size: 16),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(40, 24),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: seconds > 0 || resendOtpMutationState is MutationPending
                      ? null
                      : () async {
                          await authController.resendOtp();
                        },
                  child: Text(
                    "Renvoyer OTP ${seconds > 0 ? '(${seconds}s)' : ''}",
                    style: textTheme.labelMedium!.copyWith(
                      color: (seconds > 0)
                          ? colorScheme.onPrimaryContainer.withValues(alpha: 0.5)
                          : colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                context.go("/forgot-password/step-1");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.tertiary,
                minimumSize: const Size(132, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              icon: Icon(Icons.arrow_back, color: colorScheme.onTertiary),
              label: Text(
                'Retour',
                style: textTheme.titleMedium!.copyWith(color: colorScheme.onTertiary),
              ),
            ),
            const Expanded(child: SizedBox()),
            ElevatedButton.icon(
              onPressed:
                  !forgotPasswordNotifier.isValidPageTwo ||
                      forgotPasswordMutationState is MutationPending
                  ? null
                  : () async {
                      try {
                        await authController.sendOtp();
                      } on Failure {
                        // The mutation error state is rendered in the banner.
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                minimumSize: const Size(176, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              icon: Icon(Icons.check, color: colorScheme.onPrimary),
              label: switch (forgotPasswordMutationState) {
                MutationPending() => Text(
                  'Vérification...',
                  style: textTheme.titleMedium!.copyWith(color: colorScheme.onPrimary),
                ),
                _ => Text(
                  "Vérifier",
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
