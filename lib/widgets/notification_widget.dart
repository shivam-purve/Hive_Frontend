import 'package:flutter/material.dart';
import 'package:social_garbage/colors_theme/color.dart';

class AppNotification {
  final String title;
  final String message;
  final String time;

  AppNotification({
    required this.title,
    required this.message,
    required this.time,
  });
}


class NotificationItem extends StatelessWidget {
  final AppNotification notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: AppColors.primary_light,
      color: AppColors.primary_light,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        tileColor: Colors.transparent,
        title: Text(
          notification.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(notification.message),
        trailing: Text(
          notification.time,
          style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
        ),
      ),
    );
  }
}
