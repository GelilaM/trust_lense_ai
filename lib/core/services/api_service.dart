import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:get/get.dart' hide Response;
import 'auth_service.dart';

class ApiService extends GetxService {
  late Dio _dio;

  // Update this to your local server IP if testing on a physical device
  static const String baseUrl = 'http://192.168.7.180:8000';

  Dio get dio => _dio;

  Future<ApiService> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: 'application/json',
      ),
    );

    // Add Logging
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    // Add User ID Interceptor for protected routes
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final authService = Get.find<AuthService>();
          if (authService.isLoggedIn && !options.path.contains('/auth/')) {
            options.queryParameters['user_id'] = authService.userId;
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Global error handling can go here
          return handler.next(e);
        },
      ),
    );

    return this;
  }
}
