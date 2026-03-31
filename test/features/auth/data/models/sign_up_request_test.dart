import 'dart:io';

import 'package:agent_pro/features/auth/data/models/sign_up_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late File tempFile;
  late SignUpRequest tSignUpRequest;
  setUp(() async {
    final tempDir = await Directory.systemTemp.createTemp('agent_test_');
    tempFile = File('${tempDir.path}/temp_license.pdf');
    await tempFile.writeAsBytes([0, 1, 2, 3, 4]); // Create a dummy file
    tSignUpRequest = SignUpRequest(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      phoneNumber: '1234567890',
      password: 'password123',
      confirmPassword: 'password123',
      agencyName: 'Doe Agency',
      fifaLicense: 'FIFA12345',
      licenseFilePath: tempFile.path,
    );
  });
  test('SignUpRequest toFormData returns correct FormData', () async {
    // act
    final formData = await tSignUpRequest.toFormData();
    final fieldsMap = Map.fromEntries(formData.fields);
    // assert
    expect(fieldsMap, containsPair('username', 'John_Doe'));
    expect(fieldsMap, containsPair('first_name', 'John'));
    expect(fieldsMap, containsPair('last_name', 'Doe'));
    expect(fieldsMap, containsPair('email', 'john.doe@example.com'));
    expect(fieldsMap, containsPair('phone', '1234567890'));
    expect(fieldsMap, containsPair('password', 'password123'));
    expect(fieldsMap, containsPair('confirm_password', 'password123'));
    expect(fieldsMap, containsPair('agency_name', 'Doe Agency'));
    expect(fieldsMap, containsPair('license_number', 'FIFA12345'));
  });
}
