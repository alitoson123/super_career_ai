import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Core/utils/cv_pdf_generator.dart';
import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';

class CvHistoryCard extends StatefulWidget {
  const CvHistoryCard({super.key, required this.item});

  final BaseCvModel item;

  @override
  State<CvHistoryCard> createState() => _CvHistoryCardState();
}

class _CvHistoryCardState extends State<CvHistoryCard> {
  bool _isDownloading = false;

  Future<void> _downloadAndOpen() async {
    if (_isDownloading) return;

    setState(() => _isDownloading = true);

    try {
      final filePath = await CvPdfGenerator.generate(widget.item);
      final result = await OpenFilex.open(filePath);

      if (result.type != ResultType.done && mounted) {
        _showError('Could not open the file: ${result.message}');
      }
    } catch (e) {
      if (mounted) {
        _showError('Failed to generate PDF. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          // title
          Row(
            children: [
              Expanded(
                child: Text(
                  item.personalDetails?.fullName ?? "Untitled CV",
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
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
                    '${item.createdAt?.toString().substring(0, 10)}',
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
                width: 40.w,
                height: 40.w,
                child: _isDownloading
                    ? Padding(
                        padding: EdgeInsets.all(10.r),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : IconButton(
                        onPressed: _downloadAndOpen,
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
}
