import 'package:agent_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:agent_pro/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:agent_pro/core/error/failure.dart';
import 'package:agent_pro/core/usecase/usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignOut signOut;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signOut = SignOut(mockAuthRepository);
  });

  test('should sign out successfully', () async {
    // Arrange
    when(() => mockAuthRepository.signOut()).thenAnswer((_) async => const Right(unit));

    // Act
    final result = await signOut.call(NoParams());

    // Assert
    expect(result, const Right(unit));
  });

  test('should return failure when sign out fails', () async {
    // Arrange
    const failure = ServerFailure(message: 'Sign out failed');
    when(() => mockAuthRepository.signOut()).thenAnswer((_) async => const Left(failure));

    // Act
    final result = await signOut.call(NoParams());

    // Assert
    expect(result, const Left(failure));
  });
}
