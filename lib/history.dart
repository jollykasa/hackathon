import 'package:flutter/material.dart';
import 'package:care_alert/widgets/CustomWidget.dart';
class History extends StatefulWidget{
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Widget build(BuildContext context){
    return Container(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: ((context, index) {
            return Container(
                child: MySquareHome(
                  // child: homedata[index]["h_name"],
                  // image: homedata[index]["h_gallery"]));
                    child: "text",
                    image:"phone.png"));
          })),
    );
  }
}