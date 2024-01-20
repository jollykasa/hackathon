import 'package:flutter/material.dart';
class Settings extends StatelessWidget{
  const Settings({super.key});
  @override
  Widget build(BuildContext context){
    var arrNames=["Password Setting","Edit System time","Alarm Ringtone","Timer Ringtone","Additional Alarm Settings"];
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child:const Text("Settings",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)
          ),
          Card(
            elevation: 2,
            child:Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              height: 50,
              width: double.infinity,
              child: const Text("CLOCK SETTINGS",style:TextStyle(fontSize: 20)),
            )
          ),
          Expanded(
            child: ListView.builder(
                itemCount: arrNames.length,
                itemBuilder: ((context, index) {
                  return Container(
                      child:Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            elevation: 7,
                            child: InkWell(
                              onTap:(){

                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                height: 50,
                                // color: Colors.deepPurple,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(arrNames[index], style:const TextStyle(fontSize: 20)),
                                          const Icon(Icons.arrow_forward_ios)]),
                                  ],
                                ),
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