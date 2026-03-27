import 'package:get/get.dart';
import '../controllers/trust_controller.dart';

class TrustBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrustController>(() => TrustController());
  }
}
