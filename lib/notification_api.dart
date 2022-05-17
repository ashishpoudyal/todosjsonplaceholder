import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init({bool scheduled = false}) async {
    var initAndroidSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    final settings =
        InitializationSettings(android: initAndroidSettings, iOS: ios);
    await _notifications.initialize(settings);
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? paylod,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
      );

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          "channelId",
          "channelName",
          importance: Importance.max,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('notification'),
        ),
        iOS: IOSNotificationDetails());
  }
}
