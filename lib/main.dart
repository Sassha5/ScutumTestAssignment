import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'src/app.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();

  //Get plugin instance
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //Initialize the notifications
  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
        iOS: initializationSettingsDarwin,
        android: const AndroidInitializationSettings('mipmap/ic_launcher')),
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {
      //Action on notification tap in foreground to be added
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
  //Request Android specific permissions for notifications to work correctly
  await androidImplementation?.requestNotificationsPermission();

  runApp(const MyApp());
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  //Action to be added
}

//iOS placeholder notification settings
final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
  notificationCategories: [
    DarwinNotificationCategory(
      'demoCategory',
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          'id_3',
          'Action 3',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ],
);
