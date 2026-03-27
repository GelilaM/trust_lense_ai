import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../routes/app_routes.dart';

class PermissionsController extends GetxController {
  final isRequesting = false.obs;

  Future<void> requestPermissions() async {
    isRequesting.value = true;

    // Request Camera & Mic
    await [Permission.camera, Permission.microphone].request();

    isRequesting.value = false;

    // Proceed regardless for hackathon/demo purposes, though typically we might block
    Get.toNamed(Routes.idCapture);
  }
}
