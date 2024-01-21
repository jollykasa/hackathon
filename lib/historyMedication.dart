import 'dart:convert';

import 'package:care_alert/widgets/CustomWidget.dart';
import 'package:care_alert/widgets/util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class HistoryMedication extends StatefulWidget {
  const HistoryMedication({super.key});

  @override
  State<HistoryMedication> createState() => _HistoryMedicationState();
}

class _HistoryMedicationState extends State<HistoryMedication> {
  var h_pname = "";
  List historyDetail = [];
  Future<void> getHistoryDetail() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      var geth_pname = prefs.getString("h_pname");
      h_pname = geth_pname!;
    });
    String uriAccount = "http://10.0.2.2/carealert_api/medicationHistory.php";
    try {
      var response = await http.post(Uri.parse(uriAccount), body: {
        "h_pname": h_pname,
      });
      print(response.body);
      setState(() {
        historyDetail = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }
  void initState() {
    super.initState();
    getHistoryDetail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MainHeader(
          titleName: h_pname,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: ListView.builder(
                itemCount: historyDetail.length,
                itemBuilder: ((context, index) {
                  return Padding(padding: EdgeInsets.only(top: 10),
                    child: Card(
                        child: Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/images/' + historyDetail[index]["h_image"],
                                  width: 90,
                                  height: 90,
                                ),
                                Column(
                                  children: [
                                    Text("Med-Name: "+historyDetail[index]["h_medicine"],style: medicineTextStyle(),),
                                    Text("Med-time: "+historyDetail[index]["h_time"],style: medicineTextStyle(),),
                                    Text("Med-date: "+historyDetail[index]["h_date"],style: medicineTextStyle(),),
                                  ],
                                )
                              ],
                            ),
                          )
                        )),
                  );
                })),
          ),
        ],
      ),
    );
  }
}
