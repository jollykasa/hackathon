import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
class NotificationWidget{
  static final _notifications=FlutterLocalNotificationsPlugin();

    static Future init({bool scheduled=false})async{
    var initAndroidSettings=AndroidInitializationSettings('@mipmap/ic_launcher');
    // var ios=IOSInitializationSettings();
    final settings= InitializationSettings(android:initAndroidSettings);
    await _notifications.initialize(settings);
    }


  static Future showNotification({
    var id=0,
    var title,
    var body,
    var payload
})async=> _notifications.show(id,title,body,await notificationDetails());
  static Future showScheduleNotification({
    var id=0,
    var title,
    var body,
    var payload,
    required DateTime scheduleTime
  })async=> _notifications.zonedSchedule(id,title,body,
      tz.TZDateTime.from(scheduleTime,tz.local),
      await notificationDetails(),
    payload:payload,
  androidAllowWhileIdle: true,
  uiLocalNotificationDateInterpretation:
  UILocalNotificationDateInterpretation.absoluteTime);

  static notificationDetails() async{
    return NotificationDetails(
      android:AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max
      ),
        // iOS:IOSNotificationDetails()
    );
  }}