import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/features/auth/domain/entities/agent.dart';
import 'package:agent_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:agent_pro/features/auth/domain/usecases/sign_in_use_case.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignIn signInUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInUseCase = SignIn(mockAuthRepository);
    registerFallbackValue((email: '', password: '', rememberMe: false));
  });

  group('SignInUseCase', () {
    test('should return Agent when sign in is successful', () async {
      // arrange
      final tAgent = Agent(
        id: Id(BigInt.from(1)),
        firstName: Name('John'),
        lastName: Name('Doe'),
        email: Email('john.doe@example.com'),
        phoneNumber: PhoneNumber('+1234567890'),
        agencyName: Name('Doe Agency'),
        fifaLicense: FifaLicense('FIFA12345'),
        licenseFilePath: FilePath('/path/to/license.pdf'),
        city: "Rabat",
        country: "Morocco",
        avatarUrl: null,
        certificationDate: DateTime(2023, 1, 1),
        fifaCertified: true,
      );
      when(
        () => mockAuthRepository.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
          rememberMe: any(named: 'rememberMe'),
        ),
      ).thenAnswer((_) async => Right(tAgent));
      // act
      final result = await signInUseCase((
        email: 'john.doe@example.com',
        password: 'password123',
        rememberMe: false,
      ));
      // assert
      expect(result, Right(tAgent));
      verify(
        () => mockAuthRepository.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
          rememberMe: any(named: 'rememberMe'),
        ),
      ).called(1);
    });

    test('should return Failure when sign in fails', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(
        () => mockAuthRepository.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
          rememberMe: any(named: 'rememberMe'),
        ),
      ).thenAnswer((_) async => const Left(tFailure));
      // act
      final result = await signInUseCase((
        email: 'invalid@example.com',
        password: 'wrongpassword',
        rememberMe: false,
      ));
      // assert
      expect(result, const Left(tFailure));
      verify(
        () => mockAuthRepository.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
          rememberMe: any(named: 'rememberMe'),
        ),
      ).called(1);
    });
  });
}
