import 'dart:convert';
import 'dart:io';

import 'package:care_alert/Profile_medicine.dart';
import 'package:care_alert/main.dart';
import 'package:flutter/material.dart';
import 'package:care_alert/widgets/CustomWidget.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:care_alert/widgets/util.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final materialDateButtonKey = UniqueKey();
final materialTimeButtonKey = UniqueKey();
final materialDateTimeButtonKey = UniqueKey();
class UpdateMedicine extends StatefulWidget {
  const UpdateMedicine({super.key});
  @override
  State<UpdateMedicine> createState() => _UpdateMedicineState();
}

class _UpdateMedicineState extends State<UpdateMedicine> {
  DateTime dateTime = DateTime.now();
  int counter = 0;
  var time,date;
  /// Opens date picker and returns possible `DateTime` object.
  Future<DateTime?> pickDate() => showDatePicker(context: context, initialDate: dateTime, firstDate: DateTime(1900), lastDate: DateTime(2100));

  /// Opens time picker and returns possible `TimeOfDay` object.
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      });

  /// Opens date picker and time picker consecutively and sets the `DateTime` field of the page.
  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return; // pressed 'CANCEL'

    TimeOfDay? time = await pickTime();
    if (time == null) return; // pressed 'CANCEL'

    // Update datetime object that's shown with new date
    final newDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      dateTime = newDateTime;
      counter = counter + 1;
    });
  }
  final _formfield = GlobalKey<FormState>();
  var m_name = TextEditingController();
  // var m_time = TextEditingController();
  // var m_date=TextEditingController();
  FilePickerResult? result;
  String _filename = "Choose Image";
  File? imagepath;
  String? imagedata;
  ImagePicker imagePicker=new ImagePicker();
  @override
  var med_id = "";
  var med_name="";
  var m_time="";
  var m_date="";
  Future<void> updateMedicine() async {
    // var time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      var getMed_id = prefs.getString("med_id");
      med_id = getMed_id!;
    });
    // print(med_id+" "+m_name.text+" "+time+" "+" "+date);
    try {
      String uri = "http://10.0.2.2/carealert_api/updateMedicine.php";
      var res = await http.post(Uri.parse(uri), body: {
        "id": med_id,
        "m_name": m_name.text,
        "m_time":time,
        "m_date":date,
        "m_image": _filename,
      });
      // print(res.body);
      var response = jsonDecode(res.body);
      if (response["sucess"] == "true") {
        print("Record successfully Updated");
      } else {
        print("Record Failed to Update");
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> getMed() async {
    // var time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      var getmed_name = prefs.getString("med_name");
      med_name = getmed_name!;
      var getm_time = prefs.getString("m_time");
      m_time = getm_time!;
      var getm_date = prefs.getString("m_date");
      m_date = getm_date!;
    });
  }

  void initState() {
    // t_id.text = widget.t_id;
    // o_quantity.text = widget.o_quantity;
    getMed();
    super.initState();
  }

  Future<void> getImage() async {
    var getimage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagepath = File(getimage!.path);
      print(imagepath);
    });
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      setState(() {
        _filename = result!.files.first.name;
        print(_filename);
      });
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MainHeader(
          titleName: "Edit Medicine",
          // titleName: med_name,
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: ((context, index) {
            return Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              child: Container(
                child: Form(
                  key: _formfield,
                  child: Column(
                    children: [
                      SizedBox(
                        child: TextFormField(
                          controller: m_name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Medicine Name";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: med_name,
                              prefixIcon: Icon(Icons.person,
                                  color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                  BorderSide(color: Colors.blue, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide:
                                BorderSide(color: Colors.black, width: 2),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // date=DateFormat('yyyy-MM-dd').format(dateTime),
                            date=m_date,
                            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            time=DateFormat(' kk:mm').format(dateTime),
                            // time=m_time,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    key: materialDateButtonKey,
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                    child: const Text(
                                      "Date",
                                      style: TextStyle(fontSize: 20,color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      final newDate = await pickDate();
                                      if (newDate == null) return; // person pressed 'CANCEL'

                                      // Update datetime object that's shown with new date
                                      final newDateTime = DateTime(newDate.year, newDate.month, newDate.day, dateTime.hour, dateTime.minute);
                                      setState(() {
                                        dateTime = newDateTime;
                                        counter = counter + 1;
                                      });
                                    }),
                                ElevatedButton(
                                    key: materialTimeButtonKey,
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                    child: const Text(
                                      "Time",
                                      style: TextStyle(fontSize: 20,color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      final newTime = await pickTime();
                                      if (newTime == null) return; // person pressed 'CANCEL'

                                      // Update datetime object that's shown with new time
                                      final newDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, newTime.hour, newTime.minute);
                                      setState(() {
                                        dateTime = newDateTime;
                                        counter = counter + 1;
                                      });
                                    })
                              ])),

                      SizedBox(
                        height: 30,
                      ),
                      imagepath != null
                          ? Image.file(imagepath!)
                          : Text("Image Not Choose Yet"),
                      Container(
                        width: 200,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            getImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.image_outlined,color: Colors.white,),
                              Text(_filename,style: TextStyle(color: Colors.white),),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(11)))),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: SizedBox(
                          child: EButton(
                            btnName: "Edit",
                            bgcolor: Colors.lightGreen,
                            callBack: () {
                              if (_formfield.currentState!.validate()) {
                                updateMedicine();
                                setState(() {
                                  Navigator.of(context, rootNavigator: true).pushReplacement(
                                      MaterialPageRoute(builder: (context) => ProfileMedicine()));
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}
