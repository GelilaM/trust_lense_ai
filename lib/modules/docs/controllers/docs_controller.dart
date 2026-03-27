import 'package:get/get.dart';
import '../../../data/providers/identity_provider.dart';

class DocsController extends GetxController {
  final _identityProvider = Get.find<IdentityProvider>();

  final isLoading = true.obs;
  final identityPaths = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    fetchDocsData();
  }

  Future<void> fetchDocsData() async {
    try {
      isLoading.value = true;
      identityPaths.value = await _identityProvider.getIdentityPaths();
    } catch (e) {
      // If 404, it means no identity yet, which is fine
      identityPaths.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  String get baseUrl => 'http://192.168.7.241:8000';

  String? get frontUrl =>
      _getUrl(identityPaths.value?['media']?['document_front_path']);
  String? get backUrl =>
      _getUrl(identityPaths.value?['media']?['document_back_path']);
  String? get videoUrl => _getUrl(identityPaths.value?['media']?['video_path']);
  String? get soundUrl => _getUrl(identityPaths.value?['media']?['sound_path']);

  String? _getUrl(String? path) {
    if (path == null) return null;
    // Remove any newlines or extra spaces that might be in the response
    final cleanPath = path.replaceAll('\n', '').replaceAll('\r', '').trim();
    if (cleanPath.isEmpty) return null;

    if (cleanPath.startsWith('http')) return cleanPath;
    final separator = cleanPath.startsWith('/') ? '' : '/';
    return '$baseUrl$separator$cleanPath';
  }

  bool get isIdVerified =>
      identityPaths.value?['media']?['document_front_path'] != null;
  bool get isFaceVerified =>
      identityPaths.value?['media']?['video_path'] != null;
  bool get isVoiceVerified =>
      identityPaths.value?['media']?['sound_path'] != null;
}
