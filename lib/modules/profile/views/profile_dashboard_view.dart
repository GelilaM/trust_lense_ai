import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/profile_dashboard_controller.dart';
import '../../trust/controllers/trust_card_controller.dart';
import '../../../widgets/global_trust_rating_card.dart';
import '../../../widgets/profile_ai_insight_card.dart';
import '../../../widgets/section_header.dart';
import '../../../widgets/event_item.dart';
import '../../../widgets/trust_card_widget.dart';
import '../../../widgets/base_button.dart';
import '../../../data/models/trust_card_model.dart';
import '../../../data/models/trust_result_model.dart';
import '../../../data/models/user_model.dart';

class ProfileDashboardView extends GetView<ProfileDashboardController> {
  const ProfileDashboardView({super.key});

  static const Color _accent = Color(0xFF44DDC2);
  static const Color _ink = Color(0xFF0A1926);

  static final List<TrustCardProductOption> _defaultProducts = [
    TrustCardProductOption(
      key: 'loan',
      label: 'Loan',
      description: 'Get financing offers based on your trust profile.',
    ),
    TrustCardProductOption(
      key: 'invoice_financing',
      label: 'Invoice financing',
      description: 'Access invoice financing options.',
    ),
    TrustCardProductOption(
      key: 'device_financing',
      label: 'BNPL',
      description: 'Request device financing and BNPL support.',
    ),
  ];

