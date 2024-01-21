import 'dart:convert';

import 'package:care_alert/historyMedication.dart';
import 'package:flutter/material.dart';
import 'package:care_alert/widgets/CustomWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class History extends StatefulWidget{
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List historydata = [];
  Future<void> gethistoryrecord() async {
    String uri = "http://10.0.2.2/carealert_api/profileHistory.php";
    try {
      var response = await http.get(Uri.parse(uri));
      // print(response.body);
      setState(() {
        historydata = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }
  void initState() {
    super.initState();
    gethistoryrecord();
  }
  Widget build(BuildContext context){
    return Scaffold(
      body:Column(
        children: [
          Container(
              padding: EdgeInsets.only(top:8.0,bottom: 8.0),
              child:Text("History",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)
          ),
          Expanded(
            child: ListView.builder(
                itemCount: historydata.length,
                itemBuilder: ((context, index) {
                  return Container(
                    width: double.infinity,
                      child:Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Card(
                            elevation: 7,
                            child: Container(
                              margin: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                              padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                              height: 100,
                              // color: Colors.deepPurple,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    'assets/images/' + historydata[index]["h_pimage"],
                                    width: 90,
                                    height: 90,
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(historydata[index]["h_pname"], style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        EButton(btnName: "View",
                                        bgcolor: Colors.deepPurple,
                                        icon: Icon(Icons.view_comfy_alt_sharp,color: Colors.white,),
                                          callBack: () async {
                                          var prefs = await SharedPreferences.getInstance();
                                          prefs.setString(
                                          "h_pname", historydata[index]["h_pname"]);
                                          Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                          builder: (context) => HistoryMedication(),
                                          ));
                                          },)
                                      ]),
                                ],
                              ),
                            ),
                          )));
                })),
          ),
        ],
      ),
    );
  }
}
