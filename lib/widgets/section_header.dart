import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String actionText;
  final bool isIcon;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    required this.actionText,
    this.isIcon = false,
    this.actionIcon,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: subtitle != null
          ? CrossAxisAlignment.baseline
          : CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        if (subtitle != null)
          RichText(
            text: TextSpan(
              style: context.textTheme.titleLarge?.copyWith(
                color: context.theme.colorScheme.primary,
              ),
              children: [
                TextSpan(
                  text: '$title\n',
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
                TextSpan(
                  text: subtitle!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        else
          Text(
            title,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.colorScheme.primary,
            ),
          ),
        if (actionIcon != null)
          GestureDetector(
            onTap: onActionTap,
            child: Icon(
              actionIcon,
              color: context.theme.colorScheme.secondary,
              size: 22.sp,
            ),
          )
        else if (isIcon)
          Icon(
            Icons.history,
            color: context.theme.colorScheme.onSurface.withValues(alpha: 0.8),
            size: 20.sp,
          )
        else
          Text(
            actionText,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.theme.colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
