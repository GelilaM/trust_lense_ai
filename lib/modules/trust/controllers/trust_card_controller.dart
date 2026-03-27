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
      final result = await _provider.selectProduct(_auth.userId!, productKey);
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
      Get.snackbar('Error', 'Could not select product.');
    } finally {
      isLoading.value = false;
    }
  }
}
