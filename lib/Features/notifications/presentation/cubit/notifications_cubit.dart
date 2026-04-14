import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Features/notifications/domain/entities/notification_entity.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsState.initial());

  void loadNotifications() {
    // In a real app, this would come from a repository.
    // Simulating initial data as shown in the mockup image.
    final List<NotificationEntity> notifications = [
      const NotificationEntity(
        id: '1',
        title: 'New 98% match: Senior React Developer on Upwork',
        timeLabel: '10 minutes ago',
        type: NotificationType.match,
        isRead: false,
        isToday: true,
      ),
      const NotificationEntity(
        id: '2',
        title: 'Your proposal for E-commerce App was viewed',
        timeLabel: '2 hours ago',
        type: NotificationType.viewed,
        isRead: false,
        isToday: true,
      ),
      const NotificationEntity(
        id: '3',
        title: 'New 98% match: Senior React Developer on Upwork',
        timeLabel: '10 minutes ago',
        type: NotificationType.match,
        isRead: false,
        isToday: true,
      ),
      const NotificationEntity(
        id: '4',
        title: 'Your CVs ATS score improved to 85%',
        timeLabel: 'Yesterday, 4:20 PM',
        type: NotificationType.ats,
        isRead: true,
        isToday: false,
      ),
      const NotificationEntity(
        id: '5',
        title: 'New job posting in "Fullstack Developer"',
        timeLabel: 'Yesterday, 11:05 AM',
        type: NotificationType.posting,
        isRead: true,
        isToday: false,
      ),
      const NotificationEntity(
        id: '6',
        title: 'Your CVs ATS score improved to 85%',
        timeLabel: 'Yesterday, 4:20 PM',
        type: NotificationType.ats,
        isRead: true,
        isToday: false,
      ),
    ];

    emit(state.copyWith(notifications: notifications));
  }

  void clearAll() {
    emit(state.copyWith(notifications: []));
  }

  void markAllRead() {
    final updated = state.notifications
        .map((n) => n.copyWith(isRead: true))
        .toList();
    emit(state.copyWith(notifications: updated));
  }

  void markRead(String id) {
    final updated = state.notifications.map((n) {
      if (n.id == id) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();
    emit(state.copyWith(notifications: updated));
  }
}
