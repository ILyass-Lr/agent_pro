typedef SignUpParams = ({
  ({String firstName, String lastName, String email, String phoneNumber}) personal,
  ({String password, String confirmPassword}) security,
  ({String agencyName, String fifaLicense, String licenseFilePath}) professional,
});
