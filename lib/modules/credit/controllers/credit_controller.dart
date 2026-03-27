import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../data/providers/identity_provider.dart';
import '../../../data/models/eligible_model.dart';
import 'package:flutter/material.dart';


class CreditController extends GetxController {
  final _identityProvider = Get.find<IdentityProvider>();
  
  final isLoading = true.obs;
  final eligibility = Rxn<EligibleModel>();

  @override
  void onInit() {
    super.onInit();
    fetchEligibility();
  }

  Future<void> fetchEligibility() async {
    isLoading.value = true;
    try {
      final result = await _identityProvider.getEligible();
      eligibility.value = result;
    } catch (e) {
      debugPrint('Error fetching eligibility: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void continueToDashboard() {
    Get.offAllNamed(Routes.mainLayout);
  }
}

