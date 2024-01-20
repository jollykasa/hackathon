import 'dart:convert';
import 'dart:io';

import 'package:care_alert/main.dart';
import 'package:flutter/material.dart';
import 'package:care_alert/widgets/CustomWidget.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
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
  ImagePicker imagePicker=ImagePicker();
  @override
  var med_id = "";
  var pretable_id = "";
  Future<void> updateMedicine() async {
    // var time = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      var getmedId = prefs.getString("med_id");
      med_id = getmedId!;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MainHeader(
          titleName: "Edit Medicine",
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: ((context, index) {
            return Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(10),
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
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter Medicine Name',
                              prefixIcon: const Icon(Icons.person,
                                  color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                  const BorderSide(color: Colors.blue, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                              )),
                        ),
                      ),
                      const SizedBox(
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
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter Time',
                              prefixIcon:
                              const Icon(Icons.timelapse, color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                  const BorderSide(color: Colors.blue, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        child: TextFormField(
                          controller: m_date,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Date";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter Date',
                              prefixIcon: const Icon(Icons.date_range,
                                  color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide:
                                  const BorderSide(color: Colors.blue, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide:
                                const BorderSide(color: Colors.black, width: 2),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      imagepath != null
                          ? Image.file(imagepath!)
                          : const Text("Image Not Choose Yet"),
                      SizedBox(
                        width: 170,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            getImage();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(11)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.image_outlined,color: Colors.white,),
                              Text(_filename,style: const TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
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
                                      MaterialPageRoute(builder: (context) => const MyHomePage(title: "flutter")));
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
