import 'dart:io';

import 'package:care_alert/home.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'SplashScreen.dart';
import 'myheaderdrawer.dart';
import 'setting.dart';
import 'history.dart';

void main() async {
  runApp(const MyApp());
}

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
      home: SplashScreen(),
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

enum DrawerSections { home, history, settings }
