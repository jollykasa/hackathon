import 'dart:convert';
import 'dart:io';

import 'package:care_alert/main.dart';
import 'package:flutter/material.dart';
import 'package:care_alert/widgets/CustomWidget.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:care_alert/widgets/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UpdateMedicine extends StatefulWidget {
  const UpdateMedicine({super.key});

  @override
  State<UpdateMedicine> createState() => _UpdateMedicineState();
}

class _UpdateMedicineState extends State<UpdateMedicine> {
  final _formfield = GlobalKey<FormState>();
  var m_name = TextEditingController();
  var m_time = TextEditingController();
  var m_date=TextEditingController();
  FilePickerResult? result;
  String _filename = "Choose Image";
  File? imagepath;
  String? imagedata;
  ImagePicker imagePicker=new ImagePicker();
  @override
  var med_id = "";
  var pretable_id = "";
  Future<void> updateMedicine() async {
    // var time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      var getMed_id = prefs.getString("med_id");
      med_id = getMed_id!;
      // var getPertable = prefs.getString("pretableid");
      // pretable_id = getPertable!;
    });
    try {
      String uri = "http://10.0.2.2/carealert_api/updateMedicine.php";
      var res = await http.post(Uri.parse(uri), body: {
        "id": med_id,
        "m_name": m_name.text,
        "o_quantity": m_time.text,
        "table_id": m_date.text,
        "time": _filename,
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

  // void initState() {
  //   t_id.text = widget.t_id;
  //   o_quantity.text = widget.o_quantity;
  //   super.initState();
  // }

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
                              hintText: 'Enter Medicine Name',
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
                      SizedBox(
                        child: TextFormField(
                          controller: m_time,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Time";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter Time',
                              prefixIcon:
                              Icon(Icons.timelapse, color: Colors.black),
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
                      SizedBox(
                        child: TextFormField(
                          controller: m_date,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Date";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter Date',
                              prefixIcon: Icon(Icons.date_range,
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
                      imagepath != null
                          ? Image.file(imagepath!)
                          : Text("Image Not Choose Yet"),
                      Container(
                        width: 170,
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
                                      MaterialPageRoute(builder: (context) => MyHomePage(title: "flutter")));
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
