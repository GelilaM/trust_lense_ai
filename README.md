# TrustLens AI

TrustLens AI is a Flutter app for onboarding and trust verification workflows.
It combines identity capture, liveness checks, voice verification, and trust scoring
into a guided flow with a dashboard-oriented UI.

## What the app includes

- Onboarding flow: welcome, sign up, sign in, permissions.
- Verification flow: ID capture, liveness video, voice verification, processing.
- Trust flow: trust score visualization with detailed modality breakdown.
- Additional modules: credit readiness, docs, settings, dashboard/profile tabs.
- State management and routing with GetX.

## Tech stack

- Flutter (Dart 3)
- GetX (`get`) for DI, navigation, and reactive controllers
- Dio (`dio`, `pretty_dio_logger`) for API access
- Local persistence with `shared_preferences` and `flutter_secure_storage`
- Media/verification-related packages:
  - `camera`, `image_picker`, `video_player`, `record`
  - `google_mlkit_face_detection`
  - `permission_handler`, `path_provider`
- UI helpers:
  - `flutter_screenutil`, `google_fonts`, `lottie`, `flutter_spinkit`, `fl_chart`

## Project structure

Key directories:

- `lib/core/` - app-wide services and theming
- `lib/data/` - models and providers
- `lib/modules/` - feature modules (onboarding, verification, trust, credit, docs, settings, profile)
- `lib/routes/` - route names and page definitions
- `lib/widgets/` - reusable UI widgets

Entry point:

- `lib/main.dart`

## Setup

1. Install Flutter SDK and verify your environment:
   - `flutter doctor`
2. Install dependencies:
   - `flutter pub get`
3. Run the app:
   - `flutter run`

## Backend/API notes

The app uses `ApiService` with a configured base URL in:

- `lib/core/services/api_service.dart`

Current default:

- `http://192.168.7.241:8000`

If you run the backend elsewhere (or on a physical device), update this URL accordingly.

## Main navigation flow

Typical user journey:

1. `welcome` -> `signup`/`sign_in`
2. `permissions`
3. `id_capture`
4. `liveness`
5. `voice_verification`
6. `processing`
7. `trust_score`
8. `credit_readiness`
9. `main_layout` (dashboard/profile/docs/settings tabs)

## Development notes

- Screen scaling is initialized through `flutter_screenutil` in `main.dart`.
- Core services are initialized at startup (`AuthService`, `ApiService`, `VerificationService`).
- `AuthService` stores the active `user_id` in shared preferences and appends it to protected API requests.
