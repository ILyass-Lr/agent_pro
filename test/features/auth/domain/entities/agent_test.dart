import 'package:flutter_test/flutter_test.dart';
import 'package:agent_pro/features/auth/domain/entities/agent.dart';

void main() {
  group('Id', () {
    test('create returns Right with valid positive BigInt', () {
      // arrange & act
      final result = Id.create(BigInt.from(123));
      // assert
      expect(result.isRight(), true);
      expect(result.getOrElse((_) => Id(BigInt.zero)).value, '123');
    });

    test('create returns Left with zero', () {
      // arrange & act
      final result = Id.create(BigInt.zero);
      // assert
      expect(result.isLeft(), true);
    });

    test('create returns Left with negative number', () {
      // arrange & act
      final result = Id.create(BigInt.from(-1));
      // assert
      expect(result.isLeft(), true);
    });
  });

  group('Name', () {
    test('create returns Right with valid name', () {
      // arrange & act
      final result = Name.create('John');
      // assert
      expect(result.isRight(), true);
      expect(result.getOrElse((_) => Name('')).value, 'John');
    });

    test('create returns Left when empty', () {
      // arrange & act
      final result = Name.create('');
      // assert
      expect(result.isLeft(), true);
    });

    test('create returns Left when less than 2 characters', () {
      // arrange & act
      final result = Name.create('J');
      // assert
      expect(result.isLeft(), true);
    });

    test('create returns Left when exceeds 50 characters', () {
      // arrange & act
      final result = Name.create('a' * 51);
      // assert
      expect(result.isLeft(), true);
    });

    test('create returns Left with invalid characters', () {
      // arrange & act
      final result = Name.create('John123');
      // assert
      expect(result.isLeft(), true);
    });

    test('create accepts names with hyphens and apostrophes', () {
      // arrange & act
      final result1 = Name.create('Jean-Paul');
      final result2 = Name.create("O'Brien");
      final result3 = Name.create('María José');
      // assert
      expect(result1.isRight(), true);
      expect(result2.isRight(), true);
      expect(result3.isRight(), true);
      expect(result1.getOrElse((_) => Name('')).value, 'Jean-Paul');
      expect(result2.getOrElse((_) => Name('')).value, "O'Brien");
      expect(result3.getOrElse((_) => Name('')).value, 'María José');
    });
  });

  group('Email', () {
    test('create returns Right with valid email', () {
      // arrange & act
      final result = Email.create('test@example.com');
      // assert
      expect(result.isRight(), true);
    });

    test('create returns Left with invalid email', () {
      // arrange & act
      final result = Email.create('invalid.email');
      // assert
      expect(result.isLeft(), true);
    });

    test('create returns Left with empty email', () {
      // arrange & act
      final result = Email.create('');
      // assert
      expect(result.isLeft(), true);
    });

    test('create returns Right with email containing subdomain', () {
      // arrange & act
      final result = Email.create('user@mail.example.com');
      // assert
      expect(result.isRight(), true);
    });

    test('create returns Right with email containing plus sign', () {
      // arrange & act
      final result = Email.create('user+label@example.com');
      // assert
      expect(result.isRight(), true);
    });

    test('create returns Right with email containing special characters', () {
      // arrange & act
      final result = Email.create('user.mbapé@example.com');
      // assert
      expect(result.isRight(), true);
    });
  });

  group('PhoneNumber', () {
    test('create returns Right with valid phone number', () {
      final result = PhoneNumber.create('1234567');
      expect(result.isRight(), true);
    });

    test('create returns Right with plus prefix', () {
      final result = PhoneNumber.create('+1234567890');
      expect(result.isRight(), true);
    });

    test('create returns Left with less than 7 digits', () {
      final result = PhoneNumber.create('123456');
      expect(result.isLeft(), true);
    });

    test('create returns Left with more than 15 digits', () {
      final result = PhoneNumber.create('1234567890123456');
      expect(result.isLeft(), true);
    });

    test('create returns Left with non-digit characters', () {
      final result = PhoneNumber.create('12345abc');
      expect(result.isLeft(), true);
    });
  });

  group('FifaLicense', () {
    test('create returns Right with valid license', () {
      final result = FifaLicense.create('ABC123');
      expect(result.isRight(), true);
    });

    test('create returns Left when empty', () {
      final result = FifaLicense.create('');
      expect(result.isLeft(), true);
    });

    test('create returns Left when less than 3 characters', () {
      final result = FifaLicense.create('AB');
      expect(result.isLeft(), true);
    });

    test('create returns Left when exceeds 22 characters', () {
      final result = FifaLicense.create('A' * 23);
      expect(result.isLeft(), true);
    });

    test('create returns Left with lowercase letters', () {
      final result = FifaLicense.create('abc123');
      expect(result.isLeft(), true);
    });
  });

  group('FilePath', () {
    test('create returns Right with valid http URL', () {
      final result = FilePath.create('http://example.com/file.pdf');
      expect(result.isRight(), true);
    });

    test('create returns Right with valid https URL', () {
      final result = FilePath.create('https://example.com/file.pdf');
      expect(result.isRight(), true);
    });

    test('create returns Right with file:// protocol', () {
      final result = FilePath.create('file:///path/to/file.pdf');
      expect(result.isRight(), true);
    });

    test('create returns Left when empty', () {
      final result = FilePath.create('');
      expect(result.isLeft(), true);
    });

    test('create returns Left with invalid URL', () {
      final result = FilePath.create('/local/path/file.pdf');
      expect(result.isLeft(), true);
    });
  });
}
