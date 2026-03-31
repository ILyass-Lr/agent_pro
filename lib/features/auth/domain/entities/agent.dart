import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:intl_phone_field/phone_number.dart' as intl_phone_number show PhoneNumber;

import '../../../../core/constants/error_message.dart';
import '../../../../core/error/failure.dart';

class Agent {
  final Id id;
  final Name firstName;
  final Name lastName;
  final Email email;
  final PhoneNumber phoneNumber;
  final Name agencyName;
  final FifaLicense fifaLicense;

  final String? avatarUrl;
  final bool fifaCertified;
  final DateTime? certificationDate;
  final FilePath licenseFilePath;
  final String country;
  final String city;

  Agent({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.agencyName,
    required this.fifaLicense,

    this.avatarUrl,
    this.fifaCertified = false,
    this.certificationDate,
    required this.licenseFilePath,
    required this.country,
    required this.city,
  });
}

extension type Id(BigInt id) {
  String get value => id.toString();
  static String? _validate(BigInt input, {bool fromBackend = false}) {
    if (input <= BigInt.zero) {
      return fromBackend
          ? "$argErrPrefix sent an invalid ID! $argErrSuffix"
          : "ID must be a positive integer";
    }
    return null;
  }

  static Either<Failure, Id> create(BigInt input) {
    final error = Id._validate(input);
    return error == null ? Right(Id(input)) : Left(Failure.invalidInputFailure(message: error));
  }

  factory Id.fromBackend(BigInt input) {
    final error = Id._validate(input, fromBackend: true);
    if (error != null) {
      throw ArgumentError(error);
    }
    return Id(input);
  }
}

extension type Name(String name) {
  String get value => name;
  static String? _validate(String input, {bool fromBackend = false}) {
    if (input.isEmpty) {
      return fromBackend ? "$argErrPrefix sent an empty name! $argErrSuffix" : "Cannot be empty";
    }
    if (input.length < 2) {
      return fromBackend
          ? "$argErrPrefix sent a too short name! $argErrSuffix"
          : "Min. 2 characters!";
    }
    if (input.length > 50) {
      return fromBackend
          ? "$argErrPrefix sent a too long name! $argErrSuffix"
          : "Max. 50 characters";
    }
    if (!RegExp(r"^[\p{L}\s'-]+$", unicode: true).hasMatch(input)) {
      return fromBackend
          ? "$argErrPrefix sent a name with invalid characters! $argErrSuffix"
          : "Only letters!";
    }
    return null;
  }

  static Either<Failure, Name> create(String input) {
    final error = _validate(input);
    return error == null ? Right(Name(input)) : Left(Failure.invalidInputFailure(message: error));
  }

  factory Name.fromBackend(String input) {
    final error = _validate(input, fromBackend: true);
    if (error != null) {
      throw ArgumentError(error);
    }
    return Name(input);
  }
}

extension type Email(String email) {
  String get value => email;
  static String? _validate(String input, {bool fromBackend = false}) {
    if (input.isEmpty) {
      return fromBackend
          ? "$argErrPrefix sent an empty email! $argErrSuffix"
          : "Email cannot be empty";
    }
    if (input.length < 5) {
      return fromBackend
          ? "$argErrPrefix sent an email that is too short! $argErrSuffix"
          : "Email must be at least 5 characters!";
    }

    if (input.length > 254) {
      return fromBackend
          ? "$argErrPrefix sent an email that is too long! $argErrSuffix"
          : "Email cannot be longer than 254 characters";
    }
    if (!RegExp(
      r'^[\p{L}\p{N}._%+\-]+@([\p{L}\p{N}-]+\.)+[\p{L}]{2,}$',
      unicode: true,
    ).hasMatch(input)) {
      return fromBackend ? "$argErrPrefix an invalid email! $argErrSuffix" : 'Invalid email format';
    }

    return null;
  }

  static Either<Failure, Email> create(String input) {
    final error = _validate(input);
    return error == null ? Right(Email(input)) : Left(Failure.invalidInputFailure(message: error));
  }

  factory Email.fromBackend(String input) {
    final error = _validate(input, fromBackend: true);
    if (error != null) {
      throw ArgumentError(error);
    }
    return Email(input);
  }
}

