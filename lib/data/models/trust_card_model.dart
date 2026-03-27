class TrustCardProductOption {
  final String key;
  final String label;
  final String description;

  TrustCardProductOption({
    required this.key,
    required this.label,
    required this.description,
  });

  factory TrustCardProductOption.fromJson(Map<String, dynamic> json) {
    return TrustCardProductOption(
      key: json['key'],
      label: json['label'],
      description: json['description'],
    );
  }
}

class TrustCardModel {
  final String id;
  final String userId;
  final String? submissionId;
  final int combinedScoreAtIssue;
  final String maskedNumber;
  final String cardSuffix;
  final String? selectedProduct;
  final List<String> requestedProducts;
  final List<TrustCardProductOption> availableProducts;
  final DateTime createdAt;

  TrustCardModel({
    required this.id,
    required this.userId,
    this.submissionId,
    required this.combinedScoreAtIssue,
    required this.maskedNumber,
    required this.cardSuffix,
    this.selectedProduct,
    this.requestedProducts = const [],
    required this.availableProducts,
    required this.createdAt,
  });

  factory TrustCardModel.fromJson(Map<String, dynamic> json) {
    final dynamic selectedProductRaw = json['selected_product'];
    final selectedProduct = selectedProductRaw is String
        ? selectedProductRaw
        : selectedProductRaw is List && selectedProductRaw.isNotEmpty
        ? selectedProductRaw.first.toString()
        : null;

    final requestedProductsFromApi = (json['requested_products'] as List?)
            ?.map((p) => p.toString())
            .toList() ??
        <String>[];

    final selectedProductsFromApi = selectedProductRaw is List
        ? selectedProductRaw.map((p) => p.toString()).toList()
        : <String>[];

    final requestedProducts = <String>{
      ...requestedProductsFromApi,
      ...selectedProductsFromApi,
      if (selectedProduct != null) selectedProduct,
    }.toList();

    return TrustCardModel(
      id: json['id'],
      userId: json['user_id'],
      submissionId: json['submission_id'],
      combinedScoreAtIssue: json['combined_score_at_issue'],
      maskedNumber: json['masked_number'],
      cardSuffix: json['card_suffix'],
      selectedProduct: selectedProduct,
      requestedProducts: requestedProducts,
      availableProducts: (json['available_products'] as List)
          .map((p) => TrustCardProductOption.fromJson(p))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
