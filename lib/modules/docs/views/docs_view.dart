import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/docs_controller.dart';
import '../widgets/document_card.dart';
import '../widgets/id_mockup.dart';
import '../widgets/face_mesh_mockup.dart';
import '../widgets/voice_waveform_mockup.dart';
import '../widgets/media_preview_dialog.dart';

class DocsView extends GetView<DocsController> {
  const DocsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Document Center',
          style: context.textTheme.headlineMedium?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: context.theme.colorScheme.primary,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shield_outlined,
              color: context.theme.colorScheme.secondary,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF0F766E)),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Text(
                  'Verification Assets',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'These cryptographic records secure your identity and enable high-trust financial services.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.theme.colorScheme.onSurface.withValues(
                      alpha: 0.6,
                    ),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 24.h),

                DocumentCard(
                  title: 'National ID',
                  subtitle: 'Government Issued',
                  status: controller.isIdVerified ? 'Verified' : 'Pending',
                  icon: Icons.badge_outlined,
                  child: const IdMockup(),
                  onTap: () {
                    final url = controller.frontUrl;
                    if (url != null) {
                      Get.dialog(
                        MediaPreviewDialog(url: url, title: 'National ID'),
                      );
                    }
                  },
                ),
                SizedBox(height: 16.h),

                DocumentCard(
                  title: 'Biometric Face Map',
                  subtitle: '3D Liveness Detection',
                  status: controller.isFaceVerified ? 'Active' : 'Not Uploaded',
                  icon: Icons.face_retouching_natural,
                  child: const FaceMeshMockup(),
                  onTap: () {
                    final url = controller.videoUrl;
                    if (url != null) {
                      Get.dialog(
                        MediaPreviewDialog(
                          url: url,
                          title: 'Biometric Face Map',
                          isVideo: true,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 16.h),

                DocumentCard(
                  title: 'Voice Signature',
                  subtitle: 'Acoustic Print',
                  status: controller.isVoiceVerified
                      ? 'Stored'
                      : 'Not Recorded',
                  icon: Icons.graphic_eq,
                  child: const VoiceWaveformMockup(),
                  onTap: () {
                    final url = controller.soundUrl;
                    if (url != null) {
                      // We can use the same video player for audio
                      Get.dialog(
                        MediaPreviewDialog(
                          url: url,
                          title: 'Voice Signature',
                          isVideo: true,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}
