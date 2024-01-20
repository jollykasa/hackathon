import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  State<SplashScreen> createState()=> _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin{
  @override
  late Animation colorAnimation;
  late Animation colortextAnimation;
  late AnimationController animationController;
  bool isFirst=true;

  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    colorAnimation =
        ColorTween(begin: Colors.blueGrey, end: const Color(0xff99A799))
            .animate(animationController);
    colortextAnimation = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
    Timer(Duration(seconds: 2), () {
      reload();
    });
    whereToGo();
  }
  void reload() {
    setState(() {
      isFirst=false;
    });
  }
  Widget build(BuildContext context){
    return Scaffold(
        body: Container(
            color: colorAnimation.value,
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedCrossFade(
                        firstChild: Image.asset('assets/images/rem2.png',width: 300,height: 400,),
                        secondChild: Image.asset('assets/images/rem.png',width: 300,height: 400,),
                        crossFadeState: isFirst? CrossFadeState.showFirst: CrossFadeState.showSecond ,
                        duration: Duration(seconds: 2)),
                    Text("Care Alert",style:TextStyle(fontSize:50,fontWeight:FontWeight.bold,color: colortextAnimation.value),),
                  ],
                ))));
  }
  void whereToGo() async {
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'Flutter')));
    });
  }
}