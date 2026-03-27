import 'package:get/get.dart';
import '../../../data/models/trust_result_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/identity_provider.dart';

class ProfileDashboardController extends GetxController {
  final _identityProvider = Get.find<IdentityProvider>();

  final isLoading = true.obs;
  final userProfile = Rxn<UserModel>();
  final trustResult = Rxn<TrustResultModel>();

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        _identityProvider.getProfile(),
        _identityProvider.getTrustResult(),
      ]);

      userProfile.value = results[0] as UserModel;
      trustResult.value = results[1] as TrustResultModel;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile data');
    } finally {
      isLoading.value = false;
    }
  }
}
