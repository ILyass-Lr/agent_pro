import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:agent_pro/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignUp signUp;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signUp = SignUp(mockAuthRepository);
    registerFallbackValue((
      personal: (firstName: '', lastName: '', email: '', phoneNumber: ''),
      security: (password: '', confirmPassword: ''),
      professional: (agencyName: '', fifaLicense: '', licenseFilePath: ''),
    ));
  });

  group('call', () {
    test('should return Unit when sign up is successful', () async {
      // arrange
      when(() => mockAuthRepository.signUp(any())).thenAnswer((_) async => const Right(unit));
      // act
      final result = await signUp((
        personal: (
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          phoneNumber: '+1234567890',
        ),
        security: (password: 'ValidPass123', confirmPassword: 'ValidPass123'),
        professional: (
          agencyName: 'Elite Agency',
          fifaLicense: 'FIFA123456',
          licenseFilePath: '/path/to/file.pdf',
        ),
      ));
      // assert
      expect(result.isRight(), true);
    });

    test('should return Failure when sign up fails', () async {
      // arrange
      const tFailure = ServerFailure(message: 'Server error');
      when(() => mockAuthRepository.signUp(any())).thenAnswer((_) async => const Left(tFailure));
      // act
      final result = await signUp((
        personal: (
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          phoneNumber: '+1234567890',
        ),
        security: (password: 'ValidPass123', confirmPassword: 'ValidPass123'),
        professional: (
          agencyName: 'Elite Agency',
          fifaLicense: 'FIFA123456',
          licenseFilePath: '/path/to/file.pdf',
        ),
      ));
      // assert
      expect(result.isLeft(), true);
      expect(result.getLeft().getOrElse(() => const Failure.serverFailure()), tFailure);
    });
  });
}
