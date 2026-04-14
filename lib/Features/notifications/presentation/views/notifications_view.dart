import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:super_career_ai/Core/constant/app_colors.dart';
import 'package:super_career_ai/Features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:super_career_ai/Features/notifications/presentation/cubit/notifications_state.dart';
import 'package:super_career_ai/Features/notifications/presentation/widgets/notification_item_card.dart';
import 'package:super_career_ai/generated/l10n.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit()..loadNotifications(),
      child: const _NotificationsViewBody(),
    );
  }
}

class _NotificationsViewBody extends StatelessWidget {
  const _NotificationsViewBody();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          s.notifications,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => context.read<NotificationsCubit>().clearAll(),
            child: Text(
              s.clearAll,
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(color: AppColors.border, height: 1.h),
        ),
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.notifications.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlueLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.notifications_none,
                        color: AppColors.primaryBlue,
                        size: 48.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      s.noNotifications,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      s.noNotificationsDesc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final todayItems = state.notifications.where((n) => n.isToday).toList();
          final yesterdayItems =
              state.notifications.where((n) => !n.isToday).toList();

          return ListView(
            children: [
              if (todayItems.isNotEmpty) ...[
                _SectionHeader(title: s.today),
                ...todayItems.map((n) => NotificationItemCard(
                      notification: n,
                      onTap: () =>
                          context.read<NotificationsCubit>().markRead(n.id),
                    )),
                SizedBox(height: 24.h),
              ],
              if (yesterdayItems.isNotEmpty) ...[
                _SectionHeader(title: s.yesterday),
                ...yesterdayItems.map((n) => NotificationItemCard(
                      notification: n,
                      onTap: () =>
                          context.read<NotificationsCubit>().markRead(n.id),
                    )),
              ],
              SizedBox(height: 24.h),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
          fontSize: 12.sp,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}
