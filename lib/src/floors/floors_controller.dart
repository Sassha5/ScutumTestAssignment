import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scutum_test_assignment/src/houses/house.dart';

class FloorsController with ChangeNotifier {
  FloorsController(this.house);

  final House house;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');
  }
}
