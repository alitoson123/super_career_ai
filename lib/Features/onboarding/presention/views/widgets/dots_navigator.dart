import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DotsNavigator extends StatelessWidget {
  const DotsNavigator({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 70.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.blue,
              dotHeight: 8.h,
              dotWidth: 8.w,
            ),
          ),
        ],
      ),
    );
  }
}
