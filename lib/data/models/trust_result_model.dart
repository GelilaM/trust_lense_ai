class TrustResultModel {
  final String submissionId;
  final ModalityTrustBreakdown document;
  final ModalityTrustBreakdown video;
  final ModalityTrustBreakdown audio;
  final CombinedTrustBreakdown combined;

  TrustResultModel({
    required this.submissionId,
    required this.document,
    required this.video,
    required this.audio,
    required this.combined,
  });

  factory TrustResultModel.fromJson(Map<String, dynamic> json) {
    return TrustResultModel(
      submissionId: json['submission_id'],
      document: ModalityTrustBreakdown.fromJson(json['document']),
      video: ModalityTrustBreakdown.fromJson(json['video']),
      audio: ModalityTrustBreakdown.fromJson(json['audio']),
      combined: CombinedTrustBreakdown.fromJson(json['combined']),
    );
  }
}

class ModalityTrustBreakdown {
  final String modality;
  final List<RequirementCheck> criteria;
  final int sectionScore;

  ModalityTrustBreakdown({
    required this.modality,
    required this.criteria,
    required this.sectionScore,
  });

  factory ModalityTrustBreakdown.fromJson(Map<String, dynamic> json) {
    return ModalityTrustBreakdown(
      modality: json['modality'],
      criteria: (json['criteria'] as List)
          .map((e) => RequirementCheck.fromJson(e))
          .toList(),
      sectionScore: json['section_score'],
    );
  }
}

class RequirementCheck {
  final String key;
  final String label;
  final String status;
  final double score;
  final String detail;

  RequirementCheck({
    required this.key,
    required this.label,
    required this.status,
    required this.score,
    required this.detail,
  });

  factory RequirementCheck.fromJson(Map<String, dynamic> json) {
    return RequirementCheck(
      key: json['key'],
      label: json['label'],
      status: json['status'],
      score: (json['score'] as num).toDouble(),
      detail: json['detail'],
    );
  }
}

class CombinedTrustBreakdown {
  final int documentScore;
  final int videoScore;
  final int audioScore;
  final int combinedScore;

  CombinedTrustBreakdown({
    required this.documentScore,
    required this.videoScore,
    required this.audioScore,
    required this.combinedScore,
  });

  factory CombinedTrustBreakdown.fromJson(Map<String, dynamic> json) {
    return CombinedTrustBreakdown(
      documentScore: json['document_score'],
      videoScore: json['video_score'],
      audioScore: json['audio_score'],
      combinedScore: json['combined_score'],
    );
  }
}
