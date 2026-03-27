import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../core/services/auth_service.dart';

class LoginController extends GetxController {
  final _authProvider = AuthProvider();
  final _authService = Get.find<AuthService>();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final phoneError = RxnString();
  final passwordError = RxnString();

  Future<void> login() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;
      final user = await _authProvider.signIn(
        phone: phoneController.text.trim(),
        password: passwordController.text,
      );

      await _authService.saveUser(user.id);
      Get.offAllNamed('/main_layout');
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        'Invalid phone number or password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.1),
        colorText: Get.theme.colorScheme.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool _validate() {
    bool isValid = true;
    if (phoneController.text.trim().isEmpty) {
      phoneError.value = 'Phone number is required';
      isValid = false;
    } else {
      phoneError.value = null;
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    } else {
      passwordError.value = null;
    }

    return isValid;
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
