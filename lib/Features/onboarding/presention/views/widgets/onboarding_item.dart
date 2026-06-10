import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    super.key,
    required this.controller,
    required this.image,
    required this.title,
    required this.subtitle,
    this.isLastPage = false,
  });
  final PageController controller;
  final String image;
  final String title;
  final String subtitle;
  final bool isLastPage;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 30.h),

        // Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Super career',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Visibility(
              visible: !isLastPage,
              child: Container(
                width: 70.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.black),
                ),
                child: TextButton(
                  onPressed: () {
                    context.go(AppRoutes.welcomeScreen);
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  ),
                ),
              ),
            ),
          ],
        ),

        Spacer(flex: 2),
        // Image
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(
            image,
            width: double.infinity,
            height: 220.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 70.h),

        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.sp,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),

        // Subtitle
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade600,
            height: 1.5,
          ),
        ),
        SizedBox(height: 80.h),

        // Next Button
        SizedBox(
          width: double.infinity,
          height: 52.h,
          child: ElevatedButton(
            onPressed: () {
              if (isLastPage) {
                context.go(AppRoutes.welcomeScreen);
                return;
              }
              controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
              if (isLastPage) {
                GoRouter.of(context).go(AppRoutes.rootScreen);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2563EB),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              elevation: 0,
            ),
            child: Text(
              isLastPage ? 'Get Started' : 'Next',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }
}
