class IdentitySubmissionModel {
  final String id;
  final String userId;
  final DateTime createdAt;
  final bool eligible;
  final List<String> eligibilityReasons;
  final int? trustScore;
  final String? riskLevel;
  final List<String> trustReasons;

  IdentitySubmissionModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.eligible,
    required this.eligibilityReasons,
    this.trustScore,
    this.riskLevel,
    required this.trustReasons,
  });

  factory IdentitySubmissionModel.fromJson(Map<String, dynamic> json) {
    return IdentitySubmissionModel(
      id: json['id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      eligible: json['eligible'] ?? false,
      eligibilityReasons: List<String>.from(json['eligibility_reasons'] ?? []),
      trustScore: json['trust_score'],
      riskLevel: json['risk_level'],
      trustReasons: List<String>.from(json['trust_reasons'] ?? []),
    );
  }
}