  static String _maskPhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 4) return '••••';
    return '•••• ${digits.substring(digits.length - 4)}';
  }

  static String _shortSubmissionId(String id) {
    if (id.length < 8) return id;
    return '…${id.substring(id.length - 8)}';
  }

  static (String label, int score) _weakestModality(TrustResultModel t) {
    final rows = <(String, int)>[
      ('Document', t.document.sectionScore),
      ('Video', t.video.sectionScore),
      ('Voice', t.audio.sectionScore),
    ];
    rows.sort((a, b) => a.$2.compareTo(b.$2));
    return rows.first;
  }

  static String _kycSubtitle(UserModel p) {
    final dob = p.dateOfBirth ?? '—';
    final nat = p.nationality ?? '—';
    return 'DOB $dob · Nationality $nat · ${p.sex}';
  }

  static String _criteriaSummary(ModalityTrustBreakdown m) {
    var pass = 0, fail = 0, uncertin = 0;
    for (final c in m.criteria) {
      switch (c.status) {
        case 'pass':
          pass++;
        case 'fail':
          fail++;
        default:
          uncertin++;
      }
    }
    return '$pass pass · $fail fail · $uncertin open';
  }

  static IconData _iconForProduct(String key) {
    switch (key.trim().toLowerCase()) {
      case 'loan':
        return Icons.account_balance_outlined;
      case 'invoice_financing':
        return Icons.receipt_long_outlined;
      case 'device_financing':
        return Icons.smartphone_outlined;
      default:
        return Icons.layers_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final trustCardController = Get.find<TrustCardController>();
    final scheme = context.theme.colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: scheme.secondary,
              strokeWidth: 2.5,
            ),
          );
        }

        final profile = controller.userProfile.value;
        final trust = controller.trustResult.value;
        final modalityInsight = trust != null ? _weakestModality(trust) : null;
        final score = trust?.combined.combinedScore ?? 0;
        final card = trustCardController.card.value;
        final hasCard = card != null;
        final products = card?.availableProducts ?? _defaultProducts;
        final showAddProductAction = hasCard && products.length > 1;

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              elevation: 0,
              backgroundColor: const Color(0xFFF9FAFB),
              surfaceTintColor: Colors.transparent,
              automaticallyImplyLeading: false,
              toolbarHeight: 56.h,
              title: Text(
                'Trust Profile',
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: _ink,
                  letterSpacing: -0.5,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.share_outlined, color: _ink, size: 22.w),
                  onPressed: () {},
                ),
                SizedBox(width: 4.w),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 8.h),
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
                  SizedBox(height: 28.h),
                  SectionHeader(
                    title: 'Digital Trust Card',
                    subtitle: null,
                    actionText: '',
                    actionIcon: showAddProductAction
                        ? Icons.add_circle_outline
                        : null,
                    onActionTap: showAddProductAction
                        ? () => _showProductSelectionModal(context)
                        : null,
                  ),
                  SizedBox(height: 14.h),
                  if (hasCard)
                    TrustCardWidget(
                      card: trustCardController.card.value!,
                      onSelectProductPressed: () =>
                          _showProductSelectionModal(context),
                    )
                  else
                    _TrustCardPlaceholder(
                      score: score,
                      onAddPressed: () => _showProductSelectionModal(context),
                    ),
                  SizedBox(height: 32.h),
                  SectionHeader(
                    title: 'Verification Integrity',
                    subtitle: 'Snapshot',
                    actionText: 'History',
                  ),
                  SizedBox(height: 16.h),
                  if (profile != null) ...[
                    EventItem(
                      dateStr: 'ACCOUNT',
                      title: 'Profile on file',
                      subtitle:
                          '${profile.fullName} · ${_maskPhone(profile.phone)} · ${profile.occupation}',
                      points: '✓',
                      isNeutral: true,
                    ),
                    SizedBox(height: 12.h),
                    EventItem(
                      dateStr: 'KYC',
                      title: 'Identity attributes',
                      subtitle: _kycSubtitle(profile),
                      points: '✓',
                      isNeutral: true,
                    ),
                    SizedBox(height: 12.h),
                  ],
                  EventItem(
                    dateStr: 'LATEST',
                    title: 'Biometric analysis',
                    subtitle: trust != null
                        ? 'Combined trust from document, video, and voice'
                        : 'Complete verification to generate your trust snapshot',
                    points: trust != null
                        ? '${trust.combined.combinedScore}'
                        : '—',
                  ),
                  if (trust != null) ...[
                    SizedBox(height: 12.h),
                    EventItem(
                      dateStr: 'REF',
                      title: 'Submission',
                      subtitle:
                          'Latest identity submission reference for support',
                      points: _shortSubmissionId(trust.submissionId),
                      isNeutral: true,
                    ),
                    SizedBox(height: 12.h),
                    EventItem(
                      dateStr: 'INSIGHT',
                      title: 'Modality balance',
                      subtitle:
                          '${modalityInsight!.$1} is the lowest band — focus here to lift your combined score',
                      points: '${modalityInsight.$2}%',
                    ),
                    SizedBox(height: 12.h),
                    EventItem(
                      dateStr: 'MODALITY',
                      title: 'Document credibility',
                      subtitle:
                          '${_criteriaSummary(trust.document)} · Govt. ID checks',
                      points: '${trust.combined.documentScore}',
                    ),
                    SizedBox(height: 12.h),
                    EventItem(
                      dateStr: 'MODALITY',
                      title: 'Video liveness',
                      subtitle:
                          '${_criteriaSummary(trust.video)} · Facial behaviour',
                      points: '${trust.combined.videoScore}',
                    ),
                    SizedBox(height: 12.h),
                    EventItem(
                      dateStr: 'MODALITY',
                      title: 'Voice verification',
                      subtitle:
                          '${_criteriaSummary(trust.audio)} · Speech pattern check',
                      points: '${trust.combined.audioScore}',
                    ),
                  ],
                  SizedBox(height: 40.h),
                ]),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _showProductSelectionModal(BuildContext context) {
    final cardController = Get.find<TrustCardController>();

    Get.bottomSheet(
      Obx(() {
        final card = cardController.card.value;
        final products = card?.availableProducts ?? _defaultProducts;
        final loading = cardController.isLoading.value;
        final scheme = context.theme.colorScheme;

        final sheetHeight = MediaQuery.sizeOf(context).height * 0.78;
        return SafeArea(
          child: SizedBox(
            height: sheetHeight,
            child: Container(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (loading)
                    LinearProgressIndicator(
                      minHeight: 3,
                      backgroundColor: _accent.withValues(alpha: 0.15),
                      color: _accent,
                    )
                  else
                    SizedBox(height: 3.h),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0),
                    child: Row(
                      children: [
                        const Spacer(),
                        Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: scheme.onSurface.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: loading ? null : () => Get.back(),
                          icon: Icon(
                            Icons.close_rounded,
                            color: scheme.onSurface.withValues(
                              alpha: loading ? 0.2 : 0.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Link a product',
                          style: GoogleFonts.inter(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: _ink,
                            letterSpacing: -0.4,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Choose one offer type per category. You can request other eligible products separately.',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            height: 1.45,
                            color: scheme.onSurface.withValues(alpha: 0.55),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 28.h),
                      itemCount: products.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final productKey = product.key.trim().toLowerCase();
                        final alreadyRequested = cardController
                            .requestedProducts
                            .contains(productKey);
                        final isSelected = card?.selectedProduct == product.key;
                        final muted = scheme.onSurface.withValues(alpha: 0.45);

                        return Material(
                          color: alreadyRequested
                              ? scheme.surfaceContainerHighest.withValues(
                                  alpha: 0.65,
                                )
                              : isSelected
                              ? _accent.withValues(alpha: 0.08)
                              : scheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(18.r),
                          child: InkWell(
                            onTap: loading || alreadyRequested
                                ? null
                                : () =>
                                      cardController.selectProduct(product.key),
                            borderRadius: BorderRadius.circular(18.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.r),
                                border: Border.all(
                                  color: alreadyRequested
                                      ? scheme.outline.withValues(alpha: 0.25)
                                      : isSelected
                                      ? _accent
                                      : scheme.outline.withValues(alpha: 0.12),
                                  width: isSelected || alreadyRequested
                                      ? 1.5
                                      : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48.w,
                                    height: 48.w,
                                    decoration: BoxDecoration(
                                      color: alreadyRequested
                                          ? muted.withValues(alpha: 0.12)
                                          : _accent.withValues(alpha: 0.14),
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                    child: Icon(
                                      _iconForProduct(product.key),
                                      color: alreadyRequested
                                          ? muted
                                          : const Color(0xFF0F766E),
                                      size: 24.w,
                                    ),
                                  ),
                                  SizedBox(width: 14.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.label,
                                          style: GoogleFonts.inter(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: _ink,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          alreadyRequested
                                              ? 'Already requested'
                                              : product.description,
                                          style: GoogleFonts.inter(
                                            fontSize: 12.sp,
                                            height: 1.35,
                                            color: scheme.onSurface.withValues(
                                              alpha: 0.55,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (alreadyRequested)
                                    Icon(
                                      Icons.lock_outline_rounded,
                                      color: muted,
                                      size: 22.w,
                                    )
                                  else if (isSelected)
                                    Icon(
                                      Icons.check_circle_rounded,
                                      color: const Color(0xFF0F766E),
                                      size: 26.w,
                                    )
                                  else
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16.w,
                                      color: muted,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}

class _TrustCardPlaceholder extends StatelessWidget {
  const _TrustCardPlaceholder({
    required this.score,
    required this.onAddPressed,
  });

  final int score;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    final eligible = score > 45;
    final scheme = context.theme.colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: eligible
              ? [
                  ProfileDashboardView._accent.withValues(alpha: 0.35),
                  scheme.primary.withValues(alpha: 0.2),
                ]
              : [
                  scheme.outline.withValues(alpha: 0.2),
                  scheme.surfaceContainerHighest,
                ],
        ),
      ),
      padding: EdgeInsets.all(1.5.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 26.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          color: scheme.surface,
          boxShadow: [
            BoxShadow(
              color: ProfileDashboardView._ink.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: eligible
                    ? ProfileDashboardView._accent.withValues(alpha: 0.12)
                    : scheme.onSurface.withValues(alpha: 0.06),
                border: Border.all(
                  color: eligible
                      ? ProfileDashboardView._accent.withValues(alpha: 0.35)
                      : scheme.outline.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              child: Icon(
                eligible
                    ? Icons.credit_score_rounded
                    : Icons.credit_card_off_outlined,
                size: 34.w,
                color: eligible
                    ? const Color(0xFF0F766E)
                    : scheme.onSurface.withValues(alpha: 0.35),
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              eligible
                  ? 'You’re eligible for a Trust Card'
                  : 'Not eligible yet',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: ProfileDashboardView._ink,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              eligible
                  ? 'Issue your card, then link the financial products you want to explore.'
                  : 'Reach a combined trust score above 45 to unlock your Digital Trust Card.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                height: 1.45,
                color: scheme.onSurface.withValues(alpha: 0.55),
                fontWeight: FontWeight.w500,
              ),
            ),
            if (!eligible) ...[
              SizedBox(height: 14.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Target: 45+ trust score',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface.withValues(alpha: 0.65),
                  ),
                ),
              ),
            ],
            if (eligible) ...[
              SizedBox(height: 22.h),
              BaseButton(
                text: 'Get your Trust Card',
                icon: Icons.bolt_rounded,
                onPressed: onAddPressed,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
