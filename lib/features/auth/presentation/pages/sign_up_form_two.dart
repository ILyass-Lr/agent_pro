import 'dart:async';
import 'dart:io';

import 'package:agent_pro/core/types/sign_up_field.dart';
import 'package:agent_pro/features/auth/presentation/controllers/sign_in_notifier.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';

import '../../../../core/error/failure.dart';
import '../controllers/auth_controller.dart';
import '../controllers/sign_up_notifier.dart';
import '../widgets/auth_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/redirection_text.dart';
import '../widgets/banner.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class SignUpFormTwo extends ConsumerStatefulWidget {
  const SignUpFormTwo({super.key});

  @override
  ConsumerState<SignUpFormTwo> createState() => _SignUpFormTwoState();
}

class _SignUpFormTwoState extends ConsumerState<SignUpFormTwo> {
  late final TapGestureRecognizer _termsTapRecognizer;
  late final TapGestureRecognizer _privacyTapRecognizer;

  @override
  void initState() {
    super.initState();
    _termsTapRecognizer = TapGestureRecognizer()
      ..onTap = () => _showInfoBottomSheet(
        title: "Conditions d'utilisation",
        description:
            "En créant un compte, vous confirmez que les informations fournies sont exactes et à jour. "
            "Votre dossier peut etre verifie avant activation complete du compte. "
            "Vous vous engagez a utiliser la plateforme conformement a la loi et a ne pas partager vos accès.",
      );

    _privacyTapRecognizer = TapGestureRecognizer()
      ..onTap = () => _showInfoBottomSheet(
        title: "Politique de confidentialite",
        description:
            "Nous collectons uniquement les donnees nécessaires à la création et la verification de votre compte "
            "(identité, contact et justificatifs professionnels). "
            "Ces donnesé sont utilisées pour securiser le service, ne sont pas vendues, "
            "et sont protegees selon nos standards de securite.",
      );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.invalidate(signInProvider);
    });
  }

  @override
  void dispose() {
    _termsTapRecognizer.dispose();
    _privacyTapRecognizer.dispose();
    super.dispose();
  }

  Future<void> _showInfoBottomSheet({required String title, required String description}) async {
    if (!mounted) return;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    await showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Text(
                title,
                style: textTheme.titleLarge!.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                description,
                style: textTheme.bodyMedium!.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.85),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Fermer'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getFileSizeString(String filePath) {
    if (filePath.isEmpty) return "";
    try {
      final file = File(filePath);
      final sizeInBytes = file.lengthSync();
      if (sizeInBytes < 1024) {
        return "$sizeInBytes B";
      } else if (sizeInBytes < 1024 * 1024) {
        return "${(sizeInBytes / 1024).toStringAsFixed(1)} KB";
      } else {
        return "${(sizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB";
      }
    } catch (e) {
      return "Unknown size";
    }
  }

  void _listenSignUpMutation({
    required Mutation<Unit> signUpMutation,
    required SignUpNotifier signUpNotifier,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    ref.listen(signUpMutation, (previous, next) {
      if (next is MutationSuccess) {
        unawaited(signUpNotifier.clearPersistedDraft());
        context.go(
          "/sign-in",
          extra: (
            title: "Compte soumis à la vérification",
            subtitle: "Surveillez votre boîte mail",
          ),
        );
      } else if (next is MutationError) {
        final error = (next as MutationError).error;
        String msg = "Une erreur inattendue est survenue.\nVeuillez réessayer.";
        if (error is ServerFailure && error.field != null) {
          // 1. Set the validation error for the specific field
          signUpNotifier.setValidationError(error.field!, error.message);
          // 2. Smart Navgation based on where the field lives
          if ([
            SignUpField.firstName,
            SignUpField.lastName,
            SignUpField.email,
            SignUpField.phoneNumber,
            SignUpField.password,
            SignUpField.confirmPassword,
          ].contains(error.field!)) {
            context.go("/sign-up/step-1");
            msg = "Veuillez corriger les informations personnelles.";
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            elevation: 8,
            content: Row(
              mainAxisAlignment: .start,
              spacing: 8,
              children: [
                Icon(Icons.error_outline, color: colorScheme.inversePrimary),
                Text(
                  msg,
                  style: textTheme.titleSmall!.copyWith(
                    color: colorScheme.inversePrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            backgroundColor: colorScheme.inverseSurface,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const white = Colors.white;
    final textTheme = theme.textTheme;
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);
    final uploadError = signUpState.validationErrors[SignUpField.licenseFilePath];
    final signUpMutation = ref.watch(signUpMutationProvider);
    final authMutation = ref.watch(signUpMutation);

    _listenSignUpMutation(
      signUpMutation: signUpMutation,
      signUpNotifier: signUpNotifier,
      colorScheme: colorScheme,
      textTheme: textTheme,
    );
    final formContent = Column(
      spacing: 16,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AuthText(title: "Inscription", subtitle: "Informations Professionnelles"),
        CustomTextField(
          state: signUpState,
          field: SignUpField.agencyName,
          valueSelector: (state, field) => switch (field) {
            SignUpField.firstName => state.firstName,
            SignUpField.lastName => state.lastName,
            SignUpField.email => state.email,
            SignUpField.phoneNumber => state.phoneNumber,
            SignUpField.password => state.password,
            SignUpField.confirmPassword => state.confirmPassword,
            SignUpField.agencyName => state.agencyName,
            SignUpField.licenseNumber => state.licenseNumber,
            SignUpField.licenseFilePath => state.licenseFilePath,
            SignUpField.terms => '',
          },
          errorTextSelector: (state, field) =>
              state.validationErrors[field]?.match(() => null, (error) => error),
          onChanged: signUpNotifier.setAgencyName,
          labelText: "Nom de l'agence",
          hintText: "Nom de votre agence",
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/icons/agency.svg",
              height: 24,
              width: 24,
              // width: 24,
              colorFilter: ColorFilter.mode(colorScheme.inversePrimary, BlendMode.srcIn),
            ),
          ),
          helperText: "*requis",
          maxLength: 50,
        ),
        CustomTextField(
          state: signUpState,
          field: SignUpField.licenseNumber,
          valueSelector: (state, field) => switch (field) {
            SignUpField.firstName => state.firstName,
            SignUpField.lastName => state.lastName,
            SignUpField.email => state.email,
            SignUpField.phoneNumber => state.phoneNumber,
            SignUpField.password => state.password,
            SignUpField.confirmPassword => state.confirmPassword,
            SignUpField.agencyName => state.agencyName,
            SignUpField.licenseNumber => state.licenseNumber,
            SignUpField.licenseFilePath => state.licenseFilePath,
            SignUpField.terms => '',
          },
          errorTextSelector: (state, field) =>
              state.validationErrors[field]?.match(() => null, (error) => error),
          onChanged: signUpNotifier.setLicenseNumber,
          labelText: "License FIFA",
          hintText: "Numéro de votre licence FIFA",
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/icons/license.svg",
              height: 24,
              width: 24,
              // fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(colorScheme.inversePrimary, BlendMode.srcIn),
            ),
          ),
          helperText: "optionnel",
          maxLength: 70,
        ),
        GestureDetector(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
            );

            if (result != null && result.files.single.path != null) {
              signUpNotifier.setLicenseFilePath(result.files.single);
            }
          },
          child: Container(
            width: 312,
            height: 142,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(152, 0, 17, 1),
                  Color.fromRGBO(239, 68, 68, 0.5),
                  Color.fromRGBO(152, 0, 17, 1),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.fromBorderSide(
                BorderSide(color: colorScheme.outlineVariant, width: 1),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4,
              children: [
                Icon(
                  uploadError != null && uploadError.isSome()
                      ? Icons.error_outline
                      : signUpState.licenseFilePath.isNotEmpty
                      ? Icons.check
                      : Icons.file_upload_outlined,
                  color: uploadError != null && uploadError.isSome()
                      ? Colors.amber
                      : signUpState.licenseFilePath.isNotEmpty
                      ? const Color(0xFF34c759)
                      : white,
                  size: 64,
                ),
                Text(
                  uploadError != null && uploadError.isSome()
                      ? uploadError.getOrElse(() => "Unknown Error!")
                      : signUpState.licenseFilePath.isNotEmpty
                      ? signUpState.licenseFilePath.split('/').last
                      : "Télécharger votre document FIFA",
                  style: textTheme.labelLarge!.copyWith(color: white, fontWeight: FontWeight.w600),
                ),

                Text(
                  uploadError == null && signUpState.licenseFilePath.isNotEmpty
                      ? _getFileSizeString(signUpState.licenseFilePath)
                      : "PDF, JPG, JPEG ou PNG (max 10MB)",
                  style: textTheme.labelLarge!.copyWith(color: white.withValues(alpha: 0.7)),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: signUpState.acceptedTerms,
              checkColor: white,
              activeColor: colorScheme.primary,
              semanticLabel: "Accept terms and conditions",
              side: BorderSide(color: colorScheme.outlineVariant, width: 1.5),
              onChanged: (value) {
                signUpNotifier.setAcceptedTerms(value ?? false);
              },
            ),
            Expanded(
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  text: "J'accepte les ",
                  style: textTheme.labelMedium!.copyWith(color: white),
                  children: [
                    TextSpan(
                      text: "conditions d'utilisation",
                      style: textTheme.labelMedium!.copyWith(
                        color: white,
                        decoration: TextDecoration.underline,
                        decorationColor: white,
                        decorationThickness: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: _termsTapRecognizer,
                    ),
                    TextSpan(
                      text: " et la ",
                      style: textTheme.labelMedium!.copyWith(color: white),
                    ),
                    TextSpan(
                      text: "politique de confidentialité",
                      style: textTheme.labelMedium!.copyWith(
                        color: white,
                        decoration: TextDecoration.underline,
                        decorationColor: white,
                        decorationThickness: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: _privacyTapRecognizer,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const CustomBanner(
          icon: Icons.check_circle_outline,
          title: 'Important',
          subtitle:
              "Votre compte sera créé et soumis à vérification. Vous recevrez un email de confirmation une fois votre licence FIFA validée.",
        ),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                context.go("/sign-up/step-1");
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
              onPressed: !signUpNotifier.validateAll() || authMutation is MutationPending
                  ? null
                  : () {
                      if (!signUpState.acceptedTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Veuillez accepter les conditions d'utilisation.",
                              style: textTheme.titleSmall!.copyWith(
                                color: colorScheme.inversePrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            backgroundColor: colorScheme.inverseSurface,
                          ),
                        );
                        return;
                      } else {
                        ref.read(authControllerProvider.notifier).performSignUp();
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: signUpState.acceptedTerms
                    ? colorScheme.primary
                    : colorScheme.primary.withValues(alpha: 0.4),
                minimumSize: const Size(176, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              icon: authMutation is MutationPending
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 1, color: Colors.white),
                    )
                  : Icon(Icons.check, color: colorScheme.onPrimary),
              label: switch (authMutation) {
                MutationPending() => Text(
                  'Inscription...',
                  style: textTheme.titleMedium!.copyWith(color: colorScheme.onPrimary),
                ),
                _ => Text(
                  "Créer compte",
                  style: textTheme.titleMedium!.copyWith(color: colorScheme.onPrimary),
                ),
              },
            ),
          ],
        ),

        Divider(color: colorScheme.inversePrimary),
        const RedirectionText(
          label: "Vous avez déjà un compte ?",
          redirectionText: "Se Connecter",
          path: "/sign-in",
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
