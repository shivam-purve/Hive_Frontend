import 'api_client.dart';

class NotificationService {
  final _api = ApiClient();

  /// Fetch all notifications for current user
  Future<List<dynamic>> fetchNotifications() async {
    final res = await _api.get('/notifications', auth: true);
    return res as List<dynamic>;
  }

  /// Delete a specific notification
  Future<void> deleteNotification(String notificationId) async {
    await _api.delete('/notifications/$notificationId', auth: true);
  }
}
