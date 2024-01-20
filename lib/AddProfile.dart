import 'dart:convert';
import 'dart:io';

import 'package:care_alert/main.dart';
import 'package:flutter/material.dart';
import 'package:care_alert/widgets/CustomWidget.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
class AddProfile extends StatefulWidget {
  const AddProfile({super.key});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  final _formfield = GlobalKey<FormState>();
  var p_name = TextEditingController();
  var p_age = TextEditingController();
  FilePickerResult? result;
  String _filename = "Choose Image";
  File? imagepath;
  String? imagedata;
  ImagePicker imagePicker=ImagePicker();
  @override
  Future<void> insertProfile() async {
    try {
      String uri = "http://10.0.2.2/carealert_api/insertProfile.php";
      var res = await http.post(Uri.parse(uri), body: {
        "p_name": p_name.text,
        "p_age": p_age.text,
        "p_image": _filename,
      });
      print(res.body);
      var response = jsonDecode(res.body);
      if (response["sucess"] == "true") {
        print("Record Inserted successfully");
      } else {
        print("Record Insert Failed");
      }
    } catch (e) {
      print(e);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MainHeader(
          titleName: "Add Profile",
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
                          controller: p_name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Profile Name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter Profile Name',
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
                          controller: p_age,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Age";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter Age',
                              prefixIcon:
                              const Icon(Icons.date_range, color: Colors.black),
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
                            btnName: "Add",
                            bgcolor: Colors.lightGreen,
                            callBack: () {
                              if (_formfield.currentState!.validate()) {
                                insertProfile();
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