extension type PhoneNumber(String phoneNumber) {
  String get value => phoneNumber;
  static String? _validate(String input, {bool fromBackend = false}) {
    // TODO: REMOVE THIS CHECK BECAUSE ITS TEMPORARY
    if (fromBackend && input.isEmpty) {
      return null;
    }
    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(input)) {
      return fromBackend
          ? "$argErrPrefix an invalid phone number! $argErrSuffix"
          : 'Invalid phone number format. Must be 7-15 digits';
    }
    return null;
  }

  static Either<Failure, PhoneNumber> create(String input) {
    final error = _validate(input);
    return error == null
        ? Right(PhoneNumber(input))
        : Left(Failure.invalidInputFailure(message: error));
  }

  factory PhoneNumber.fromBackend(String input) {
    final error = _validate(input, fromBackend: true);
    if (error != null) {
      throw ArgumentError(error);
    }
    return PhoneNumber(input);
  }

  // Strips the country code from a complete phone number, leaving only the local number part
  factory PhoneNumber.fromCompleteNumber({required String completeNumber}) {
    return PhoneNumber(
      intl_phone_number.PhoneNumber.fromCompleteNumber(completeNumber: completeNumber).number,
    );
  }
}

extension type FifaLicense(String license) {
  String get value => license;
  static String? _validate(String input, {bool fromBackend = false}) {
    if (input.isEmpty) {
      return null;
    }
    if (input.length < 3) {
      return fromBackend
          ? "$argErrPrefix a too short FIFA license! $argErrSuffix"
          : "Must be at least 3 characters long";
    }
    if (input.length > 22) {
      return fromBackend
          ? "$argErrPrefix a too long FIFA license! $argErrSuffix"
          : "Cannot be longer than 22 characters";
    }
    if (!RegExp(r'^[A-Za-z0-9\-]+$').hasMatch(input)) {
      return fromBackend
          ? "$argErrPrefix a FIFA license with invalid characters! $argErrSuffix"
          : "Only letters, hyphens and numbers";
    }
    return null;
  }

  static Either<Failure, FifaLicense> create(String input) {
    final error = _validate(input);
    return error == null
        ? Right(FifaLicense(input))
        : Left(Failure.invalidInputFailure(message: error));
  }

  factory FifaLicense.fromBackend(String input) {
    final error = _validate(input, fromBackend: true);
    if (error != null) {
      throw ArgumentError(error);
    }
    return FifaLicense(input);
  }
}

extension type FilePath(String path) {
  String get value => path;
  static String? _validate(String input, {bool fromBackend = false}) {
    if (fromBackend && input.isEmpty) {
      return null;
    }
    if (input.isEmpty) {
      return fromBackend
          ? "$argErrPrefix an empty file path! $argErrSuffix"
          : "File path cannot be empty";
    }

    final uri = Uri.tryParse(input);

    // 1. Check if it's a Remote URL (http/https)
    if (input.startsWith('http')) {
      if (uri != null && uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https')) {
        return null; // Valid Web URL
      }
    }

    // 2. Check if it's a Local File Path
    // On mobile/desktop, these start with '/' or 'C:\'
    final isUnixPath = input.startsWith('/');
    final isWindowsPath = input.contains(RegExp(r'^[a-zA-Z]:\\'));
    final isFileUri = input.startsWith('file://');

    if (isUnixPath || isWindowsPath || isFileUri) {
      return null; // Valid Local Path
    }

    // 3. If it matches none of the above
    return fromBackend
        ? "$argErrPrefix an invalid file source! $argErrSuffix"
        : "Invalid file path or URL";
  }

  static Either<Failure, FilePath> create(String input) {
    final error = _validate(input);
    return error == null
        ? Right(FilePath(input))
        : Left(Failure.invalidInputFailure(message: error));
  }

  factory FilePath.fromBackend(String input) {
    final error = _validate(input, fromBackend: true);
    if (error != null) {
      throw ArgumentError(error);
    }
    return FilePath(input);
  }

  Future<bool> get existsLocally => File(path).exists();
}
