import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';
import 'core/services/api_service.dart';
import 'core/services/auth_service.dart';
import 'core/services/verification_service.dart';
import 'data/providers/auth_provider.dart';
import 'data/providers/identity_provider.dart';
import 'modules/trust/controllers/trust_card_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Services
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => ApiService().init());
  Get.put(VerificationService());

  runApp(const TrustLensApp());
}

class TrustLensApp extends StatelessWidget {
  const TrustLensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852), // Typical iPhone 14/15 Pro size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TrustLens AI',
          theme: AppTheme.lightTheme,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          initialBinding: BindingsBuilder(() {
            Get.put(AuthProvider(), permanent: true);
            Get.put(IdentityProvider(), permanent: true);
            Get.put(TrustCardController(), permanent: true);
          }),
        );
      },
    );
  }
}
