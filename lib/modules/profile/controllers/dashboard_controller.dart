import 'package:get/get.dart';
import '../../../data/models/eligible_model.dart';
import '../../../data/models/trust_result_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/identity_provider.dart';

class DashboardController extends GetxController {
  final _identityProvider = Get.find<IdentityProvider>();

  final isLoading = true.obs;
  final userProfile = Rxn<UserModel>();
  final trustResult = Rxn<TrustResultModel>();
  final eligibility = Rxn<EligibleModel>();

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      
      // Fetch data in parallel
      final results = await Future.wait([
        _identityProvider.getProfile(),
        _identityProvider.getTrustResult(),
        _identityProvider.getEligible(),
      ]);

      userProfile.value = results[0] as UserModel;
      trustResult.value = results[1] as TrustResultModel;
      eligibility.value = results[2] as EligibleModel;
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to load dashboard data');
    } finally {
      isLoading.value = false;
    }
  }
}
