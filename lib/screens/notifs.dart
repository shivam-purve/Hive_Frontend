import 'package:flutter/material.dart';
import '../colors_theme/color.dart';
import '../widgets/notification_widget.dart';
import '../services/notification_service.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with AutomaticKeepAliveClientMixin<NotificationsPage> {
  @override
  bool get wantKeepAlive => true;

  final NotificationService _notificationService = NotificationService();
  List<AppNotification> _notifications = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      final res = await _notificationService.fetchNotifications();
      final notifications = res
          .map<AppNotification>((n) => AppNotification.fromJson(n))
          .toList();

      if (!mounted) return;
      setState(() {
        _notifications = notifications;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load notifications: $e")),
      );
    }
  }

  Future<void> _deleteNotification(int index) async {
    final notification = _notifications[index];

    setState(() {
      _notifications.removeAt(index);
    });

    try {
      await _notificationService.deleteNotification(notification.id);
    } catch (e) {
      // rollback on error
      setState(() {
        _notifications.insert(index, notification);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete notification: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Recent Notifications"),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadNotifications,
        child: _notifications.isEmpty
            ? const Center(child: Text("No notifications found"))
            : ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notification = _notifications[index];
            return Dismissible(
              key: Key(notification.id),
              direction: DismissDirection.startToEnd,
              background: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => _deleteNotification(index),
              child: NotificationItem(notification: notification),
            );
          },
        ),
      ),
    );
  }
}
