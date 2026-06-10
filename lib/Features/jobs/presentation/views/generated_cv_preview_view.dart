import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Core/utils/cv_pdf_generator.dart';
import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';

class GeneratedCvPreviewView extends StatelessWidget {
  final BaseCvModel cvModel;

  const GeneratedCvPreviewView({super.key, required this.cvModel});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'CV Preview',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(
            color: AppColors.border.withOpacity(0.5),
            height: 1.h,
          ),
        ),
      ),
      body: PdfPreview(
        build: (format) => CvPdfGenerator.buildPdf(cvModel),
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        allowPrinting: true,
        allowSharing: true,
        pdfFileName: '${cvModel.personalDetails?.fullName?.replaceAll(' ', '_') ?? 'Custom_CV'}.pdf',
        loadingWidget: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryBlue,
          ),
        ),
        scrollViewDecoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
        ),
      ),
    );
  }
}
