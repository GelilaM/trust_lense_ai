import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../core/services/auth_service.dart';


class SignupController extends GetxController {
  final _authProvider = Get.find<AuthProvider>();
  final _authService = Get.find<AuthService>();

  final currentStep = 1.obs;
  final isLoading = false.obs;


  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final occupationController = TextEditingController();
  final businessTypeController = TextEditingController();
  final nationalityController = TextEditingController();
  final dateOfBirth = Rxn<DateTime>();

  final incomeRange = ''.obs;
  final selectedOccupation = RxnString();
  final occupations = [
    'Farmer',
    'Business Person',
    'Freelancer',
    'Employee',
    'Student',
    'Other',
  ];
  final sex = ''.obs;
  final nameError = RxnString();
  final phoneError = RxnString();
  final passwordError = RxnString();
  final occupationError = RxnString();
  final sexError = RxnString();
  final incomeError = RxnString();
  final nationalityError = RxnString();
  final dobError = RxnString();

  bool validateStep1() {
    bool isValid = true;
    if (nameController.text.trim().isEmpty) {
      nameError.value = 'Full name is required';
      isValid = false;
    } else if (nameController.text.trim().split(' ').length < 2) {
      nameError.value = 'Please enter your full name (at least 2 words)';
      isValid = false;
    } else {
      nameError.value = null;
    }

    if (phoneController.text.trim().isEmpty) {
      phoneError.value = 'Phone number is required';
      isValid = false;
    } else if (!GetUtils.isPhoneNumber(phoneController.text.trim())) {
      phoneError.value = 'Please enter a valid phone number';
      isValid = false;
    } else {
      phoneError.value = null;
    }

    if (passwordController.text.trim().isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    } else if (passwordController.text.trim().length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      isValid = false;
    } else {
      passwordError.value = null;
    }
    return isValid;
  }

  bool validateStep2() {
    bool isValid = true;
    if (selectedOccupation.value == null) {
      occupationError.value = 'Occupation is required';
      isValid = false;
    } else {
      occupationError.value = null;
    }

    if (sex.value.isEmpty) {
      sexError.value = 'Sex is required';
      isValid = false;
    } else {
      sexError.value = null;
    }

    if (nationalityController.text.trim().isEmpty) {
      nationalityError.value = 'Nationality is required';
      isValid = false;
    } else {
      nationalityError.value = null;
    }

    if (dateOfBirth.value == null) {
      dobError.value = 'Date of birth is required';
      isValid = false;
    } else {
      dobError.value = null;
    }

    return isValid;
  }

  bool validateStep3() {
    if (incomeRange.value.isEmpty) {
      incomeError.value = 'Please select your monthly income range';
      return false;
    }
    incomeError.value = null;
    return true;
  }

  void nextStep() {
    bool canProceed = false;
    if (currentStep.value == 1) {
      canProceed = validateStep1();
    } else if (currentStep.value == 2) {
      canProceed = validateStep2();
    } else if (currentStep.value == 3) {
      canProceed = validateStep3();
    }

    if (canProceed) {
      if (currentStep.value < 3) {
        currentStep.value++;
      } else {
        _performSignup();
      }
    }
  }

  Future<void> _performSignup() async {
    isLoading.value = true;
    try {
      // Parse income to double
      double income = 0;
      if (incomeRange.value.contains('-')) {
        income = double.tryParse(incomeRange.value.split('-')[0].replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      } else if (incomeRange.value.contains('+')) {
        income = double.tryParse(incomeRange.value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      }

      final user = await _authProvider.signUp(
        fullName: nameController.text.trim(),
        phone: phoneController.text.trim(),
        sex: sex.value,
        dateOfBirth: dateOfBirth.value!.toIso8601String().split('T')[0],
        nationality: nationalityController.text.trim(),
        occupation: selectedOccupation.value ?? '',
        businessType: businessTypeController.text.trim().isEmpty ? 'N/A' : businessTypeController.text.trim(),
        monthlyIncome: income,
        password: passwordController.text.trim(),
      );

      await _authService.saveUser(user.id);
      
      Get.snackbar(
        'Welcome!',
        'Account created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF44DDC2).withValues(alpha: 0.2),
        colorText: Colors.white,
      );

      Get.offAllNamed(Routes.permissions);
    } catch (e) {
      Get.snackbar(
        'Signup Failed',
        e.toString().contains('409') 
            ? 'Phone number already registered' 
            : 'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.2),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }


  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: context.theme.copyWith(
            colorScheme: context.theme.colorScheme.copyWith(
              primary: context.theme.colorScheme.primary,
              onPrimary: Colors.white,
              surface: context.theme.colorScheme.surface,
              onSurface: context.theme.colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != dateOfBirth.value) {
      dateOfBirth.value = picked;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    occupationController.dispose();
    businessTypeController.dispose();
    nationalityController.dispose();
    super.onClose();
  }
}
