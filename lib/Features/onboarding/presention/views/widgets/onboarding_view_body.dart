import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Features/onboarding/presention/views/widgets/onboarding_item.dart';

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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: PageView(
          physics: const BouncingScrollPhysics(),
          controller: widget.controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            // screen 1
            OnboardingItem(
              controller: widget.controller,
              image: 'assests/images/onboarding1.png',
              title: 'Work smarter. Get hired faster.',
              subtitle:
                  'One platform that connects freelancers and job seekers with real opportunities that match their skills.',
            ),
            // screen 2
            OnboardingItem(
              controller: widget.controller,
              image: 'assests/images/onboarding2.png',
              title: 'Let your work speak for you',
              subtitle:
                  'Showcase your experience, skills, and portfolio so clients and companies can find you easily.',
            ),
            // screen 3
            OnboardingItem(
              controller: widget.controller,
              image: 'assests/images/onboarding3.png',
              title: 'Start your journey today',
              subtitle:
                  'Create your profile, complete your details, and take the next step toward your career ',
              isLastPage: true,
            ),
          ],
        ),
      ),
    );
  }
}
