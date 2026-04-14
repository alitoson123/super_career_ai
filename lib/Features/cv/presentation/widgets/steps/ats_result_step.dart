import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/cv/domain/entities/ats_analysis_entity.dart';
import 'package:super_career_ai/Features/cv/presentation/cubit/cv_wizard_cubit.dart';
import 'package:super_career_ai/Features/cv/presentation/cubit/cv_wizard_state.dart';
import 'package:super_career_ai/Features/cv/presentation/widgets/cv_buttons.dart';
import 'package:super_career_ai/generated/l10n.dart';

class AtsResultStep extends StatelessWidget {
  const AtsResultStep({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocBuilder<CvWizardCubit, CvWizardState>(
      builder: (context, state) {
        final analysis = state.atsAnalysis;
        if (analysis == null) return const SizedBox.shrink();

        final cubit = context.read<CvWizardCubit>();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header card
              _AtsHeaderCard(analysis: analysis, s: s),
              SizedBox(height: 20.h),

              // Keywords found
              _SectionTitle(title: s.keywordsFound, trailing: s.matchesOfTotal(
                analysis.keywordsFound,
                analysis.totalKeywords,
              )),
              SizedBox(height: 12.h),
              _KeywordsGrid(analysis: analysis),
              SizedBox(height: 20.h),

              // Improvement tips
              _SectionTitle(title: s.improvementTips),
              SizedBox(height: 12.h),
              ...analysis.improvementTips.map(
                (tip) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _TipCard(tip: tip),
                ),
              ),

              SizedBox(height: 20.h),
              CvPrimaryButton(
                label: s.exportCvPdf,
                icon: Icons.download,
                onPressed: () {
                  // Export action — would call a PDF use-case in production.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(s.exportCvPdf),
                      backgroundColor: AppColors.primaryBlue,
                    ),
                  );
                },
              ),
              SizedBox(height: 12.h),
              CvOutlinedButton(
                label: s.back,
                onPressed: () => cubit.goToStep(CvWizardStep.skills),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }
}

class _AtsHeaderCard extends StatelessWidget {
  const _AtsHeaderCard({required this.analysis, required this.s});

  final AtsAnalysisEntity analysis;
  final S s;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: AppColors.primaryBlueLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: AppColors.primaryBlue,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            s.yourCvIsReady,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            s.perfectlyTailored,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 20.h),
          // Circular score indicator
          _ScoreRing(score: analysis.matchScore),
          SizedBox(height: 8.h),
          Text(
            s.atsMatch,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            s.excellentAlignment,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreRing extends StatelessWidget {
  const _ScoreRing({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.r,
      height: 100.r,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: score / 100,
              strokeWidth: 8,
              backgroundColor: AppColors.border,
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$score%',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        if (trailing != null)
          Text(
            trailing!,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}

const List<String> _keywords = [
  'User Research',
  'Figma',
  'Design Systems',
  'A/B Testing',
  'Product Strategy',
  'Python',
];

class _KeywordsGrid extends StatelessWidget {
  const _KeywordsGrid({required this.analysis});

  final AtsAnalysisEntity analysis;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _keywords
          .map((kw) => _KeywordChip(keyword: kw))
          .toList(),
    );
  }
}

class _KeywordChip extends StatelessWidget {
  const _KeywordChip({required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, size: 12.sp, color: AppColors.successGreen),
          SizedBox(width: 4.w),
          Text(
            keyword,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({required this.tip});

  final ImprovementTipEntity tip;

  @override
  Widget build(BuildContext context) {
    final color = tip.isWarning ? const Color(0xFFF59E0B) : AppColors.primaryBlue;
    final bgColor = tip.isWarning
        ? const Color(0xFFFFFBEB)
        : AppColors.primaryBlueLight;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              tip.isWarning
                  ? Icons.lightbulb_outline
                  : Icons.library_books_outlined,
              size: 16.sp,
              color: color,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  tip.description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                    height: 1.4,
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
