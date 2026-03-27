import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../data/providers/identity_provider.dart';
import '../../../data/models/trust_result_model.dart';
import 'package:flutter/material.dart';

class TrustController extends GetxController {
  final _identityProvider = Get.find<IdentityProvider>();

  final trustScore = 0.obs;
  final readiness = 'PENDING'.obs;
  final isLoading = true.obs;
  final trustResult = Rxn<TrustResultModel>();

  @override
  void onInit() {
    super.onInit();
    fetchTrustResult();
  }

  Future<void> fetchTrustResult() async {
    isLoading.value = true;
    try {
      final result = await _identityProvider.getTrustResult();
      trustResult.value = result;
      trustScore.value = result.combined.combinedScore;

      if (trustScore.value >= 80) {
        readiness.value = 'HIGH';
      } else if (trustScore.value >= 50) {
        readiness.value = 'MEDIUM';
      } else {
        readiness.value = 'LOW';
      }
    } catch (e) {
      debugPrint('Error fetching trust result: $e');
      Get.snackbar(
        'Error',
        'Failed to fetch trust results',
        backgroundColor: Colors.redAccent.withValues(alpha: 0.2),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void continueToCredit() {
    Get.toNamed(Routes.creditReadiness);
  }
}
