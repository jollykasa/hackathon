import 'dart:async';
import 'package:care_alert/alarm_clock/res/constants.dart';
import 'package:care_alert/alarm_clock/view/common_widget/soft_button.dart';
import 'package:care_alert/alarm_clock/view/home_view/home_view.dart';
import 'package:care_alert/alarm_clock/view_model/bloc/home%20bloc/home%20bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<ClockScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => HomeBloc(),
              child: const HomeScreen(),
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: CircularSoftButton(
            radius: 60,
            icon: Center(
                child: SvgPicture.asset(
              'assets/icons/clock.svg',
              height: 35,
              width: 35,
              color: Colors.pinkAccent,
            ))),
      ),
    );
  }
}
