import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart' as app_colors;
import 'package:super_career_ai/Core/navigator/app_routes.dart';
import 'package:super_career_ai/Core/services/locator_service/service_locator.dart';
import 'package:super_career_ai/Features/jobs/presentation/widgets/cv_editor/cv_upload_box.dart';
import 'package:super_career_ai/Features/jobs/presentation/widgets/cv_editor/recent_document_list.dart';
import 'package:super_career_ai/Features/profile/presentation/cubit/profile_cubit.dart';
import 'package:super_career_ai/Features/profile/presentation/cubit/profile_state.dart';
import 'package:super_career_ai/generated/l10n.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _fullName = TextEditingController();
  final _title = TextEditingController();
  final _email = TextEditingController();

  bool _didHydrateControllers = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetch();
  }

  @override
  void dispose() {
    _fullName.dispose();
    _title.dispose();
    _email.dispose();
    super.dispose();
  }

  void _hydrate(ProfileLoaded state) {
    if (_didHydrateControllers) return;
    _didHydrateControllers = true;
    _fullName.text = state.profile.fullName ?? '';
    _title.text = state.profile.professionalTitle ?? '';
    _email.text = state.profile.email ?? '';
  }

  Future<void> _onSavePressed() async {
    final cubit = context.read<ProfileCubit>();
    await cubit.save(
      fullName: _fullName.text.trim(),
      professionalTitle: _title.text.trim(),
      email: _email.text.trim(),
    );
    if (!mounted) return;
    final s = cubit.state;
    if (s is ProfileLoaded) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Saved')));
    } else if (s is ProfileError) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(s.message)));
    }
  }

  Future<void> _onLogoutPressed() async {
    final prefs = getIt<SharedPreferences>();
    await prefs.remove('auth_token');
    await prefs.remove('auth_refresh_token');
    if (!mounted) return;
    context.go(AppRoutes.signInScreen);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      backgroundColor: app_colors.AppColors.background,
      appBar: AppBar(
        backgroundColor: app_colors.AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: app_colors.AppColors.textPrimary,
          ),
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: app_colors.AppColors.textSecondary,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    SizedBox(
                      width: 160.w,
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () => context.read<ProfileCubit>().fetch(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: app_colors.AppColors.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: const Text('Retry'),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    _LogoutButton(onPressed: _onLogoutPressed),
                  ],
                ),
              ),
            );
          }

          final loaded = state as ProfileLoaded;
          _hydrate(loaded);

          return RefreshIndicator(
            onRefresh: () async {
              _didHydrateControllers = false;
              await context.read<ProfileCubit>().fetch();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
              child: Column(
                children: [
                  SizedBox(height: 6.h),
                  _AvatarHeader(
                    name: loaded.profile.fullName ?? '',
                    title: loaded.profile.professionalTitle ?? '',
                  ),
                  SizedBox(height: 20.h),
                  _ProfilePillField(label: 'FULL NAME', controller: _fullName),
                  SizedBox(height: 14.h),
                  _ProfilePillField(label: 'TITLE', controller: _title),
                  SizedBox(height: 14.h),
                  _ProfilePillField(
                    label: 'EMAIL',
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 32.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      s.uploadYourCv,
                      style: TextStyle(
                        color: app_colors.AppColors.textPrimary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const CvUploadBox(),
                  SizedBox(height: 32.h),
                  const RecentDocumentList(),
                  SizedBox(height: 32.h),
                  _SaveButton(
                    isLoading: loaded.isSaving,
                    onPressed: loaded.isSaving ? null : _onSavePressed,
                  ),
                  SizedBox(height: 14.h),
                  _LogoutButton(onPressed: _onLogoutPressed),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AvatarHeader extends StatelessWidget {
  const _AvatarHeader({required this.name, required this.title});

  final String name;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 120.w,
          height: 120.w,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 58.r,
                  backgroundColor: const Color(0xFFCBD5E1),
                  child: CircleAvatar(
                    radius: 56.r,
                    backgroundColor: const Color(0xFF0F172A),
                    child: Icon(Icons.person, color: Colors.white, size: 48.sp),
                  ),
                ),
              ),
              Positioned(
                right: 6.w,
                bottom: 10.w,
                child: Material(
                  color: app_colors.AppColors.primaryBlue,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Icon(Icons.edit, color: Colors.white, size: 18.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            color: app_colors.AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: app_colors.AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _ProfilePillField extends StatelessWidget {
  const _ProfilePillField({
    required this.label,
    required this.controller,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 6.w),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: app_colors.AppColors.textSecondary,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 54.h,
          decoration: BoxDecoration(
            color: const Color(0xFFE9EEF5),
            borderRadius: BorderRadius.circular(16.r),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.onPressed, required this.isLoading});

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: app_colors.AppColors.primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: 18.w,
                height: 18.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                'Save Changes',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.redAccent, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          'Log Out',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
