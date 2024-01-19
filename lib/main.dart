import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
bool _iconBool=false;
IconData _iconLight=Icons.wb_sunny;
IconData _iconDark=Icons.nights_stay;

ThemeData _lightTheme= ThemeData(
  primarySwatch:Colors.deepPurple,
  brightness:Brightness.light,
  colorScheme: ColorScheme.light(),
  buttonTheme: const ButtonThemeData(buttonColor: Colors.blueAccent)
);
ThemeData _darkTheme= ThemeData(
  primarySwatch:Colors.blueGrey,
  brightness:Brightness.dark,
  colorScheme: ColorScheme.dark(),
  // 7
);
class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: _iconBool? _darkTheme:_lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child:Image.asset('assets/images/rem.png'),
              ),
              SizedBox(
                width: 30,
              ),
              const Center(child: Text("Care Alert",style: TextStyle(fontSize: 20),)),
            ],
          ),
          actions: [
            IconButton(onPressed: (){
                setState(() {
                  _iconBool=!_iconBool;
                });
            },
                icon: Icon(_iconBool? _iconDark:_iconLight))
          ],
        ),
        body:Container(
         child: Center(child: Text("Hello",style: TextStyle(fontSize: 30),)),
        ) ,
        //floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.grey,
          child: const Icon(Icons.add,size: 30),
        ),
      ),
    );
  }
}
