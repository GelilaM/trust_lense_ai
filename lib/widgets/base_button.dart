import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum ButtonType { primary, secondary, outline, ghost }

class BaseButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final bool trailingIcon;

  const BaseButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.trailingIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 20.sp,
            height: 20.sp,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(_getTextColor(context)),
            ),
          )
        else ...[
          if (icon != null && !trailingIcon) ...[
            Icon(icon, size: 20.sp, color: _getTextColor(context)),
            SizedBox(width: 8.w),
          ],
          Text(
            text,
            style: context.textTheme.titleMedium?.copyWith(
              color: _getTextColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          if (icon != null && trailingIcon) ...[
            SizedBox(width: 8.w),
            Icon(icon, size: 20.sp, color: _getTextColor(context)),
          ],
        ],
      ],
    );

    Widget button;

    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: _getBackgroundColor(context),
            foregroundColor: _getTextColor(context),
            disabledBackgroundColor: _getBackgroundColor(
              context,
            ).withValues(alpha: 0.5),
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: buttonContent,
        );
        break;
      case ButtonType.outline:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: _getTextColor(context),
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            side: BorderSide(color: context.theme.colorScheme.outlineVariant),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: buttonContent,
        );
        break;
      case ButtonType.ghost:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: _getTextColor(context),
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: buttonContent,
        );
        break;
    }

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return context.theme.colorScheme.primary;
      case ButtonType.secondary:
        return context.theme.colorScheme.secondary;
      default:
        return Colors.transparent;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return context.theme.colorScheme.onPrimary;
      case ButtonType.secondary:
        return context.theme.colorScheme.onSecondary;
      case ButtonType.outline:
      case ButtonType.ghost:
        return context.theme.colorScheme.primary;
    }
  }
}
