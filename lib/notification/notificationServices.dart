import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../modals/task.dart';

class NotifyHelper{
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    _configureLocalTimeZone();
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );


    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("appicon");

      final InitializationSettings initializationSettings =InitializationSettings(
      iOS: initializationSettingsIOS,
      android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: selectNotification
    );

  }

  Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    Get.dialog(
      const Text("Notification Fluter")
    );
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      if (kDebugMode) {
        print('notification payload: $payload');
      }
    } else {
      if (kDebugMode) {
        print("Notification Done");
      }
    }
    Get.to(()=>Container(color: Colors.white,child: const Center(child: Padding(
      padding: EdgeInsets.all(18.0),
      child: Text("You Navigate Here By Clicking\nOn Top Notification",style: TextStyle(fontSize: 24,color: Colors.black,decoration: TextDecoration.none),),
    ),),));
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  displayNotification({required String? title, required String? body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        "your channel id",
        "your channel name",
        channelDescription: "your channel description",
        importance: Importance.max,
        priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  scheduledNotification(int hour,  int mint, Tasks tasks) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        tasks.id!.toInt(),
        tasks.title.toString(),
        tasks.note.toString(),
        _convertTime(hour,mint),
        payload: 'Default_Sound',
        const NotificationDetails(
            android: AndroidNotificationDetails(
              'your channel id',
              'your channel name',
              channelDescription: 'your channel description',
              color: Colors.blue,
              playSound: true,
              sound: RawResourceAndroidNotificationSound("notification_sound"),
            )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time
    );

  }
  // 2023-03-12 18:22:34.264621Z
  tz.TZDateTime _convertTime(int hour, int mint){
    print("HOUR ::. $hour MINT ::. $mint");
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, mint);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    print("$now NOW NOW");
    print("$scheduleDate SCHEDULE SCHEDULE");
    return scheduleDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    print("TIME ZONE ::. $timeZoneName");
  }
}