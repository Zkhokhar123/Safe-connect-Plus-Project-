import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });
}

class NotificationProvider with ChangeNotifier {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'Welcome!',
      message: 'Thanks for joining our shop.',
      timestamp: DateTime.now(),
    ),
    NotificationModel(
      id: '2',
      title: 'New Arrival',
      message: 'Check out the new EMF Protection Bracelets.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];

  List<NotificationModel> get notifications => _notifications;

  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }
}
