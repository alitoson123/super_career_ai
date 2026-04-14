import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_career_ai/Core/theme/app_colors.dart';

class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({
    super.key,
    this.onGoogle,
    this.onLinkedIn,
  });

  final VoidCallback? onGoogle;
  final VoidCallback? onLinkedIn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CircleSocialButton(
          asset: 'assests/images/google_logo.svg',
          onTap: onGoogle,
        ),
        SizedBox(width: 28.w),
        _CircleSocialButton(
          asset: 'assests/images/linkedin_logo.svg',
          onTap: onLinkedIn,
        ),
      ],
    );
  }
}

class _CircleSocialButton extends StatelessWidget {
  const _CircleSocialButton({
    required this.asset,
    this.onTap,
  });

  final String asset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.socialBorder),
            color: AppColors.white,
          ),
          child: Center(
            child: SvgPicture.asset(
              asset,
              width: 26.w,
              height: 26.w,
            ),
          ),
        ),
      ),
    );
  }
}
