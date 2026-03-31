import 'package:dio/dio.dart';

DioMediaType _mediaTypeFromPath(String filePath) {
  final fileName = filePath.split(RegExp(r'[\\/]')).last.toLowerCase();

  if (fileName.endsWith('.png')) {
    return DioMediaType('image', 'png');
  }
  if (fileName.endsWith('.jpg') || fileName.endsWith('.jpeg')) {
    return DioMediaType('image', 'jpeg');
  }
  if (fileName.endsWith('.pdf')) {
    return DioMediaType('application', 'pdf');
  }

  return DioMediaType('application', 'octet-stream');
}

class SignUpRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final String agencyName;
  final String fifaLicense;
  final String licenseFilePath;

  SignUpRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.agencyName,
    required this.fifaLicense,
    required this.licenseFilePath,
  });

  Future<FormData> toFormData() async {
    MultipartFile? certFile;

    if (licenseFilePath.isNotEmpty) {
      certFile = await MultipartFile.fromFile(
        // ✅ await here
        licenseFilePath,
        filename: licenseFilePath.split(RegExp(r'[\\/]')).last, // windows-safe
        contentType: _mediaTypeFromPath(licenseFilePath),
      );
    }

    final map = <String, dynamic>{
      "username": '${firstName}_$lastName',
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone": phoneNumber,
      "password": password,
      "confirm_password": confirmPassword,
      "agency_name": agencyName,
      "license_number": fifaLicense,
    };

    if (certFile != null) {
      map["certification_document"] = certFile; // ✅ real MultipartFile
    }

    return FormData.fromMap(map);
  }
}
