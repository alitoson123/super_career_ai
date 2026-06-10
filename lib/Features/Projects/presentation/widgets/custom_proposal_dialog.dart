import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/Projects/Domain/entities/project_entity.dart';
import 'package:super_career_ai/Features/Projects/presentation/view_model/custom_proposal_cubit/custom_proposal_cubit.dart';
import 'package:super_career_ai/Features/Projects/presentation/view_model/custom_proposal_cubit/custom_proposal_states.dart';
import 'package:super_career_ai/generated/l10n.dart';

class CustomProposalDialog extends StatefulWidget {
  final ProjectEntity project;

  const CustomProposalDialog({super.key, required this.project});

  @override
  State<CustomProposalDialog> createState() => _CustomProposalDialogState();
}

class _CustomProposalDialogState extends State<CustomProposalDialog> {
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
    _generateProposal();
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  // get proposal
  Future<void> _generateProposal() async {
    await context.read<CustomProposalCubit>().fetchCustomProposal(
      myProjectId: widget.project.id,
    );
  }

  int get _wordCount {
    final text = _textController.text.trim();
    if (text.isEmpty) return 0;
    return text.split(RegExp(r'\s+')).length;
  }

  // copy proposal
  void _copyToClipboard() {
    if (_textController.text.isEmpty) return;
    Clipboard.setData(ClipboardData(text: _textController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).proposalCopied),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        backgroundColor: AppColors.successGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    // final theme = Theme.of(context);

    return BlocListener<CustomProposalCubit, CustomProposalStates>(
      listener: (context, state) {
        if (state is CustomProposalLoading) {
          _isLoading = true;
        } else if (state is CustomProposalSuccess) {
          _isLoading = false;
          _textController.text = state.proposal;
        } else if (state is CustomProposalFailure) {
          _isLoading = false;
          _errorMessage = state.errorMessage;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 30,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle indicator
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                  width: 48.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),

              // Dialog Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  children: [
                    // back button
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    // title
                    Expanded(
                      child: Center(
                        child: Text(
                          s.proposalTitle,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 48.w),
                  ],
                ),
              ),
              const Divider(color: AppColors.border, height: 1),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.border),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // title
                            Text(
                              widget.project.title,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            //required skills
                            if (widget.project.requiredSkills.isNotEmpty) ...[
                              SizedBox(height: 12.h),
                              Wrap(
                                spacing: 8.w,
                                runSpacing: 8.h,
                                children: widget.project.requiredSkills.map((
                                  skill,
                                ) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3F4F6),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Text(
                                      skill.toString(),
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                            SizedBox(height: 8.h),
                            // budget
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (widget.project.budget != null)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.successGreen.withOpacity(
                                        0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      widget.project.budget!,
                                      style: TextStyle(
                                        color: AppColors.successGreen,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Editor Section Header (Your Proposal & word count)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // your proposal
                          Text(
                            s.yourProposal,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                              letterSpacing: 0.5,
                            ),
                          ),
                          // word count
                          Text(
                            s.wordCount(_wordCount),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),

                      // The Editor Container
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            // loading
                            if (_isLoading)
                              Container(
                                height: 240.h,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF6366F1),
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      s.generatingProposal,
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            // error
                            else if (_errorMessage != null)
                              Container(
                                height: 240.h,
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: Colors.redAccent,
                                      size: 40,
                                    ),
                                    SizedBox(height: 12.h),
                                    Text(
                                      _errorMessage ??
                                          s.failedToGenerateProposal,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF6366F1,
                                        ),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                      ),
                                      onPressed: _generateProposal,
                                      icon: const Icon(Icons.refresh, size: 16),
                                      label: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              )
                            // success
                            else
                              TextField(
                                controller: _textController,
                                maxLines: null,
                                minLines: 10,
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  height: 1.5,
                                  color: AppColors.textPrimary,
                                ),
                                decoration: InputDecoration(
                                  hintText:
                                      'Write or generate your proposal...',
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.unselectedIcon,
                                  ),
                                  contentPadding: EdgeInsets.all(16.r),
                                  border: InputBorder.none,
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Action Buttons Row
                      Row(
                        children: [
                          // Copy Proposal Button
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed:
                                  _isLoading || _textController.text.isEmpty
                                  ? null
                                  : _copyToClipboard,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6366F1),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              icon: const Icon(Icons.send_rounded, size: 16),
                              label: Text(
                                s.copyProposal,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
