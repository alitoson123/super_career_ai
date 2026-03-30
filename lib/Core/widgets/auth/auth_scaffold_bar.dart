import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/theme/app_colors.dart';

class AuthScaffoldBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthScaffoldBar({
    super.key,
    required this.title,
    this.onBack,
  });

  final String title;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack ?? () => context.pop(),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20.sp,
                color: AppColors.headingNavy,
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.headingNavy,
                ),
              ),
            ),
            SizedBox(width: 48.w),
          ],
        ),
      ),
    );
  }
}
