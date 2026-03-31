enum Position { goalkeeper, defender, midfielder, forward }

class Player {
  final BigInt id;

  // Card details
  final String fullName;
  final Position position;
  final String? clubName, clubLogoUrl;
  final int marketValue; // in Euros
  final String photoUrl;

  // Player Details
  // final DateTime dateOfBirth;
  // final String nationalityCode;
  // final String nationalityName;
  // final String agentName;
  // final int overallRating; // 0-100
  // final String agentName;

  Player({
    required this.id,
    required this.fullName,
    required this.position,
    this.clubName,
    this.clubLogoUrl,
    required this.marketValue,
    required this.photoUrl,
  });
}
