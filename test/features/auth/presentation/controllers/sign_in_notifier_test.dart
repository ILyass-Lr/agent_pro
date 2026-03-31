import 'package:agent_pro/core/types/sign_in_field.dart';
import 'package:agent_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agent_pro/features/auth/presentation/controllers/sign_in_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late SignInNotifier notifier;
  late MockAuthRepository mockAuthRepository;
  // late ProviderSubscription<SignInState> subscription;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(mockAuthRepository)],
    );
  });

  tearDown(() {
    // subscription.close();
    container.dispose();
  });

  test('Initial state is empty if there is no remembered email', () {
    // arrange
    when(() => mockAuthRepository.getRememberedEmail()).thenReturn(null);
    // act
    final state = container.read(signInProvider);
    expect(state.email, '');
    expect(state.password, '');
    expect(state.rememberMe, true);
    expect(
      state.validationErrors,
      equals({SignInField.email: const None(), SignInField.password: const None()}),
    );
  });
  test('Initial state with remembered email', () {
    // arrange
    when(() => mockAuthRepository.getRememberedEmail()).thenReturn('remembered@example.com');
    // act
    final state = container.read(signInProvider);
    // assert
    expect(state.email, 'remembered@example.com');
    expect(state.password, '');
    expect(state.rememberMe, true);
    expect(
      state.validationErrors,
      equals({SignInField.email: const None(), SignInField.password: const None()}),
    );
  });
  test('isValidForm returns true when there are no validation errors', () {
    // arrange
    when(() => mockAuthRepository.getRememberedEmail()).thenReturn(null);
    notifier = container.read(signInProvider.notifier);
    notifier
      ..setEmail('Joe@example.com')
      ..setPassword('password123');
    // act
    final result = notifier.isValidForm;
    // assert
    expect(result, isTrue);
  });
  test('isValidForm returns false when there are validation errors', () {
    // arrange
    when(() => mockAuthRepository.getRememberedEmail()).thenReturn(null);
    notifier = container.read(signInProvider.notifier);
    notifier
      ..setEmail('invalid-email')
      ..setPassword('password123');
    // act
    final result = notifier.isValidForm;
    // assert
    expect(result, isFalse);
  });
}
