import 'package:flutter/material.dart';
class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black87,
        width: double.infinity,
        height: 200,
        padding: const EdgeInsets.only(top:20.0),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Container(
            margin: const EdgeInsets.only(bottom:10),
            height: 70,
            decoration: const BoxDecoration(
                shape:BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                    image:AssetImage('assets/images/phone.png'))),
          ),
            const Text("Care Alert",
                style:TextStyle(color:Colors.white,fontSize:20)
            ),
          ],
        )
    );
  }
}
