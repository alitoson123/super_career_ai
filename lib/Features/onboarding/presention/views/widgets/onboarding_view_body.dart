import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Features/onboarding/presention/views/widgets/onboarding_item.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key, required this.controller});
  final PageController controller;
  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Fixed Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Super career',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                if (!isLastPage)
                  TextButton(
                    onPressed: () => context.go(AppRoutes.welcomeScreen),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                if (isLastPage) SizedBox(width: 50.w), // Keep balance if needed
              ],
            ),
          ),
          
          // Sliding Content
          Expanded(
            child: PageView(
              physics: const BouncingScrollPhysics(),
              controller: widget.controller,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 2;
                });
              },
              children: const [
                OnboardingItem(
                  image: 'assests/images/onboarding1.png',
                  title: 'Work smarter. Get hired faster.',
                  subtitle:
                      'One platform that connects freelancers and job seekers with real opportunities that match their skills.',
                ),
                OnboardingItem(
                  image: 'assests/images/onboarding2.png',
                  title: 'Let your work speak for you',
                  subtitle:
                      'Showcase your experience, skills, and portfolio so clients and companies can find you easily.',
                ),
                OnboardingItem(
                  image: 'assests/images/onboarding3.png',
                  title: 'Start your journey today',
                  subtitle:
                      'Create your profile, complete your details, and take the next step toward your career.',
                ),
              ],
            ),
          ),

          // Bottom Section (Dots & Button)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: Column(
              children: [
                // Dots
                SmoothPageIndicator(
                  controller: widget.controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey.shade300,
                    activeDotColor: AppColors.primaryBlue,
                    dotHeight: 8.h,
                    dotWidth: 8.w,
                    expansionFactor: 4,
                  ),
                ),
                SizedBox(height: 32.h),
                // Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLastPage) {
                        context.go(AppRoutes.welcomeScreen);
                      } else {
                        widget.controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      isLastPage ? 'Get Started' : 'Next',
                      style: TextStyle(
                        fontSize: 18.sp, 
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

