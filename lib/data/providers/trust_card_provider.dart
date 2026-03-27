import 'package:get/get.dart';
import '../models/trust_card_model.dart';
import '../../core/services/api_service.dart';

class TrustCardProvider {
  final ApiService _apiService = Get.find<ApiService>();

  Future<TrustCardModel?> getCard(String userId) async {
    try {
      final response = await _apiService.dio.get(
        '/trust-card',
        queryParameters: {'user_id': userId},
      );
      if (response.statusCode == 200) {
        return TrustCardModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      // 404/403 are expected when card doesn't exist or score is low
      return null;
    }
  }

  Future<TrustCardModel> selectProduct(String userId, String product) async {
    final response = await _apiService.dio.post(
      '/trust-card/select',
      queryParameters: {'user_id': userId},
      data: {'product': product},
    );
    return TrustCardModel.fromJson(response.data);
  }
}
