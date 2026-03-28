import 'package:get/get.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/auth_service.dart';
import '../../../data/providers/identity_provider.dart';

class DocsController extends GetxController {
  final _identityProvider = Get.find<IdentityProvider>();
  final _auth = Get.find<AuthService>();

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

  /// Same host as [ApiService] so previews match API requests.
  String get baseUrl => ApiService.baseUrl;

  String? get frontUrl =>
      _getUrl(identityPaths.value?['media']?['document_front_path']);
  String? get backUrl =>
      _getUrl(identityPaths.value?['media']?['document_back_path']);
  String? get videoUrl => _getUrl(identityPaths.value?['media']?['video_path']);
  String? get soundUrl => _getUrl(identityPaths.value?['media']?['sound_path']);

  String? _getUrl(String? path) {
    if (path == null) return null;
    var cleanPath = path.replaceAll('\n', '').replaceAll('\r', '').trim();
    cleanPath = cleanPath.replaceAll('\\', '/');
    if (cleanPath.isEmpty) return null;

    if (cleanPath.startsWith('http://') || cleanPath.startsWith('https://')) {
      return _withUserIdQuery(Uri.parse(cleanPath)).toString();
    }

    final base = baseUrl.replaceAll(RegExp(r'/$'), '');
    final rel =
        cleanPath.startsWith('/') ? cleanPath.substring(1) : cleanPath;
    final uri = Uri.parse('$base/$rel');
    return _withUserIdQuery(uri).toString();
  }

  /// Media fetches bypass Dio; many APIs still require `user_id` on the URL.
  Uri _withUserIdQuery(Uri uri) {
    final uid = _auth.userId;
    if (uid == null) return uri;
    return uri.replace(
      queryParameters: {...uri.queryParameters, 'user_id': uid},
    );
  }

  bool get isIdVerified =>
      identityPaths.value?['media']?['document_front_path'] != null;
  bool get isFaceVerified =>
      identityPaths.value?['media']?['video_path'] != null;
  bool get isVoiceVerified =>
      identityPaths.value?['media']?['sound_path'] != null;
}
