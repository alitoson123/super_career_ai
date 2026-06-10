import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Core/services/gemini_service/cv_text_extractor_service.dart';
import 'package:super_career_ai/Core/services/gemini_service/gemini_cv_parser_service.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/base_cv_cubit.dart/get_base_cv_cubit.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/base_cv_cubit.dart/get_base_cv_states.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/base_cv_cubit.dart/uplaod_base_cv_cubit.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/base_cv_cubit.dart/upload_base_cv_states.dart';
import 'package:super_career_ai/generated/l10n.dart';

class CvUploadBox extends StatefulWidget {
  const CvUploadBox({super.key});

  @override
  State<CvUploadBox> createState() => _CvUploadBoxState();
}

class _CvUploadBoxState extends State<CvUploadBox> {
  bool _isUploading = false;
  String _statusMessage = '';

  Future<void> _handleUpload() async {
    if (_isUploading) return;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) return;
    final filePath = result.files.first.path;
    if (filePath == null) return;

    setState(() {
      _isUploading = true;
      _statusMessage = 'Extracting text from PDF…';
    });

    try {
      // 2. Extract raw text
      final rawText = await CvTextExtractorService.extractFromPdf(filePath);

      if (!mounted) return;
      setState(() => _statusMessage = 'Parsing CV with AI…');

      // 3. Parse via Gemini
      final parsedData = await GeminiCvParserService.parseCvText(rawText);

      if (!mounted) return;
      setState(() => _statusMessage = 'Uploading CV…');

      // 4. Call Cubits
      final baseCvState = context.read<BaseCvCubit>().state;
      final hasBaseCV =
          baseCvState is BaseCvSuccess && baseCvState.baseCv != null;
      log(parsedData.toString());
      if (hasBaseCV) {
        context.read<UploadBaseCvCubit>().changeBaseCV(data: parsedData);
      } else {
        context.read<UploadBaseCvCubit>().uploadBaseCV(data: parsedData);
      }
    } catch (e) {
      // ✨ طباعة الخطأ الفعلي في الـ Console عشان تقفش المشكلة فوراً لو تكررت
      debugPrint('🚨 Upload Process Failed: $e');

      if (!mounted) return;

      // يمكنك تخصيص الرسالة للمستخدم بناءً على نوع الخطأ لو أحببت
      String userMessage = 'Failed to process CV. Please try again.';
      if (e.toString().contains('Could not extract text')) {
        userMessage =
            'This PDF seems to be an image. Please use a text-based PDF.';
      }

      _showSnackBar(message: userMessage, isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
          _statusMessage = '';
        });
      }
    }
  }

  void _showSnackBar({required String message, bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocListener<UploadBaseCvCubit, UploadBaseCvStates>(
      listener: (context, state) {
        if (state is UploadBaseCvSuccess) {
          _showSnackBar(message: s.cvUploaded);
          // Refresh the base CV so the "Recent Document" list updates
          context.read<BaseCvCubit>().fetchBaseCV();
        } else if (state is UploadBaseCvFailure) {
          _showSnackBar(message: state.errorMessage, isError: true);
        }
      },
      child: GestureDetector(
        onTap: _handleUpload,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: _isUploading
                  ? AppColors.primaryBlue
                  : AppColors.primaryBlue.withValues(alpha: 0.4),
              width: _isUploading ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon / loading indicator
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: _isUploading
                    ? Center(
                        child: SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: CircularProgressIndicator(
                            color: AppColors.primaryBlue,
                            strokeWidth: 2.5,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.cloud_upload_outlined,
                        color: AppColors.primaryBlue,
                        size: 32.sp,
                      ),
              ),
              SizedBox(height: 16.h),

              // Primary label
              Text(
                _isUploading && _statusMessage.isNotEmpty
                    ? _statusMessage
                    : s.dragAndDropOrClick,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              // Secondary label
              if (!_isUploading)
                Text(
                  s.fileLimitText,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
