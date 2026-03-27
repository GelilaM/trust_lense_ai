import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/profile_dashboard_controller.dart';
import '../../trust/controllers/trust_card_controller.dart';
import '../../../widgets/global_trust_rating_card.dart';
import '../../../widgets/profile_ai_insight_card.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/event_item.dart';
import '../../../widgets/trust_card_widget.dart';
import '../../../widgets/base_button.dart';
import '../../../data/models/trust_card_model.dart';

class ProfileDashboardView extends GetView<ProfileDashboardController> {
  const ProfileDashboardView({super.key});

  static final List<TrustCardProductOption> _defaultProducts = [
    TrustCardProductOption(
      key: 'loan',
      label: 'Loan',
      description: 'Get financing offers based on your trust profile.',
    ),
    TrustCardProductOption(
      key: 'credit_card',
      label: 'Credit Card',
      description: 'Access curated credit card options.',
    ),
    TrustCardProductOption(
      key: 'device_financing',
      label: 'BNPL',
      description: 'Request device financing and BNPL support.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final trustCardController = Get.find<TrustCardController>();

    return Scaffold(
      backgroundColor:
          context.theme.colorScheme.surface, // Clean white background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 20.w, // Just some padding
        leading: const SizedBox.shrink(),
        title: Text(
          'Trust Profile',
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
              Icons.share_outlined,
              color: context.theme.colorScheme.primary,
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

        final profile = controller.userProfile.value;
        final trust = controller.trustResult.value;
        final score = trust?.combined.combinedScore ?? 0;
        final hasCard = trustCardController.card.value != null;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                GlobalTrustRatingCard(
                  score: score,
                  level: score >= 80
                      ? 'EXCELLENT'
                      : score >= 50
                      ? 'GOOD'
                      : 'POOR',
                ),
                SizedBox(height: 24.h),
                ProfileAiInsightCard(
                  fullName: profile?.fullName ?? 'User',
                  onBoostScorePressed: () {},
                ),
                SizedBox(height: 32.h),

                // Trust Card Section
                SectionHeader(
                  title: 'Digital Trust Card',
                  subtitle: hasCard ? 'Active' : '',
                  actionText: hasCard ? 'Details' : '',
                ),
                SizedBox(height: 16.h),
                if (hasCard)
                  TrustCardWidget(
                    card: trustCardController.card.value!,
                    onSelectProductPressed: () =>
                        _showProductSelectionModal(context),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: context.theme.colorScheme.primary.withValues(
                          alpha: 0.1,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.credit_card_outlined,
                          size: 48.w,
                          color: score > 45
                              ? context.theme.colorScheme.secondary
                              : context.theme.colorScheme.onSurface.withValues(
                                  alpha: 0.3,
                                ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          score > 45
                              ? 'You are eligible for a Trust Card!'
                              : 'You are currently not eligible',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          score > 45
                              ? 'Unlock your virtual fiduciary card to access premium financial products.'
                              : 'A Trust Score of 45+ is required to request a Digital Fiduciary Card.',
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.theme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                        if (score > 45) ...[
                          SizedBox(height: 24.h),
                          BaseButton(
                            text: 'Select Product',
                            onPressed: () => _showProductSelectionModal(context),
                          ),
                        ],
                      ],
                    ),
                  ),

                SizedBox(height: 32.h),
                SectionHeader(
                  title: 'Verification Integrity',
                  subtitle: 'Snapshot',
                  actionText: 'History',
                ),
                SizedBox(height: 16.h),
                Column(
                  children: [
                    EventItem(
                      dateStr: 'LATEST',
                      title: 'Biometric Analysis',
                      subtitle: trust != null
                          ? 'Identity verified via multi-modal AI'
                          : 'Pending verification',
                      points: trust != null
                          ? '+${trust.combined.combinedScore}'
                          : '0',
                    ),
                    if (trust != null) ...[
                      SizedBox(height: 12.h),
                      EventItem(
                        dateStr: 'MODALITY',
                        title: 'Document Credibility',
                        subtitle: 'Official government ID verification',
                        points: '${trust.combined.documentScore}',
                      ),
                      SizedBox(height: 12.h),
                      EventItem(
                        dateStr: 'MODALITY',
                        title: 'Video Liveness',
                        subtitle: '3D facial behavioral check',
                        points: '${trust.combined.videoScore}',
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _showProductSelectionModal(BuildContext context) {
    final cardController = Get.find<TrustCardController>();
    final card = cardController.card.value;
    final products = card?.availableProducts ?? _defaultProducts;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 24.h),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.onSurface.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              'Link Financial Product',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: context.theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Request one product per type. You can still request other eligible products.',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 24.h),
            ...products.map((product) {
              final productKey = product.key.trim().toLowerCase();
              final alreadyRequested = cardController.requestedProducts
                  .contains(productKey);
              final isSelected = card?.selectedProduct == product.key;
              return Container(
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: alreadyRequested
                      ? context.theme.colorScheme.surfaceContainerHighest
                      : isSelected
                      ? context.theme.colorScheme.secondary.withOpacity(0.05)
                      : context.theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: alreadyRequested
                        ? context.theme.colorScheme.onSurface.withOpacity(0.1)
                        : isSelected
                        ? context.theme.colorScheme.secondary
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 8.h,
                  ),
                  title: Text(
                    product.label,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    alreadyRequested
                        ? 'Already requested'
                        : product.description,
                    style: context.textTheme.bodySmall,
                  ),
                  trailing: alreadyRequested
                      ? Icon(
                          Icons.lock_outline,
                          color: context.theme.colorScheme.onSurface
                              .withOpacity(0.5),
                        )
                      : isSelected
                      ? Icon(
                          Icons.check_circle,
                          color: context.theme.colorScheme.secondary,
                        )
                      : Icon(
                          Icons.add_circle_outline,
                          color: context.theme.colorScheme.onSurface
                              .withOpacity(0.2),
                        ),
                  onTap: alreadyRequested
                      ? null
                      : () => cardController.selectProduct(product.key),
                ),
              );
            }),
            SizedBox(height: 24.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
