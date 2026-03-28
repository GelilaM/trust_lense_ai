import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../data/models/trust_card_model.dart';
import '../../../data/providers/trust_card_provider.dart';
import '../../../core/services/auth_service.dart';

class TrustCardController extends GetxController {
  final _provider = TrustCardProvider();
  final _auth = Get.find<AuthService>();

  final Rxn<TrustCardModel> card = Rxn<TrustCardModel>();
  final RxBool isLoading = false.obs;
  final RxSet<String> requestedProducts = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCard();
  }

  Future<void> fetchCard() async {
    if (!_auth.isLoggedIn) return;
    try {
      isLoading.value = true;
      final result = await _provider.getCard(_auth.userId!);
      card.value = result;
      requestedProducts
        ..clear()
        ..addAll(
          (result?.requestedProducts ?? const <String>[])
              .map((p) => p.trim().toLowerCase()),
        );
    } finally {
      isLoading.value = false;
    }
  }

  void _applyRequestedProductsFromCard(TrustCardModel model) {
    requestedProducts
      ..clear()
      ..addAll(
        model.requestedProducts.map((p) => p.trim().toLowerCase()),
      );
  }

  String? _dioDetail(Object e) {
    if (e is! DioException) return null;
    final data = e.response?.data;
    if (data is Map && data['detail'] != null) {
      final d = data['detail'];
      if (d is String) return d;
    }
    return null;
  }

  Future<TrustCardModel> _issueAndStoreCard() async {
    final issued = await _provider.issueCard(_auth.userId!);
    card.value = issued;
    _applyRequestedProductsFromCard(issued);
    return issued;
  }

  /// API requires [POST /trust-card/issue] before [POST /trust-card/select] when no card exists.
  Future<TrustCardModel> _selectProductAfterIssue(String productKey) async {
    if (card.value == null) {
      await _issueAndStoreCard();
    }
    try {
      return await _provider.selectProduct(_auth.userId!, productKey);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        await _issueAndStoreCard();
        return await _provider.selectProduct(_auth.userId!, productKey);
      }
      rethrow;
    }
  }

  Future<void> selectProduct(String productKey) async {
    final normalizedKey = productKey.trim().toLowerCase();
    if (requestedProducts.contains(normalizedKey)) {
      Get.snackbar(
        'Already requested',
        'You can only request one of each product type.',
      );
      return;
    }

    try {
      isLoading.value = true;
      final result = await _selectProductAfterIssue(productKey);
      card.value = result;
      requestedProducts
        ..clear()
        ..addAll(result.requestedProducts.map((p) => p.trim().toLowerCase()));
      // Keep this session consistent even if API returns only selected_product.
      requestedProducts.add(normalizedKey);
      Get.back(); // Close modal
      Get.snackbar(
        'Success',
        'Product selected: ${productKey.capitalizeFirst}',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        _dioDetail(e) ?? 'Could not select product.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
