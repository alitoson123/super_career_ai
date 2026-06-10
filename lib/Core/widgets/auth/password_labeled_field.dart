import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_career_ai/Core/theme/app_colors.dart';

class PasswordLabeledField extends StatefulWidget {
  const PasswordLabeledField({
    super.key,
    required this.label,
    required this.controller,
    this.hint = 'Enter your password',
    this.placeholderColor,
    this.fillColor,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final Color? placeholderColor;
  final Color? fillColor;

  @override
  State<PasswordLabeledField> createState() => _PasswordLabeledFieldState();
}

class _PasswordLabeledFieldState extends State<PasswordLabeledField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.headingNavy,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: widget.controller,
          obscureText: _obscure,
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor ?? AppColors.inputFill,
            hintText: widget.hint,
            hintStyle: TextStyle(
              fontSize: 15.sp,
              color: widget.placeholderColor ?? AppColors.bodyMutedBlue,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscure = !_obscure),
              icon: Icon(
                _obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.bodyMutedBlue,
                size: 22.sp,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.primaryBlue,
                width: 1.2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ],
    );
  }
}
