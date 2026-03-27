import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import '../../../core/services/api_service.dart';
import '../models/identity_model.dart';
import '../models/trust_result_model.dart';
import '../models/eligible_model.dart';
import '../models/user_model.dart';


class IdentityProvider {
  final ApiService _api = Get.find<ApiService>();

  Future<IdentitySubmissionModel> uploadIdentity({
    required String frontPath,
    required String backPath,
    required String videoPath,
    required String audioPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'document_front': await MultipartFile.fromFile(frontPath),
        'document_back': await MultipartFile.fromFile(backPath),
        'video': await MultipartFile.fromFile(videoPath),
        'sound': await MultipartFile.fromFile(audioPath),
      });

      final response = await _api.dio.post(
        '/identity',
        data: formData,
      );
      
      return IdentitySubmissionModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<TrustResultModel> getTrustResult() async {
    try {
      final response = await _api.dio.post('/trust-result');
      return TrustResultModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<EligibleModel> getEligible() async {
    try {
      final response = await _api.dio.post('/eligible');
      return EligibleModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await _api.dio.get('/profile');
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getIdentityPaths() async {
    try {
      final response = await _api.dio.get('/identity');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

