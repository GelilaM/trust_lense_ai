import 'package:get/get.dart';

import 'app_routes.dart';

import '../modules/main_layout/bindings/main_layout_binding.dart';
import '../modules/main_layout/views/main_layout_view.dart';

import '../modules/onboarding/views/welcome_view.dart';
import '../modules/onboarding/bindings/welcome_binding.dart';
import '../modules/onboarding/views/login_view.dart';
import '../modules/onboarding/bindings/login_binding.dart';
import '../modules/onboarding/views/signup_view.dart';
import '../modules/onboarding/bindings/signup_binding.dart';
import '../modules/onboarding/views/permissions_view.dart';
import '../modules/onboarding/bindings/permissions_binding.dart';

import '../modules/verification/views/id_capture_view.dart';
import '../modules/verification/bindings/id_capture_binding.dart';
import '../modules/verification/views/liveness_view.dart';
 import '../modules/verification/bindings/liveness_binding.dart';
import '../modules/verification/views/voice_verification_view.dart';
import '../modules/verification/bindings/voice_verification_binding.dart';
import '../modules/verification/views/processing_view.dart';
import '../modules/verification/bindings/processing_binding.dart';

import '../modules/trust/views/trust_view.dart';
import '../modules/trust/bindings/trust_binding.dart';

import '../modules/credit/views/credit_view.dart';
import '../modules/credit/bindings/credit_binding.dart';
import '../modules/profile/views/dashboard_view.dart';
import '../modules/profile/bindings/dashboard_binding.dart';
import '../modules/docs/views/docs_view.dart';
import '../modules/docs/bindings/docs_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/settings/bindings/settings_binding.dart';

class AppPages {
  static const initial = Routes.welcome;

  static final routes = [
    GetPage(
      name: Routes.welcome,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: Routes.signIn,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: Routes.permissions,
      page: () => const PermissionsView(),
      binding: PermissionsBinding(),
    ),
    GetPage(
      name: Routes.idCapture,
      page: () => const IdCaptureView(),
      binding: IdCaptureBinding(),
    ),
     GetPage(
      name: Routes.liveness,
      page: () => const LivenessView(),
      binding: LivenessBinding(),
    ),
    GetPage(
      name: Routes.voiceVerification,
      page: () => const VoiceVerificationView(),
      binding: VoiceVerificationBinding(),
    ),
    GetPage(
      name: Routes.processing,
      page: () => const ProcessingView(),
      binding: ProcessingBinding(),
    ),
    GetPage(
      name: Routes.trustScore,
      page: () => const TrustView(),
      binding: TrustBinding(),
    ),
    GetPage(
      name: Routes.creditReadiness,
      page: () => const CreditView(),
      binding: CreditBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.mainLayout,
      page: () => const MainLayoutView(),
      binding: MainLayoutBinding(),
    ),
    GetPage(
      name: Routes.docs,
      page: () => const DocsView(),
      binding: DocsBinding(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
