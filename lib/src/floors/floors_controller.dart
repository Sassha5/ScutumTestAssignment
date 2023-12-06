import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scutum_test_assignment/src/houses/house.dart';

/// Controllers glue Data Services to Flutter Widgets.
/// The FloorsController holds house state and manages notifications
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

      while (currentFloor != targetFloor) { //Move lift gradually 1 floor per second instead of teleporting
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

    await notificationsPlugin.show(0, house.name, message, notificationDetails); //Show notification when the lift arrives right away

    await notificationsPlugin.periodicallyShow( //Schedule notification to show later
        0, house.name, message, RepeatInterval.everyMinute, notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }
}
