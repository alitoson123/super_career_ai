import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/generated/l10n.dart';

class CVHistoryBody extends StatelessWidget {
  const CVHistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    // Mock data for demonstration
    final List<Map<String, dynamic>> historyItems = [
      {'title': 'Senior Product Designer', 'score': 92, 'date': 'Oct 12, 2023'},
      {'title': 'Lead Frontend Engineer', 'score': 85, 'date': 'Sep 28, 2023'},
      {'title': 'Creative Director', 'score': 74, 'date': 'Aug 15, 2023'},
      {'title': 'Senior Product Designer', 'score': 70, 'date': 'Oct 12, 2023'},
    ];

    // no history
    if (historyItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history_rounded,
              size: 64.sp,
              color: AppColors.unselectedIcon.withOpacity(0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              s.noHistory,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16.sp),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      physics: const BouncingScrollPhysics(),
      itemCount: historyItems.length,
      itemBuilder: (context, index) {
        final item = historyItems[index];
        return _buildHistoryCard(context, item);
      },
    );
  }

  Widget _buildHistoryCard(BuildContext context, Map<String, dynamic> item) {
    final int score = item['score'];
    final Color scoreColor = score >= 80
        ? AppColors.primaryBlue
        : const Color(0xFFD97706); // Blue or Orange

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          // title and score
          Row(
            children: [
              Expanded(
                child: Text(
                  item['title'],
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // score
              _buildCircularScore(score, scoreColor),
            ],
          ),
          SizedBox(height: 20.h),
          const Divider(height: 1),
          SizedBox(height: 16.h),
          // date and download button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // date
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    item['date'],
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              // download button
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.download_rounded,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  constraints: BoxConstraints.tightFor(
                    width: 40.w,
                    height: 40.w,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularScore(int score, Color color) {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.2), width: 3.w),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 48.w,
            height: 48.w,
            child: CircularProgressIndicator(
              value: score / 100,
              strokeWidth: 3.w,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          Text(
            '$score%',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
