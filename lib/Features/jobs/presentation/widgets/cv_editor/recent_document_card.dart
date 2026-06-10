import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';
import 'package:super_career_ai/generated/l10n.dart';
import 'package:intl/intl.dart';

class RecentDocumentCard extends StatefulWidget {
  final BaseCvModel item;

  const RecentDocumentCard({super.key, required this.item});

  @override
  State<RecentDocumentCard> createState() => _RecentDocumentCardState();
}

class _RecentDocumentCardState extends State<RecentDocumentCard> {
  bool _isLoading = false;

  void _handleUseCv() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    // Simulate backend selection
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).cvSelected),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    // Generate a fallback name if fullName is empty
    final fullName = widget.item.personalDetails?.fullName;
    final namePart = (fullName != null && fullName.isNotEmpty)
        ? fullName.replaceAll(' ', '_')
        : 'My_Resume';
    final yearPart = widget.item.createdAt?.year ?? DateTime.now().year;
    final fileName = '${namePart}_$yearPart.pdf';

    // Format the date
    String modifiedDate = '';
    if (widget.item.createdAt != null) {
      modifiedDate =
          'Modified ${DateFormat('MMM d, yyyy').format(widget.item.createdAt!)}';
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // File Icon
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9), // Light grayish-blue
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.description_outlined,
              color: AppColors.primaryBlue,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),

          // File Name and Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                if (modifiedDate.isNotEmpty)
                  Text(
                    modifiedDate,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // Action Button
          ElevatedButton(
            onPressed: _handleUseCv,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: _isLoading
                ? SizedBox(
                    width: 16.sp,
                    height: 16.sp,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_outline, size: 16.sp),
                      SizedBox(width: 6.w),
                      Text(
                        s.useThisCv,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
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
