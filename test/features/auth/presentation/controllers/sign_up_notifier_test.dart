import 'dart:io';

import 'package:agent_pro/core/database/app_database.dart';
import 'package:agent_pro/core/types/sign_up_field.dart';
import 'package:agent_pro/features/auth/presentation/controllers/sign_up_notifier.dart';
import 'package:drift/native.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

/// Test helper to create PlatformFile instances
PlatformFile createTestPlatformFile({
  String path = '/path/to/file.pdf',
  String name = 'file.pdf',
  int size = 5 * 1024 * 1024, // 5MB default
  String? extension = 'pdf',
}) {
  return PlatformFile(path: path, name: name, size: size, bytes: null);
}

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late SignUpNotifier notifier;
  late ProviderSubscription<SignUpState> subscription;
  late File tempFile;
  late String tempFilePath;
  late AppDatabase testDatabase;

  setUp(() {
    // Create a temporary test file
    tempFile = File(
      '${Directory.systemTemp.path}/test_license_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    tempFile.writeAsBytesSync(List.generate(5 * 1024 * 1024, (i) => 0)); // 5MB of zeros
    tempFilePath = tempFile.path;
    testDatabase = AppDatabase(NativeDatabase.memory());

    container = ProviderContainer(overrides: [appDatabaseProvider.overrideWithValue(testDatabase)]);

    // We listen to the provider to keep it alive during the test
    subscription = container.listen<SignUpState>(signUpProvider, (previous, next) {});
    notifier = container.read(signUpProvider.notifier);
    registerFallbackValue(
      const SignUpState(
        firstName: '',
        lastName: '',
        email: '',
        phoneNumber: '',
        password: '',
        confirmPassword: '',
        agencyName: '',
        licenseNumber: '',
        licenseFilePath: '',
        acceptedTerms: false,
      ),
    );
  });

  tearDown(() {
    testDatabase.close();
    container.dispose();
    subscription.close();
    // Clean up temporary file
    if (tempFile.existsSync()) {
      tempFile.deleteSync();
    }
  });

  group('SignUpNotifier - validatePageOne', () {
    test('returns true when all personal info is valid', () {
      notifier
        ..setFirstName('John')
        ..setLastName('Doe')
        ..setEmail('john@example.com')
        ..setPhoneNumber('+1234567890')
        ..setPassword('ValidPass123')
        ..setConfirmPassword('ValidPass123');

      final result = notifier.validatePageOne();

      expect(result, true);
    });

    test('returns false when firstName is invalid', () {
      notifier
        ..setFirstName('')
        ..setLastName('Doe')
        ..setEmail('john@example.com')
        ..setPhoneNumber('+1234567890')
        ..setPassword('ValidPass123')
        ..setConfirmPassword('ValidPass123');

      final result = notifier.validatePageOne();
      final errors = container.read(signUpProvider).validationErrors;

      expect(result, false);
      expect(errors[SignUpField.firstName], isA<Some<String>>());
    });

    test('returns false when email is invalid', () {
      notifier
        ..setFirstName('John')
        ..setLastName('Doe')
        ..setEmail('invalid-email')
        ..setPhoneNumber('+1234567890')
        ..setPassword('ValidPass123')
        ..setConfirmPassword('ValidPass123');

      final result = notifier.validatePageOne();
      final errors = container.read(signUpProvider).validationErrors;

      expect(result, false);
      expect(errors[SignUpField.email], isA<Some<String>>());
    });

    test('returns false when password is too short', () {
      notifier
        ..setFirstName('John')
        ..setLastName('Doe')
        ..setEmail('john@example.com')
        ..setPhoneNumber('+1234567890')
        ..setPassword('Pass1')
        ..setConfirmPassword('Pass1');

      final result = notifier.validatePageOne();
      final errors = container.read(signUpProvider).validationErrors;

      expect(result, false);
      expect(errors[SignUpField.password], isA<Some<String>>());
    });

    test('returns false when passwords do not match', () {
      notifier
        ..setFirstName('John')
        ..setLastName('Doe')
        ..setEmail('john@example.com')
        ..setPhoneNumber('+1234567890')
        ..setPassword('ValidPass123')
        ..setConfirmPassword('DifferentPass123');

      final result = notifier.validatePageOne();
      final errors = container.read(signUpProvider).validationErrors;

      expect(result, false);
      expect(errors[SignUpField.confirmPassword], isA<Some<String>>());
    });
  });

  group('SignUpNotifier - validateAll', () {
    late SignUpState state;
    setUp(() {
      notifier
        ..setFirstName('John')
        ..setLastName('Doe')
        ..setEmail('john@example.com')
        ..setPhoneNumber('+1234567890')
        ..setPassword('ValidPass123')
        ..setConfirmPassword('ValidPass123');
      state = container.read(signUpProvider);
    });
    test('returns true when all professional info is valid', () async {
      // arrange
      notifier
        ..setAgencyName('Elite Agency')
        ..setLicenseNumber('FIFA123456');
      await notifier.setLicenseFilePath(createTestPlatformFile(path: tempFilePath));

      // act
      final result = notifier.validateAll();

      expect(result, true, reason: 'Some fields failed validation: ${state.validationErrors}');
    });

    test('returns false when license file path is invalid', () async {
      // arrange
      notifier
        ..setAgencyName('Elite Agency')
        ..setLicenseNumber('FIFA123456');
      await notifier.setLicenseFilePath(createTestPlatformFile(path: 'invalid_path'));

      // Wait for async validation
      await Future.delayed(const Duration(milliseconds: 100));

      // act
      final result = notifier.validateAll();
      final state = container.read(signUpProvider);

      // assert
      expect(result, false);
      expect(state.validationErrors[SignUpField.licenseFilePath], isA<Some<String>>());
    });

    test('returns false when file size exceeds 10MB', () async {
      // arrange - set page 1 fields first
      notifier
        ..setFirstName('John')
        ..setLastName('Doe')
        ..setEmail('john@example.com')
        ..setPhoneNumber('+1234567890')
        ..setPassword('ValidPass123')
        ..setConfirmPassword('ValidPass123')
        ..setAgencyName('Elite Agency')
        ..setLicenseNumber('FIFA123456');
      await notifier.setLicenseFilePath(
        createTestPlatformFile(
          path: tempFilePath,
          size: 11 * 1024 * 1024, // 11MB
        ),
      );
      // act
      final result = notifier.validateAll();
      final state = container.read(signUpProvider);
      // assert

      expect(result, false);
      expect(state.validationErrors[SignUpField.licenseFilePath], isA<Some<String>>());
      expect(
        state.validationErrors[SignUpField.licenseFilePath]?.getOrElse(() => ''),
        contains('10MB'),
      );
    });

    test('returns false when file extension is unsupported', () async {
      // arrange - set page 1 fields first
      notifier
        ..setFirstName('John')
        ..setLastName('Doe')
        ..setEmail('john@example.com')
        ..setPhoneNumber('+1234567890')
        ..setPassword('ValidPass123')
        ..setConfirmPassword('ValidPass123')
        ..setAgencyName('Elite Agency')
        ..setLicenseNumber('FIFA123456');
      await notifier.setLicenseFilePath(
        createTestPlatformFile(
          path: tempFilePath.replaceAll('.pdf', '.txt'),
          name: 'file.txt',
          extension: 'txt',
        ),
      );

      // act
      final result = notifier.validateAll();
      final state = container.read(signUpProvider);

      // assert
      expect(result, false);
      expect(state.validationErrors[SignUpField.licenseFilePath], isA<Some<String>>());
      expect(
        state.validationErrors[SignUpField.licenseFilePath]?.getOrElse(() => ''),
        contains('Unsupported file type!'),
      );
    });

    test('returns false when personal info is invalid', () {
      // arrange - set all fields except firstName invalid
      notifier
        ..setFirstName('') // Invalid!
        ..setLastName('Doe')
        ..setEmail('john@example.com')
        ..setPhoneNumber('+1234567890')
        ..setPassword('ValidPass123')
        ..setConfirmPassword('ValidPass123')
        ..setAgencyName('Elite Agency')
        ..setLicenseNumber('FIFA123456')
        ..setLicenseFilePath(createTestPlatformFile(path: tempFilePath));
      // act - capture state immediately
      final state = container.read(signUpProvider);
      final result = notifier.validateAll();
      // assert
      expect(result, false);
      expect(state.validationErrors[SignUpField.firstName], isA<Some<String>>());
    });
  });
}
