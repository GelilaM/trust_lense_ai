import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BaseDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? hint;
  final String? errorText;

  const BaseDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.hint,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16.r),
            border: errorText != null
                ? Border.all(color: context.theme.colorScheme.error, width: 1.5)
                : null,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              items: items,
              onChanged: onChanged,
              hint: hint != null
                  ? Text(
                      hint!,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.theme.colorScheme.onSurface.withValues(
                          alpha: 0.4,
                        ),
                      ),
                    )
                  : null,
              dropdownColor: context.theme.colorScheme.surfaceContainerLowest,
              icon: Icon(
                Icons.expand_more,
                color: context.theme.colorScheme.outline,
              ),
              isExpanded: true,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.theme.colorScheme.onSurface,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 12.w),
            child: Text(
              errorText!,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.theme.colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
