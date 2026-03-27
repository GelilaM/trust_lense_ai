import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/service_card.dart';
import '../../../widgets/ai_insight_card.dart';
import '../../../widgets/activity_item.dart';
import '../../../widgets/trust_card_widget.dart';
import '../controllers/dashboard_controller.dart';
import '../../trust/controllers/trust_card_controller.dart';
import '../../../data/models/trust_card_model.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

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
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface, // #F7F9FC
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 70.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: CircleAvatar(
            backgroundColor: context.theme.colorScheme.surfaceContainerLow,
            child: Icon(
              Icons.person_outline,
              color: context.theme.colorScheme.primary,
            ),
          ),
        ),
        title: Text(
          'TrustLens AI',
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
              Icons.notifications_none_outlined,
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

        // ignore: unused_local_variable
        final profile = controller.userProfile.value;
        final trust = controller.trustResult.value;
        final eligible = controller.eligibility.value;

        return RefreshIndicator(
          onRefresh: () => controller.fetchDashboardData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Obx(() {
                    final cardController = Get.find<TrustCardController>();
                    final trustScore = trust?.combined.combinedScore ?? 0;
                    final isLocked = trustScore <= 45;
                    
                    return TrustCardWidget(
                      card: cardController.card.value,
                      isLocked: isLocked,
                      onIssuePressed: () => _showProductSelectionModal(context),
                      onSelectProductPressed: () => _showProductSelectionModal(context),
                    );
                  }),
                  SizedBox(height: 32.h),
                  SectionHeader(
                    title: 'Financial Services',
                    actionText: 'View All',
                  ),
                  SizedBox(height: 16.h),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.1,
                    children: [
                      ServiceCard(
                        icon: Icons.account_balance_outlined,
                        title: 'Loan',
                        subtitle: eligible?.loanOffer ?? 'Instant Approval',
                        isActive: eligible?.eligibleForLoan ?? false,
                      ),
                      ServiceCard(
                        icon: Icons.credit_card_outlined,
                        title: 'Credit Card',
                        subtitle: eligible?.creditCardOffer ?? 'Limit Upgrades',
                        isActive: eligible?.eligibleForCreditCard ?? false,
                      ),
                      ServiceCard(
                        icon: Icons.shopping_cart_outlined,
                        title: 'BNPL',
                        subtitle: eligible?.deviceFinancingOffer ?? 'Device Finance',
                        isActive: eligible?.eligibleForDeviceFinancing ?? false,
                      ),
                      ServiceCard(
                        icon: Icons.fingerprint_outlined,
                        title: 'Identity',
                        subtitle: 'Privacy Vault',
                        isActive: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  AiInsightCard(
                    textPart1: 'AI Insight: ',
                    textPart2: trust != null 
                        ? 'Your strongest modality is ${trust.combined.videoScore >= 80 ? "Video" : "Document"}. Complete all checks for maximum trust.'
                        : 'Complete your identity verification to unlock premium AI insights and higher credit limits.',
                  ),
                  SizedBox(height: 32.h),
                  SectionHeader(
                    title: 'Recent Activity',
                    actionText: 'history',
                    isIcon: true,
                  ),
                  SizedBox(height: 16.h),
                  Column(
                    children: [
                      ActivityItem(
                        icon: Icons.check_circle_outline,
                        title: 'ID Verification',
                        subtitle: trust != null ? 'Trust Score: ${trust.combined.combinedScore}%' : 'Pending',
                        status: trust != null ? 'Completed' : 'Action Required',
                        time: 'LATEST',
                      ),
                      SizedBox(height: 12.h),
                      ActivityItem(
                        icon: Icons.storage_outlined,
                        title: 'Credit Assessment',
                        subtitle: eligible != null ? eligible.loanTier : 'Evaluating',
                        status: eligible != null ? 'Updated' : 'Pending',
                        time: 'RECENT',
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
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
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Product',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
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
              final alreadyRequested = cardController.requestedProducts.contains(
                productKey,
              );
              final isSelected = card?.selectedProduct == product.key;
              return Container(
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: alreadyRequested
                      ? context.theme.colorScheme.surfaceContainerHighest
                      : isSelected
                      ? context.theme.colorScheme.primary.withOpacity(0.05)
                      : context.theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: alreadyRequested
                        ? context.theme.colorScheme.onSurface.withOpacity(0.1)
                        : isSelected
                        ? context.theme.colorScheme.primary
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  title: Text(
                    product.label,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    alreadyRequested ? 'Already requested' : product.description,
                  ),
                  trailing: alreadyRequested
                      ? Icon(
                          Icons.lock_outline,
                          color: context.theme.colorScheme.onSurface.withOpacity(
                            0.5,
                          ),
                        )
                      : isSelected
                      ? Icon(
                          Icons.check_circle,
                          color: context.theme.colorScheme.primary,
                        )
                      : null,
                  onTap: alreadyRequested
                      ? null
                      : () => cardController.selectProduct(product.key),
                ),
              );
            }),
            SizedBox(height: 16.h),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
