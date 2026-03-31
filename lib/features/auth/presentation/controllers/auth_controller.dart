import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/core/usecase/usecase.dart';
import 'package:agent_pro/features/auth/domain/entities/agent.dart';
import 'package:agent_pro/features/auth/domain/usecases/forgot_password_use_cases.dart';
import 'package:agent_pro/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:agent_pro/core/services/auth_status_notifier.dart';
import 'package:agent_pro/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:agent_pro/features/auth/presentation/controllers/forgot_password_notifier.dart';
import 'package:agent_pro/features/auth/presentation/controllers/sign_in_notifier.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/types/sign_up_params.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import 'sign_up_notifier.dart';

part 'auth_controller.g.dart';

final completeOnBoarding = Mutation<void>();

@Riverpod(keepAlive: true)
Mutation<Unit> signUpMutation(Ref ref) => Mutation<Unit>();

@riverpod
Mutation<Agent> signInMutation(Ref ref) => Mutation<Agent>();

@riverpod
Mutation<Unit> forgotPasswordMutation(Ref ref) => Mutation<Unit>();

/// We make a separate mutation for OTP resending so we don't react to the success and navigate to the next page when the user just wants to resend the OTP without actually submitting the form
@riverpod
Mutation<Unit> resendOtpMutation(Ref ref) => Mutation<Unit>();

@riverpod
Mutation<Unit> signOutMutation(Ref ref) => Mutation<Unit>();

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  void build() {} // No initial state needed for this controller

  Future<void> performSignUp() async {
    final state = ref.read(signUpProvider);
    final mutation = ref.read(signUpMutationProvider);

    final SignUpParams params = (
      personal: (
        firstName: state.firstName,
        lastName: state.lastName,
        email: state.email,
        phoneNumber: state.phoneNumber,
      ),
      security: (password: state.password, confirmPassword: state.confirmPassword),
      professional: (
        agencyName: state.agencyName,
        fifaLicense: state.licenseNumber,
        licenseFilePath: state.licenseFilePath,
      ),
    );

    await mutation.run(ref, (tsx) async {
      final signUp = tsx.get(signUpUseCaseProvider);
      final result = await signUp(params);
      return result.fold((failure) => throw failure, (_) => unit);
    });
  }

  Future<Agent> performSignIn() async {
    final state = ref.read(signInProvider);
    final mutation = ref.read(signInMutationProvider);

    return await mutation.run(ref, (tsx) async {
      final signIn = tsx.get(signInUseCaseProvider);
      final result = await signIn((
        email: state.email,
        password: state.password,
        rememberMe: state.rememberMe,
      ));
      return result.fold(
        (failure) {
          switch (failure) {
            case UnauthorizedFailure(message: final message, reason: final reason):
              ref.read(authStatusProvider.notifier).block(message, reason);
              throw failure;
            default:
              throw failure;
          }
        },
        (agent) {
          // Update the global auth status with the authenticated agent
          ref.read(authStatusProvider.notifier).login(agent);
          return agent;
        },
      );
    });
  }

  Future<Unit> performSignOut() async {
    final mutation = ref.read(signOutMutationProvider);
    return await mutation.run(ref, (tsx) async {
      final signOut = tsx.get(signOutUseCaseProvider);
      final result = await signOut(NoParams());
      return result.fold((failure) => throw failure, (_) {
        ref.read(authStatusProvider.notifier).logout();
        return unit;
      });
    });
  }

  Future<void> sendPasswordResetEmail() async {
    final mutation = ref.read(forgotPasswordMutationProvider);
    final state = ref.read(forgotPasswordProvider);
    await mutation.run(ref, (tsx) async {
      final sendResetEmail = tsx.get(sendPasswordResetEmailProvider);
      final result = await sendResetEmail(state.email);
      return result.fold((failure) => throw failure, (_) => unit);
    });
  }

  Future<void> sendOtp() async {
    // Implement OTP sending logic here, similar to the above methods
    final mutation = ref.read(forgotPasswordMutationProvider);
    final state = ref.read(forgotPasswordProvider);
    await mutation.run(ref, (tsx) async {
      final verifyResetCode = tsx.get(verifyResetCodeProvider);
      final result = await verifyResetCode((email: state.email, code: state.otp));
      return result.fold((failure) => throw failure, (_) => unit);
    });
  }

  Future<void> resendOtp() async {
    final mutation = ref.read(resendOtpMutationProvider);
    final state = ref.read(forgotPasswordProvider);
    try {
      await mutation.run(ref, (tsx) async {
        final resendOtp = tsx.get(resendOtpProvider);
        final result = await resendOtp(state.email);
        return result.fold((failure) => throw failure, (_) => unit);
      });
    } on Failure {
      // Mutation already exposes the failure state to the UI.
      // When clicking rappidly on the resend button, the first call might fail due to rate limiting, but we don't want to show an error for subsequent calls until the cooldown is over. So we catch and ignore failures here.
    }
  }

  Future<void> resetPassword() async {
    final mutation = ref.read(forgotPasswordMutationProvider);
    final state = ref.read(forgotPasswordProvider);
    await mutation.run(ref, (tsx) async {
      final resetPassword = tsx.get(resetPasswordProvider);
      final result = await resetPassword((
        email: state.email,
        code: state.otp,
        newPassword: state.password,
        confirmPassword: state.confirmPassword,
      ));
      return result.fold((failure) => throw failure, (_) => unit);
    });
  }
}
