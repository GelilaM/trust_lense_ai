import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/identity_provider.dart';

class SettingsController extends GetxController {
  final _identityProvider = Get.find<IdentityProvider>();

  final isLoading = true.obs;
  final userProfile = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    fetchSettingsData();
  }

  Future<void> fetchSettingsData() async {
    try {
      isLoading.value = true;
      userProfile.value = await _identityProvider.getProfile();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load settings data');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    Get.offAllNamed('/welcome');
  }
}
