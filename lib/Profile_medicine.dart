import 'dart:convert';

import 'package:care_alert/AddMedicine.dart';
import 'package:care_alert/local_notifications.dart';
import 'package:care_alert/widgets/util.dart';
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
    // NotificationWidget.init();
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
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          elevation: 7,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            height: 190,
                            // color: Colors.deepPurple,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(children:[
                                  Image.asset(
                                    'assets/images/' + medication[index]["m_image"],
                                    width: 90,
                                    height: 100,
                                  ),
                                  SizedBox(
                                    width: 50,
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      Wrap(children: [
                                        Text("Medication: "+medication[index]["m_medicine"], style: medicineTextStyle())
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Wrap(children: [Text("Time: "+medication[index]["m_time"], style: medicineTextStyle())]),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Wrap(children: [Text("Date: "+medication[index]["m_date"], style: medicineTextStyle())]),
                                      SizedBox(
                                        width: 50,
                                        height: 15,
                                      ),
                                      EButton(
                                          btnName: "Edit",
                                          bgcolor: Colors.blue,
                                          icon: Icon(Icons.update,color: Colors.white,),
                                          callBack: () async{
                                            var prefs = await SharedPreferences.getInstance();
                                            prefs.setString(
                                            "med_id", medication[index]["id"]);
                                            prefs.setString(
                                                "med_name", medication[index]["m_medicine"]);
                                            prefs.setString(
                                                "m_time", medication[index]["m_time"]);
                                            prefs.setString(
                                                "m_date", medication[index]["m_date"]);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateMedicine(),
                                                ));
                                            }),
                                    ],
                                  )
                                ])
                              ],
                            ),
                          ),
                        ));
                    // return Padding(
                    //   padding: const EdgeInsets.all(8),
                    //   child: Card(
                    //     child: Container(
                    //         height: 300,
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Center(
                    //                     child: Icon(
                    //                       Icons.table_restaurant,
                    //                       size: 30,
                    //                     )),
                    //                 SizedBox(width: 30),
                    //                 Center(
                    //                     child: Text(
                    //                       medication[index]["table_name"],
                    //                       style: TextStyle(fontSize: 30),
                    //                     )),
                    //               ],
                    //             ),
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //               children: [
                    //                 EButton(
                    //                     btnName: "Edit Item",
                    //                     bgcolor: Colors.blueGrey,
                    //                     icon: Icon(Icons.edit_sharp),
                    //                     callBack: () {
                    //                       // Navigator.push(
                    //                       //     context,
                    //                       //     MaterialPageRoute(
                    //                       //       builder: (context) =>
                    //                       //           AdminMyHomePage(),
                    //                       //     ));
                    //                     }),
                    //                 // EButton(
                    //                 //   btnName: "Delete",
                    //                 //   bgcolor: Colors.red,
                    //                 //   icon: Icon(Icons.delete),
                    //                 //   callBack: () async {
                    //                 //     var prefs =
                    //                 //     await SharedPreferences.getInstance();
                    //                 //     prefs.setString("tablename",
                    //                 //         (_tables[index]["table_name"]));
                    //                 //     setState(() {
                    //                 //       deleteItem();
                    //                 //       Navigator.pushReplacement(
                    //                 //           context,
                    //                 //           MaterialPageRoute(
                    //                 //             builder: (context) =>
                    //                 //                 AdminTableHome(),
                    //                 //           ));
                    //                 //     });
                    //                 //   },
                    //                 // )
                    //               ],
                    //             ),
                    //           ],
                    //         )),
                    //   ),
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      floatingActionButton:FloatingActionButton(
          backgroundColor: Colors.grey,
          onPressed: () {
             Navigator.of(context, rootNavigator: true).pushReplacement(
                 MaterialPageRoute(builder: (context) => AddMedicine()));
          },
          child: const Icon(Icons.add,size: 30)),
        );
  }
}
