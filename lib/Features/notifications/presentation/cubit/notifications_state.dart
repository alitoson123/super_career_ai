import 'package:super_career_ai/Features/notifications/domain/entities/notification_entity.dart';

class NotificationsState {
  const NotificationsState({
    required this.notifications,
    this.isLoading = false,
  });

  final List<NotificationEntity> notifications;
  final bool isLoading;

  static NotificationsState initial() =>
      const NotificationsState(notifications: []);

  NotificationsState copyWith({
    List<NotificationEntity>? notifications,
    bool? isLoading,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
