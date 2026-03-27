import 'package:get/get.dart';
import '../controllers/id_capture_controller.dart';

class IdCaptureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IdCaptureController>(() => IdCaptureController());
  }
}
