import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MenuItemData {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  MenuItemData({
    required this.icon,
    required this.title,
    this.onTap,
  });
}

class MenuSection extends StatelessWidget {
  final List<MenuItemData> items;

  const MenuSection({super.key, required this.items});

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
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final isLast = entry.key == items.length - 1;
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 8.h,
                ),
                leading: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    entry.value.icon,
                    color: context.theme.colorScheme.primary,
                    size: 20.sp,
                  ),
                ),
                title: Text(
                  entry.value.title,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: context.theme.colorScheme.onSurface.withValues(
                    alpha: 0.3,
                  ),
                ),
                onTap: entry.value.onTap ?? () {},
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 68.w,
                  endIndent: 20.w,
                  color: context.theme.colorScheme.outlineVariant.withValues(
                    alpha: 0.3,
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
