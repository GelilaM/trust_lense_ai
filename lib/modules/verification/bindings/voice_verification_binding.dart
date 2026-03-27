import 'package:get/get.dart';
import '../controllers/voice_verification_controller.dart';

class VoiceVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoiceVerificationController>(
      () => VoiceVerificationController(),
    );
  }
}
