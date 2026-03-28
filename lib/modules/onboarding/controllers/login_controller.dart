import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/phone_validation.dart';

class LoginController extends GetxController {
  final _authProvider = AuthProvider();
  final _authService = Get.find<AuthService>();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final phoneError = RxnString();
  final passwordError = RxnString();
  final obscurePassword = true.obs;

  Future<void> login() async {
    if (!_validate()) return;

    try {
      isLoading.value = true;
      final user = await _authProvider.signIn(
        phone: PhoneValidation.normalizeDigits(phoneController.text),
        password: passwordController.text,
      );

      await _authService.saveUser(user.id);
      Get.offAllNamed('/main_layout');
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        'Invalid phone number or password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withValues(alpha: 0.1),
        colorText: Get.theme.colorScheme.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  bool _validate() {
    bool isValid = true;
    final phoneErr = PhoneValidation.validate(phoneController.text);
    if (phoneErr != null) {
      phoneError.value = phoneErr;
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
