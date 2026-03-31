import 'package:agent_pro/core/types/sign_up_field.dart';

import '../../domain/entities/agent.dart';
import '../controllers/sign_up_notifier.dart';
import '../widgets/auth_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/redirection_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/full_width_intl_phone_field.dart';

class SignUpFormOne extends ConsumerStatefulWidget {
  const SignUpFormOne({super.key});

  @override
  ConsumerState<SignUpFormOne> createState() => _SignUpFormOneState();
}

class _SignUpFormOneState extends ConsumerState<SignUpFormOne> {
  late final TextEditingController _phoneController;
  late final FocusNode _phoneFocusNode;
  late final ProviderSubscription<SignUpState> _phoneSync;

  @override
  void initState() {
    super.initState();
    _phoneFocusNode = FocusNode();

    // Initial hydration of the controller
    final initialState = ref.read(signUpProvider).phoneNumber;
    _phoneController = TextEditingController(
      text: PhoneNumber.fromCompleteNumber(completeNumber: initialState).value,
    );

    // Setup the listener
    _phoneSync = ref.listenManual<SignUpState>(signUpProvider, (previous, next) {
      // Stop if the user is currently typing (prevents cursor jumping)
      if (_phoneFocusNode.hasFocus) return;

      final strippedNumber = PhoneNumber.fromCompleteNumber(completeNumber: next.phoneNumber).value;

      if (_phoneController.text != strippedNumber) {
        _phoneController.text = strippedNumber;
      }
    });
  }

  @override
  void dispose() {
    _phoneSync.close();
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const white = Colors.white;
    final textTheme = theme.textTheme;
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);
    final formContent = Column(
      spacing: 16,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const AuthText(title: "Inscription", subtitle: "Informations Personnelles"),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                state: signUpState,
                field: SignUpField.firstName,
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
                errorTextSelector: (state, field) => state.validationErrors[field]?.match(
                  () => null,
                  (error) => error,
                ),
                onChanged: signUpNotifier.setFirstName,
                labelText: "Prénom*",
                hintText: "Jean",
                prefixIcon: Icon(Icons.person_outline, color: colorScheme.inversePrimary),
                hideCounterForField: (field) =>
                    field == SignUpField.firstName || field == SignUpField.lastName,
                hideValidationIndicatorForField: (field) =>
                    field == SignUpField.firstName || field == SignUpField.lastName,
                maxLength: 50,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                state: signUpState,
                field: SignUpField.lastName,
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
                errorTextSelector: (state, field) => state.validationErrors[field]?.match(
                  () => null,
                  (error) => error,
                ),
                onChanged: signUpNotifier.setLastName,
                labelText: "Nom*",
                hintText: "Dupont",
                prefixIcon: Icon(Icons.person_outline, color: colorScheme.inversePrimary),
                hideCounterForField: (field) =>
                    field == SignUpField.firstName || field == SignUpField.lastName,
                hideValidationIndicatorForField: (field) =>
                    field == SignUpField.firstName || field == SignUpField.lastName,
                maxLength: 50,
              ),
            ),
          ],
        ),
        CustomTextField(
          state: signUpState,
          field: SignUpField.email,
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
          errorTextSelector: (state, field) => state.validationErrors[field]?.match(
            () => null,
            (error) => error,
          ),
          onChanged: signUpNotifier.setEmail,
          labelText: "Email*",
          hintText: "joe.doe@gmail.com",
          prefixIcon: Icon(Icons.email_outlined, color: colorScheme.inversePrimary),
          maxLength: 254,
        ),
        FullWidthIntlPhoneField(
          controller: _phoneController,
          focusNode: _phoneFocusNode,
          onChanged: (phone) => signUpNotifier.setPhoneNumber(phone.completeNumber),
          initialCountryCode: 'MA',
          dropdownIconPosition: .trailing,
          dropdownTextStyle: textTheme.bodyMedium!.copyWith(color: white),
          style: textTheme.bodyMedium!.copyWith(color: white),
          decoration: InputDecoration(
            labelText: "Numéro de téléphone*",
            labelStyle: textTheme.bodyLarge!.copyWith(color: colorScheme.onPrimaryContainer),
            hintText: "691858691",
            hintStyle: textTheme.bodyMedium!.copyWith(
              color: colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
            ),
            prefixIcon: Icon(Icons.phone_outlined, color: colorScheme.inversePrimary),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: colorScheme.outline)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.outline, width: 2),
            ),
            errorStyle: textTheme.bodySmall!.copyWith(color: colorScheme.tertiaryFixedDim),
            errorText: signUpState.validationErrors[SignUpField.phoneNumber]?.match(
              () => null,
              (error) => error,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.tertiaryFixedDim, width: 2),
            ),
          ),
        ),
        CustomTextField(
          onChanged: signUpNotifier.setPassword,
          state: signUpState,
          field: SignUpField.password,
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
          errorTextSelector: (state, field) => state.validationErrors[field]?.match(
            () => null,
            (error) => error,
          ),
          labelText: "Mot de passe*",
          hintText: "Entrez votre mot de passe",
          prefixIcon: Icon(Icons.lock_outline, color: colorScheme.inversePrimary),
          isPasswordField: true,
          maxLength: 50,
        ),
        CustomTextField(
          onChanged: signUpNotifier.setConfirmPassword,
          state: signUpState,
          field: SignUpField.confirmPassword,
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
          errorTextSelector: (state, field) => state.validationErrors[field]?.match(
            () => null,
            (error) => error,
          ),
          labelText: "Confirmer mot de passe*",
          hintText: "Entrez votre mot de passe",
          prefixIcon: Icon(Icons.lock_outline, color: colorScheme.inversePrimary),
          isPasswordField: true,
          maxLength: 50,
        ),
        ElevatedButton.icon(
          onPressed: signUpNotifier.validatePageOne()
              ? () {
                  context.go('/sign-up/step-2');
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            minimumSize: const Size(156, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          icon: Icon(Icons.arrow_forward, color: colorScheme.onPrimary),
          label: Text(
            'Suivant',
            style: textTheme.titleMedium!.copyWith(color: colorScheme.onPrimary),
          ),
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
