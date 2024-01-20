import 'package:flutter/material.dart';
import 'package:care_alert/SplashScreen.dart';
import 'package:care_alert/home.dart';
import 'package:care_alert/main.dart';
import '../UpdateMedicine.dart';
import 'util.dart';

class MySquareHome extends StatelessWidget {
  final String child;
  final String image;
  MySquareHome({required this.child, required this.image});
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Card(
          elevation: 7,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            height: 300,
            // color: Colors.deepPurple,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/' + image,
                ),
                SizedBox(
                  height: 50,
                ),
                Wrap(children: [Text(child, style: photoTextStyle())]),
              ],
            ),
          ),
        ));
  }
}
// class MedicineDis extends StatelessWidget {
//   final String m_medicine;
//   final String image;
//   final String m_time;
//   final String m_date;
//   MedicineDis({required this.m_medicine, required this.image,required this.m_time, required this.m_date});
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Card(
//           elevation: 7,
//           child: Container(
//             margin: const EdgeInsets.all(10),
//             padding: const EdgeInsets.all(10),
//             height: 190,
//             // color: Colors.deepPurple,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(children:[
//                   Image.asset(
//                     'assets/images/' + image,
//                     width: 90,
//                     height: 100,
//                   ),
//                   SizedBox(
//                     width: 50,
//                     height: 20,
//                   ),
//                   Column(
//                     children: [
//                       Wrap(children: [Text("Medication: "+m_medicine, style: medicineTextStyle())]),
//                       SizedBox(
//                         height: 10,
//                       ),
//                      Wrap(children: [Text("Time: "+m_time, style: medicineTextStyle())]),
//                      SizedBox(
//                        width: 50,
//                      ),
//                      Wrap(children: [Text("Date: "+m_date, style: medicineTextStyle())]),
//                       SizedBox(
//                         width: 50,
//                         height: 15,
//                       ),
//                     ],
//                   )
//                 ])
//               ],
//             ),
//           ),
//         ));
//   }
// }
class MainHeader extends StatelessWidget {
  final String titleName;
  MainHeader({required this.titleName});
  Widget build(BuildContext context) {
    return Row(children: [
      TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(builder: (context) => MyHomePage(title: "flutter")));
          },
          child: SizedBox(
            width: 70,
            height: 50,
            child: Image.asset('assets/images/rem.png'),
          )),
      Center(
        child: Text(
          titleName,
          style: headTextStyle(),
        ),
      ),
    ]);
  }
}
class EButton extends StatelessWidget {
  final String btnName;
  final Icon? icon;
  final Color? bgcolor;
  final VoidCallback? callBack;
  EButton(
      {required this.btnName,
        this.icon,
        this.bgcolor = Colors.blueGrey,
        this.callBack});
  Widget build(BuildContext context) {
    return Container(
        width: 160,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            callBack!();
          },
          child: icon != null
              ? Row(
            children: [
              icon!,
              SizedBox(
                width: 10,
              ),
              Text(btnName, style: TextStyle(color: Colors.white))
            ],
          )
              : Text(btnName, style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
              primary: bgcolor,
              shadowColor: bgcolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(11)))),
        ));
  }
}