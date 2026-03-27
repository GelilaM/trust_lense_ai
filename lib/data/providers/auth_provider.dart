import 'package:get/get.dart' hide Response;

import '../../../core/services/api_service.dart';
import '../models/user_model.dart';

class AuthProvider {
  final ApiService _api = Get.find<ApiService>();

  Future<UserModel> signUp({
    required String fullName,
    required String phone,
    required String sex,
    required String dateOfBirth,
    required String nationality,
    required String occupation,
    required String businessType,
    required double monthlyIncome,
    required String password,
  }) async {
    try {
      final response = await _api.dio.post(
        '/auth/sign-up',
        data: {
          'full_name': fullName,
          'phone': phone,
          'sex': sex,
          'date_of_birth': dateOfBirth,
          'nationality': nationality,
          'occupation': occupation,
          'business_type': businessType,
          'monthly_income': monthlyIncome,
          'password': password,
        },
      );
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signIn({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _api.dio.post(
        '/auth/sign-in',
        data: {
          'phone': phone,
          'password': password,
        },
      );
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
