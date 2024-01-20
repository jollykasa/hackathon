import 'dart:convert';

import 'package:care_alert/AddMedicine.dart';
import 'package:flutter/material.dart';
import 'package:care_alert/widgets/CustomWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'AddProfile.dart';
import 'UpdateMedicine.dart';
class ProfileMedicine extends StatefulWidget {
  const ProfileMedicine({super.key});

  @override
  State<ProfileMedicine> createState() => _ProfileMedicineState();
}

class _ProfileMedicineState extends State<ProfileMedicine> {
  List medication = [];
  var profile_name = "";

  Future<void> getmedicinerecord() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      var getprofile_name = prefs.getString("profile_name");
      profile_name = getprofile_name!;
    });
    String uri = "http://10.0.2.2/carealert_api/viewMedicine.php";
    try {
    // print(profile_name);
      var response = await http.post(Uri.parse(uri), body: {
        "profile_name": profile_name,
      });
      print(response.body);
      setState(() {
        medication = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }
  void initState() {
    super.initState();
    getmedicinerecord();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: MainHeader(
    titleName: profile_name,
    ),
    backgroundColor: Colors.blueGrey,
    ),
        body:Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: medication.length,
                    itemBuilder: ((context, index) {
                      return Container(
                          child: MedicineDis(
                              m_medicine: medication[index]["m_medicine"],
                              m_time: medication[index]["m_time"],
                              m_date: medication[index]["m_date"],
                              image:medication[index]["m_image"]));
                    })),
              ),
              ElevatedButton(onPressed: (){
                Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(builder: (context) => UpdateMedicine()));
              }, child: Text("Update",style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shadowColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(11)))))
            ],
          ),
        ),
      floatingActionButton:FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: () {
             Navigator.of(context, rootNavigator: true).push(
                 MaterialPageRoute(builder: (context) => AddMedicine()));
          },
          child: const Icon(Icons.add,size: 30)),
        );
  }
}
// var prefs = await SharedPreferences.getInstance();
// prefs.setString(
// "tablenum", medication[index]["id"]);