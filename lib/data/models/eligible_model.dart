class EligibleModel {
  final String submissionId;
  final int documentScore;
  final int videoScore;
  final int audioScore;
  final int combinedScore;
  final String loanTier;
  final String loanOffer;
  final bool eligibleForLoan;
  final bool eligibleForDeviceFinancing;
  final String deviceFinancingOffer;
  final bool eligibleForCreditCard;
  final String creditCardOffer;
  final EligibilityMetrics metrics;

  EligibleModel({
    required this.submissionId,
    required this.documentScore,
    required this.videoScore,
    required this.audioScore,
    required this.combinedScore,
    required this.loanTier,
    required this.loanOffer,
    required this.eligibleForLoan,
    required this.eligibleForDeviceFinancing,
    required this.deviceFinancingOffer,
    required this.eligibleForCreditCard,
    required this.creditCardOffer,
    required this.metrics,
  });

  factory EligibleModel.fromJson(Map<String, dynamic> json) {
    return EligibleModel(
      submissionId: json['submission_id'],
      documentScore: json['document_score'],
      videoScore: json['video_score'],
      audioScore: json['audio_score'],
      combinedScore: json['combined_score'],
      loanTier: json['loan_tier'],
      loanOffer: json['loan_offer'],
      eligibleForLoan: json['eligible_for_loan'],
      eligibleForDeviceFinancing: json['eligible_for_device_financing'],
      deviceFinancingOffer: json['device_financing_offer'],
      eligibleForCreditCard: json['eligible_for_credit_card'],
      creditCardOffer: json['credit_card_offer'],
      metrics: EligibilityMetrics.fromJson(json['metrics']),
    );
  }
}

class EligibilityMetrics {
  final int modalityMinScore;
  final int modalityMaxScore;
  final int modalitySpread;
  final String weakestModality;
  final String strongestModality;

  EligibilityMetrics({
    required this.modalityMinScore,
    required this.modalityMaxScore,
    required this.modalitySpread,
    required this.weakestModality,
    required this.strongestModality,
  });

  factory EligibilityMetrics.fromJson(Map<String, dynamic> json) {
    return EligibilityMetrics(
      modalityMinScore: json['modality_min_score'],
      modalityMaxScore: json['modality_max_score'],
      modalitySpread: json['modality_spread'],
      weakestModality: json['weakest_modality'],
      strongestModality: json['strongest_modality'],
    );
  }
}
