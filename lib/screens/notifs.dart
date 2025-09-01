import 'package:flutter/material.dart';

import '../colors_theme/color.dart';
import '../widgets/notification_widget.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<AppNotification> _notifications = [
    AppNotification(
      title: "New Message",
      message: "You got a new message from John",
      time: "10:30 AM",
    ),
    AppNotification(
      title: "Reminder",
      message: "Don’t forget your meeting at 3 PM",
      time: "9:00 AM",
    ),
    AppNotification(
      title: "Update",
      message: "Your app has been updated successfully",
      time: "Yesterday",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Recent Notifications"),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Dismissible(
            key: Key(notification.title + index.toString()), // unique key
            direction: DismissDirection.startToEnd, // swipe left
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                _notifications.removeAt(index);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${notification.title} removed"),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                tileColor: AppColors.primary_light,
                title: Text(
                  notification.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(notification.message),
                trailing: Text(
                  notification.time,
                  style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
