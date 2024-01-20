import 'dart:convert';

import 'package:care_alert/AddProfile.dart';
import 'package:flutter/material.dart';
import 'package:care_alert/widgets/CustomWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Profile_medicine.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List profiles = [];
  Future<void> getprofilerecord() async {
    String uri = "http://10.0.2.2/carealert_api/viewProfile.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        profiles = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }
  void initState() {
    super.initState();
    getprofilerecord();
  }
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: profiles.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                      onTap: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString("profile_name", profiles[index]["p_name"]);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileMedicine(),
                            ));
                      },
                      child: MySquareHome(
                          child: profiles[index]["p_name"],
                          image: profiles[index]["p_image"]));
                })),
          ),
          // Container(
          //     color: Colors.black26,
          //     child: EButton(
          //       btnName: "Add Profile",
          //       icon: Icon(Icons.person,color: Colors.white,),
          //       callBack: () {
          //         Navigator.of(context, rootNavigator: true).push(
          //             MaterialPageRoute(builder: (context) => AddProfile()));
          //       },
          //     ))
        ],
      ),
      floatingActionButton:FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) => AddProfile()));
          },
          child: const Icon(Icons.add,size: 30)),
    );
  }
}