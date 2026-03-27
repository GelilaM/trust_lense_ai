import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DocumentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final IconData icon;
  final Widget child;
  final VoidCallback? onTap;

  const DocumentCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.icon,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x050A2540),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: context.theme.colorScheme.outlineVariant.withValues(
            alpha: 0.2,
          ),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.r),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.surfaceContainerLow,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: context.theme.colorScheme.primary,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.theme.colorScheme.onSurface.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.secondary.withValues(
                        alpha: 0.15,
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      status,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.theme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: context.theme.colorScheme.outlineVariant.withValues(
                alpha: 0.2,
              ),
            ),
            Padding(padding: EdgeInsets.all(20.w), child: child),
          ],
        ),
      ),
    );
  }
}
