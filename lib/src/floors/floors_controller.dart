import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scutum_test_assignment/src/houses/house.dart';

class FloorsController with ChangeNotifier {
  FloorsController(this.house);

  final House house;
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  int _currentFloor = 0;
  int get currentFloor => _currentFloor;

  bool _isMoving = false;
  bool get isMoving => _isMoving;

  Future<void> moveLift(int targetFloor) async {
    if (targetFloor >= 0 &&
        targetFloor <= house.floors &&
        targetFloor != currentFloor) {
      _isMoving = true;
      var direction = currentFloor < targetFloor ? 1 : -1;

      while (currentFloor != targetFloor) {
        notifyListeners();
        _currentFloor += direction;

        await Future.delayed(const Duration(seconds: 1));
      }

      _isMoving = false;
      notifyListeners();
      await _showNotification();
    }
  }

  Future<void> cancelNotification() async {
    await notificationsPlugin.cancel(0);
  }

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    var message = 'Current floor is ${currentFloor + 1}';

    await notificationsPlugin.show(0, house.name, message, notificationDetails);

    await notificationsPlugin.periodicallyShow(
        0, house.name, message, RepeatInterval.everyMinute, notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }
}
