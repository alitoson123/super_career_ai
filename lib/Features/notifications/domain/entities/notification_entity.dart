import 'package:flutter/material.dart';

enum NotificationType { match, viewed, ats, posting }

class NotificationEntity {
  const NotificationEntity({
    required this.id,
    required this.title,
    required this.timeLabel,
    required this.type,
    this.isRead = false,
    this.isToday = true,
  });

  final String id;
  final String title;
  final String timeLabel;
  final NotificationType type;
  final bool isRead;
  final bool isToday;

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? timeLabel,
    NotificationType? type,
    bool? isRead,
    bool? isToday,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      timeLabel: timeLabel ?? this.timeLabel,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      isToday: isToday ?? this.isToday,
    );
  }

  IconData get icon => switch (type) {
    NotificationType.match => Icons.local_fire_department_outlined,
    NotificationType.viewed => Icons.bolt,
    NotificationType.ats => Icons.auto_awesome,
    NotificationType.posting => Icons.work_outline,
  };
}
