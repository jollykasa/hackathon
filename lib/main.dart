import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:care_alert/alarm_clock/view/alarm%20view/alarm_view.dart';
import 'package:care_alert/alarm_clock/view/splash_view/splash_screen.dart';
import 'package:care_alert/home.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
=======
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
>>>>>>> b31bd00082bf91d568911b89cf96baa4c1bf69e8
import 'home.dart';
import 'SplashScreen.dart';
import 'myheaderdrawer.dart';
import 'setting.dart';
import 'history.dart';

<<<<<<< HEAD
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Alarm.init();
=======
void main() async{
  // await AndroidAlarmManager.initialize();
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // // Initialize the notification plugin
  // await initNotifications();

>>>>>>> b31bd00082bf91d568911b89cf96baa4c1bf69e8
  runApp(const MyApp());
}
// Future<void> initNotifications() async {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('app_icon');
//
//   final InitializationSettings initializationSettings =
//   InitializationSettings(
//       android: initializationSettingsAndroid, iOS: null, macOS: null);
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentPage = DrawerSections.home;
  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.home) {
      container = Home();
    } else if (currentPage == DrawerSections.history) {
      container = History();
    } else if (currentPage == DrawerSections.settings) {
      container = Settings();
    } else if (currentPage == DrawerSections.clock) {
      container = MyClock();
    }

    return Scaffold(
      // body: Center(child: widgetList[myIndex]),
      body: container,
      appBar: AppBar(
          iconTheme: IconThemeData(
            size: 30, //change size on your need
            color: Colors.white, //change color on your need
          ),
          backgroundColor: Colors.blueGrey,
          title: Center(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 50,
                  child: Image.asset('assets/images/rem.png'),
                ),
                const Center(
                    child: Text(
                  "Care Alert",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
              ],
            ),
          )),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "History", Icons.dashboard_outlined,
              currentPage == DrawerSections.history ? true : false),
          Divider(),
          menuItem(3, "Settings", Icons.settings,
              currentPage == DrawerSections.settings ? true : false),
          Divider(),
          menuItem(4, "Clock", Icons.access_alarm_outlined,
              currentPage == DrawerSections.settings ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey.shade400 : Colors.transparent,
      child: InkWell(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              if (id == 1) {
                currentPage = DrawerSections.home;
              } else if (id == 2) {
                currentPage = DrawerSections.history;
              } else if (id == 3) {
                currentPage = DrawerSections.settings;
              } else if (id == 4) {
                currentPage = DrawerSections.clock;
              }
            });
          },
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(child: Icon(icon, size: 22)),
                Expanded(
                  flex: 3,
                  child: Text(title, style: TextStyle(fontSize: 18)),
                )
              ],
            ),
          )),
    );
  }
}

class MyClock extends StatelessWidget {
  const MyClock({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteColor: Colors.transparent,
              entryModeIconColor: Colors.pinkAccent,
              dialHandColor: Colors.pinkAccent,
              dialBackgroundColor: Colors.transparent,
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide.none,
              )),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ClockScreen());
  }
}

enum DrawerSections { home, history, settings, clock }
