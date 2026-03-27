import 'package:get/get.dart';
import '../controllers/main_layout_controller.dart';
import '../../profile/controllers/dashboard_controller.dart';
import '../../profile/controllers/profile_dashboard_controller.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../docs/controllers/docs_controller.dart';

class MainLayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainLayoutController>(() => MainLayoutController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<ProfileDashboardController>(() => ProfileDashboardController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<DocsController>(() => DocsController());
  }
}
